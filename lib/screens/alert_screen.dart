import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/common.dart';

class AlertScreen extends StatelessWidget {
  const AlertScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.ink,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 16),
          const Center(
            child: Text(
              '9:41',
              style: TextStyle(color: Colors.white, fontSize: 56, fontWeight: FontWeight.w600),
            ),
          ),
          const Center(
            child: Text(
              'domingo, 15 de novembro',
              style: TextStyle(color: Colors.white70),
            ),
          ),
          const SizedBox(height: 24),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.bolt, color: AppColors.primary),
                    const Text(
                      ' DoeVida · agora',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'URGENTE',
                        style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w800),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text('Estoque crítico de O+', style: Theme.of(context).textTheme.titleLarge),
                const Text(
                  'O Hemocentro da Paraíba precisa de doadores O+ nas próximas 48h.',
                  style: TextStyle(color: AppColors.muted),
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: const LinearProgressIndicator(
                    value: 0.18,
                    minHeight: 8,
                    color: AppColors.primary,
                    backgroundColor: AppColors.border,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Estoque do tipo O+: 18%',
                  style: TextStyle(color: AppColors.primary, fontSize: 11, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 12),
                const Row(
                  children: [
                    Expanded(child: PrimaryButton('Agora não', ghost: true)),
                    SizedBox(width: 8),
                    Expanded(child: PrimaryButton('Quero doar', icon: Icons.favorite)),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          AppCard(
            child: Row(
              children: [
                const IconBox(Icons.notifications),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Chegou a sua vez',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                      Text(
                        'Você já pode doar de novo a partir de 28 de novembro. Agende seu horário.',
                        style: TextStyle(fontSize: 12, color: AppColors.muted),
                      ),
                    ],
                  ),
                ),
                Text(
                  '8:00',
                  style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
