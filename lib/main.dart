import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meal_mentor/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meal Mentor',
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late String randomQuote;
  void initState(){
  super.initState();
  randomQuote = quotes[Random().nextInt(quotes.length)];
    Timer(
    Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }
  final List<String> quotes = [
    "Nourish your body, fuel your life.",
    "Discover the power of food, one meal at a time.",
    "Your guide to better eating, healthier living.",
    "Where nutrition meets convenience.",
    "Empowering you to make smarter food choices.",
    "A healthier you starts with the right meal.",
    "Fuel your journey with knowledge, one bite at a time.",
    "Eating well begins with understanding.",
    "Craft your meals, master your health.",
    "Transform your eating habits, transform your life.",
    "Know what you eat, love how you feel."
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.all(15),
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/bg.jpeg"), fit: BoxFit.cover)),
          child: Column(
            children: [
              Spacer(),
              Image.asset("assets/logo.png"),
              Text(
                "Meal Mentor",
                style: GoogleFonts.deliusSwashCaps(
                    fontSize: 30, fontWeight: FontWeight.bold),
              ),
              AnimatedTextKit(
                isRepeatingAnimation: false,
                animatedTexts: [
                  TyperAnimatedText(
                  randomQuote,
                    textStyle: GoogleFonts.princessSofia(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Spacer(),
              Spacer(),
              Spacer(),
              Text(
                "Know Your Meal",
                style: GoogleFonts.deliusSwashCaps(
                    fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ],
          )),
    );
  }
}

// class Cards extends StatelessWidget {
//   final String imagepath;
//   const Cards({super.key,required this.imagepath});
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 10,
//       shape: RoundedRectangleBorder(
//           borderRadius:
//           BorderRadius.circular(20)
//       ),
//       child: Container(
//         height: MediaQuery.of(context).size.height*0.2,
//         width: MediaQuery.of(context).size.height*0.2,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20), // Match the Card's borderRadius
//             image: DecorationImage(image: AssetImage(imagepath),
//                 fit: BoxFit.cover)
//         ),
//       ),
//     );
//   }
// }
