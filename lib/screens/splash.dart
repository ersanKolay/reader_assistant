import 'package:flutter_tts/flutter_tts.dart';
import 'package:reading_assistant/screens/reader_page.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class MySplash extends StatefulWidget {
  @override
  _MySplashState createState() => _MySplashState();
}

class _MySplashState extends State<MySplash> {
  FlutterTts _flutterTts = FlutterTts();
  openingCeremony() async {
    await _flutterTts.setPitch(1);
    await _flutterTts.setLanguage("tr-TR");
    await _flutterTts.speak("Uygulama başlatılıyor");
  }

  @override
  void initState() {
    openingCeremony();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 2,
      navigateAfterSeconds: ReaderPage(),
      title: Text(
        'Reader Assistant',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30,
          color: Colors.white,
        ),
      ),
      image: Image.asset('assets/logo.png'),
      photoSize: 50.0,
      gradientBackground: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0.004, 1],
        colors: [
          Color(0xFFa8e063),
          Color(0xFF56ab2f),
        ],
      ),
      loaderColor: Colors.white,
    );
  }
}
