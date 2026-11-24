import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const primary = Color(0xFFD7263D);
  static const primarySoft = Color(0xFFFDE8EA);
  static const background = Color(0xFFFFF8F5);
  static const card = Colors.white;
  static const ink = Color(0xFF1E1A2E);
  static const muted = Color(0xFF7A7485);
  static const border = Color(0xFFEDE3E0);
  static const secondary = Color(0xFFF7EFEC);
  static const success = Color(0xFF2E9E6A);
  static const successSoft = Color(0xFFE2F5EB);
}

ThemeData buildTheme() {
  final base = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
    ),
    scaffoldBackgroundColor: AppColors.background,
  );
  return base.copyWith(
    textTheme: GoogleFonts.nunitoTextTheme(base.textTheme).copyWith(
      headlineMedium: GoogleFonts.fredoka(
        fontSize: 26,
        fontWeight: FontWeight.w600,
        color: AppColors.ink,
      ),
      titleLarge: GoogleFonts.fredoka(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.ink,
      ),
    ),
  );
}

class Hemo {
  static const nome = 'Hemocentro da Paraíba';
  static const endereco = 'Av. Dom Pedro II, 1548';
  static const cidade = 'João Pessoa – PB';
  static const telefone = '(83) 3133-3473';
  static const horario = 'Seg–Sex 7h às 18h · Sáb 7h às 13h';
}

DateTime proximaDoacao(DateTime ultima, {required bool homem}) =>
    ultima.add(Duration(days: homem ? 60 : 90));
