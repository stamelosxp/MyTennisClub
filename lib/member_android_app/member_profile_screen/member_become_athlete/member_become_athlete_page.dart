import 'package:flutter/material.dart';
import 'package:mytennisclub/member_android_app/member_profile_screen/member_become_athlete/upload_files.dart';
import 'package:mytennisclub/member_android_app/member_profile_screen/member_become_athlete/success_page.dart';
import 'package:mytennisclub/member_android_app/member_profile_screen/member_become_athlete/personal_info.dart';

class MemberBecomeAthlete extends StatefulWidget {
  final List memberInfo;
  const MemberBecomeAthlete({required this.memberInfo, super.key});

  @override
  State<MemberBecomeAthlete> createState() => _MemberBecomeAthleteState();
}

class _MemberBecomeAthleteState extends State<MemberBecomeAthlete> {
  bool uploadsCheck = false;
  bool submitEnabled = false;

  checkUpload(check) {
    setState(() {
      uploadsCheck = true;
      submitEnabled = true;
    });
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(248, 249, 255, 1),
          title: const Row(
            children: [
              Text('Become Athlete',
                  style:
                      TextStyle(fontWeight: FontWeight.normal, fontSize: 22)),
            ],
          ),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const PersonalInfo(),
                      const Divider(
                        color: Color.fromRGBO(193, 199, 209, 1),
                      ),
                      UploadFiles(
                        checkUpload: checkUpload,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Spacer(),
                  Expanded(
                    flex: 3,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                  ),
                  const Spacer(),
                  (submitEnabled)
                      ? Expanded(
                          flex: 3,
                          child: FilledButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const Success_Page(),
                                ),
                              );
                            },
                            child: const Text('Submit'),
                          ),
                        )
                      : Expanded(
                          flex: 3,
                          child: FilledButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all<Color>(
                                  const Color.fromRGBO(24, 28, 32, 0.12)),
                            ),
                            child: const Text(
                              'Submit',
                              style: TextStyle(
                                  color: Color.fromRGBO(29, 27, 32, 0.6)),
                            ),
                          ),
                        ),
                  const Spacer(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
