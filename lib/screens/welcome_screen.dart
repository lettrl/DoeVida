import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/common.dart';
import 'signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: const Icon(Icons.water_drop, color: Colors.white, size: 40),
              ),
              const SizedBox(height: 16),
              Text('DoeVida', style: Theme.of(context).textTheme.headlineMedium),
              const Text(
                'Doação de sangue em João Pessoa',
                style: TextStyle(color: AppColors.muted),
              ),
              const SizedBox(height: 24),
              const InfoLine(
                Icons.event_available,
                'Agende sua doação',
                'Escolha dia e horário livres no hemocentro.',
              ),
              const SizedBox(height: 10),
              const InfoLine(
                Icons.notifications_active,
                'Lembrete na data certa',
                'Avisamos quando você puder doar de novo.',
              ),
              const SizedBox(height: 10),
              const InfoLine(
                Icons.bolt,
                'Alerta de urgência',
                'Você é chamado quando faltar o seu tipo.',
              ),
              const Spacer(),
              PrimaryButton(
                'Começar',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SignupScreen()),
                ),
              ),
              const SizedBox(height: 8),
              const PrimaryButton('Já tenho conta', ghost: true),
            ],
          ),
        ),
      ),
    );
  }
}
