import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/common.dart';
import 'main_shell.dart';

class EnableAlertsScreen extends StatelessWidget {
  const EnableAlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 32),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.primarySoft,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: const Icon(Icons.notifications_active, color: AppColors.primary, size: 40),
              ),
              const SizedBox(height: 20),
              Text(
                'Ativar avisos',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              const Text(
                'Dois avisos, só quando importa:',
                style: TextStyle(color: AppColors.muted),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              const InfoLine(
                Icons.calendar_today,
                'Lembrete de próxima doação',
                'Chega no dia em que você já pode doar de novo.',
              ),
              const SizedBox(height: 10),
              const InfoLine(
                Icons.bolt,
                'Alerta de urgência',
                'Chega quando faltar sangue do seu tipo no hemocentro.',
              ),
              const Spacer(),
              PrimaryButton(
                'Permitir avisos',
                icon: Icons.notifications_active,
                onTap: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const MainShell()),
                  (_) => false,
                ),
              ),
              const SizedBox(height: 8),
              PrimaryButton(
                'Agora não',
                ghost: true,
                onTap: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const MainShell()),
                  (_) => false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
