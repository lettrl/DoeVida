import 'package:flutter/material.dart';
import 'theme.dart';
import 'screens/welcome_screen.dart';

void main() => runApp(const DoeVidaApp());

class DoeVidaApp extends StatelessWidget {
  const DoeVidaApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'DoeVida',
        debugShowCheckedModeBanner: false,
        theme: buildTheme(),
        home: const WelcomeScreen(),
      );
}
