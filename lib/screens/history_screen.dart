import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/common.dart';
import '../models/user_session.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  static const _mesesAbrev = [
    '', 'jan', 'fev', 'mar', 'abr', 'mai', 'jun',
    'jul', 'ago', 'set', 'out', 'nov', 'dez'
  ];

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: UserSession.instance,
      builder: (context, _) {
        final profile = UserSession.instance.profile;
        final proxima = profile.nextDonationDate;
        final textoProxima = '${proxima.day} ${_mesesAbrev[proxima.month]} ${proxima.year}';

        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text('Histórico', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 4),
            Text(
              'Homens: 60 dias · Mulheres: 90 dias após a última doação\n(Seu intervalo atual: ${profile.donationIntervalDays} dias)',
              style: const TextStyle(color: AppColors.muted, fontSize: 11),
            ),
            const SizedBox(height: 16),

            AppCard(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Você pode doar novamente em',
                    style: TextStyle(color: AppColors.muted, fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        textoProxima,
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              color: AppColors.primary,
                              fontSize: 24,
                            ),
                      ),
                      const Spacer(),
                      const Icon(Icons.calendar_month_outlined, color: AppColors.primary),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            ElevatedButton.icon(
              onPressed: () {
                UserSession.instance.registerDonation();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('🎉 Parabéns! Doação registrada com sucesso.'),
                    backgroundColor: AppColors.success,
                    duration: Duration(seconds: 3),
                  ),
                );
              },
              icon: const Icon(Icons.favorite, size: 18),
              label: const Text('Doei hoje!'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 0,
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'Suas doações',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
            ),
            const SizedBox(height: 10),

            _DonationItem(
              date: '${profile.lastDonationDate.day} ${_mesesAbrev[profile.lastDonationDate.month]} ${profile.lastDonationDate.year}',
              local: 'Hemocentro da Paraíba',
              tag: 'mais recente',
              isFirst: false,
            ),
            const SizedBox(height: 8),
            const _DonationItem(
              date: '26 mai 2026',
              local: 'Hemocentro da Paraíba',
              tag: 'até 4 vidas',
              isFirst: false,
            ),
            const SizedBox(height: 8),
            const _DonationItem(
              date: '24 fev 2026',
              local: 'Hemocentro da Paraíba',
              tag: '1ª doação',
              isFirst: true,
            ),

            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.primarySoft,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  const Icon(Icons.favorite, color: AppColors.primary, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Suas ${profile.totalDonations} doações ajudaram até ${profile.totalDonations * 4} pessoas.',
                      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _DonationItem extends StatelessWidget {
  final String date;
  final String local;
  final String tag;
  final bool isFirst;

  const _DonationItem({
    required this.date,
    required this.local,
    required this.tag,
    required this.isFirst,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.successSoft,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.check, color: AppColors.success, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(date, style: const TextStyle(fontWeight: FontWeight.w700)),
                Text(local, style: const TextStyle(color: AppColors.muted, fontSize: 12)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: isFirst ? AppColors.primarySoft : AppColors.secondary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              tag,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: isFirst ? AppColors.primary : AppColors.muted,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
