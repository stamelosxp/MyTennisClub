import 'package:flutter/material.dart';

class Select_Athletes extends StatefulWidget {
  final int number;
  final List<Map<String, dynamic>> selectedAthletes;
  final List<Map<String, dynamic>> athletesList;
  final Function checkAthletes;
  const Select_Athletes({
    required this.athletesList,
    required this.selectedAthletes,
    required this.number,
    required this.checkAthletes,
    super.key,
  });

  @override
  State<Select_Athletes> createState() => SelectAthletes();
}

class SelectAthletes extends State<Select_Athletes> {
  final TextEditingController _searchController = TextEditingController();
  late List<Map<String, dynamic>> athleteList;
  List<Map<String, dynamic>> _filteredData = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    athleteList = widget.athletesList;
    for (int index = 0; index < widget.selectedAthletes.length; index++) {
      if (athleteList.contains(widget.selectedAthletes[index])) {
        athleteList.remove(widget.selectedAthletes[index]);
        athleteList.insert(0, widget.selectedAthletes[index]);
      }
    }
    _filteredData = athleteList;
    _searchController.addListener(_performSearch);
  }

  Future<void> _performSearch() async {
    setState(() {
      _isLoading = true;
    });

    // Simulates waiting for an API call
    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      _filteredData = athleteList
          .where((element) =>
              element['user_first_name']
                  .toLowerCase()
                  .contains(_searchController.text.toLowerCase()) ||
              element['user_last_name']
                  .toLowerCase()
                  .contains(_searchController.text.toLowerCase()))
          .toList();
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(248, 249, 255, 1),
            ),
          ),
          title: TextField(
            controller: _searchController,
            style: const TextStyle(color: Color.fromRGBO(29, 27, 32, 0.7)),
            cursorColor: const Color.fromRGBO(29, 27, 32, 0.7),
            decoration: InputDecoration(
              hintText: 'Search...',
              hintStyle:
                  const TextStyle(color: Color.fromRGBO(29, 27, 32, 0.7)),
              border: InputBorder.none,
              suffixIcon: IconButton(
                onPressed: () {
                  _searchController.clear();
                },
                icon: const Icon(Icons.clear),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: _isLoading
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selected: ${widget.selectedAthletes.length}/${widget.number}',
                        textAlign: TextAlign.start,
                      ),
                      ListView.builder(
                        primary: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _filteredData.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) =>
                            Container(
                          padding: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                              border: const Border(
                                bottom: BorderSide(
                                    color: Color.fromRGBO(29, 27, 32, 0.574)),
                              ),
                              color: (widget.selectedAthletes
                                      .contains(_filteredData[index]))
                                  ? const Color.fromRGBO(210, 230, 255, 2)
                                  : Colors.transparent),
                          child: ListTile(
                            trailing: (widget.selectedAthletes
                                    .contains(_filteredData[index]))
                                ? const Text('Delete')
                                : const Text(''),
                            onTap: () {
                              if (widget.selectedAthletes
                                  .contains(_filteredData[index])) {
                                setState(() {
                                  widget.selectedAthletes
                                      .remove(athleteList[index]);
                                });
                              } else if (!widget.selectedAthletes
                                      .contains(_filteredData[index]) &&
                                  widget.selectedAthletes.length <
                                      widget.number) {
                                setState(() {
                                  Map<String, dynamic> athlete =
                                      _filteredData[index];
                                  _filteredData.removeAt(index);
                                  _filteredData.insert(0, athlete);

                                  widget.selectedAthletes.add(athlete);
                                });
                              }
                            },
                            leading: CircleAvatar(
                              radius: 18,
                              backgroundColor: (!widget.selectedAthletes
                                      .contains(_filteredData[index]))
                                  ? const Color.fromRGBO(50, 121, 180, 1)
                                  : const Color.fromRGBO(52, 75, 98, 1),
                              child: (!widget.selectedAthletes
                                      .contains(_filteredData[index]))
                                  ? Text(
                                      '${athleteList[index]['user_first_name'][0]}${athleteList[index]['user_last_name'][0].toUpperCase()}',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    )
                                  : const Icon(Icons.check,
                                      size: 20, color: Colors.white),
                            ),
                            title: Text(
                              '${_filteredData[index]['user_first_name']} ${_filteredData[index]['user_last_name']}',
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: const Color.fromRGBO(50, 121, 180, 1),
          label: const Text.rich(TextSpan(children: <InlineSpan>[
            WidgetSpan(
              child: Icon(
                Icons.check,
                size: 18,
                color: Colors.white,
              ),
            ),
            TextSpan(
              text: '  Save',
              style: TextStyle(color: Colors.white),
            )
          ])),
          onPressed: () {
            widget.checkAthletes(widget.selectedAthletes);
            Navigator.of(context).pop(widget.selectedAthletes);
          },
        ),
      ),
    );
  }
}
