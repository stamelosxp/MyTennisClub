import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mytennisclub/coach_app_android/coach_home_page.dart';
import 'package:mytennisclub/secretary_android_app/secretary_home.dart';
import 'package:mytennisclub/guest_android_app/guest_home_page.dart';
import 'package:mytennisclub/member_android_app/member_home_page.dart';
import 'package:mytennisclub/athlete_android_app/athlete_home_page.dart';

void main() => runApp(const MainClass());

class MainClass extends StatefulWidget {
  const MainClass({super.key});

  @override
  State<MainClass> createState() => Main_Class();
}

class Main_Class extends State<MainClass> {
  @override
  Widget build(BuildContext context) {
    //the screen can't be rotated
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
        initialRoute: '/',
        routes: {
          '/guest_home': (context) => const GuestHomePage(),
          '/athlete_home': (context) => const AthleteHomePage(),
          '/coach_home': (context) => const CoachHomePage(),
          '/member_home': (context) => const MemberHomePage()
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(0, 83, 135, 1),
          ),
        ),
        home: const MainRoute());
  }
}

class MainRoute extends StatelessWidget {
  const MainRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(330, 30),
                  backgroundColor: const Color.fromRGBO(60, 111, 159, 1),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Secretary_Scan()),
                  );
                },
                child: const Text(
                  "Secretary Home Page ",
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(330, 30),
                  backgroundColor: const Color.fromRGBO(60, 111, 159, 1),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/athlete_home');
                },
                child: const Text(
                  "Athlete App",
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(330, 30),
                  backgroundColor: const Color.fromRGBO(60, 111, 159, 1),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/member_home');
                },
                child: const Text(
                  "Member App",
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(330, 30),
                  backgroundColor: const Color.fromRGBO(60, 111, 159, 1),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/guest_home');
                },
                child: const Text(
                  "Guest App",
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(330, 30),
                    backgroundColor: const Color.fromRGBO(60, 111, 159, 1),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/coach_home');
                  },
                  child: const Text(
                    "Coach App",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class DummyScreen extends StatelessWidget {
  const DummyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Dummy Screen'),
    );
  }
}
