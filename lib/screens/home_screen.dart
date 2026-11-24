import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/common.dart';
import '../models/user_session.dart';

class HomeScreen extends StatelessWidget {
  final ValueChanged<int> onTab;
  const HomeScreen({super.key, required this.onTab});

  static const _meses = [
    '', 'janeiro', 'fevereiro', 'março', 'abril', 'maio', 'junho',
    'julho', 'agosto', 'setembro', 'outubro', 'novembro', 'dezembro'
  ];

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
        final totalDiasIntervalo = profile.donationIntervalDays;
        final faltam = profile.daysUntilNextDonation.clamp(0, totalDiasIntervalo);
        final diasPassados = (totalDiasIntervalo - faltam).clamp(0, totalDiasIntervalo);
        final progresso = totalDiasIntervalo > 0 ? (diasPassados / totalDiasIntervalo) : 1.0;

        final textoProximaData = '${proxima.day} de ${_meses[proxima.month]}';
        final textoUltimaData = '${profile.lastDonationDate.day} ${_mesesAbrev[profile.lastDonationDate.month]}';

        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'Olá, ${profile.name} 👋',
              style: const TextStyle(color: AppColors.muted, fontSize: 13, fontWeight: FontWeight.w600),
            ),
            Text(profile.city, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(24),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x33D7263D),
                    blurRadius: 16,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'VOCÊ PODE DOAR NOVAMENTE EM',
                    style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w800),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '$faltam',
                        style: const TextStyle(color: Colors.white, fontSize: 56, fontWeight: FontWeight.w800, height: 1.1),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 10, left: 6),
                        child: Text('dias', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '📅 $textoProximaData · Tipo ${profile.bloodType}',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14),
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: progresso,
                      minHeight: 8,
                      color: Colors.white,
                      backgroundColor: Colors.white24,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Intervalo de $totalDiasIntervalo dias · última doação em $textoUltimaData',
                    style: const TextStyle(color: Colors.white70, fontSize: 11),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => onTab(2),
                    child: const _Quick(Icons.calendar_month, 'Agendar doação', 'Dias e horários livres'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: GestureDetector(
                    onTap: () => onTab(1),
                    child: const _Quick(Icons.location_on, 'Onde doar', Hemo.nome),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            const Text('Antes de doar', style: TextStyle(fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            for (final item in const [
              (Icons.restaurant, 'Estar bem alimentado'),
              (Icons.badge_outlined, 'Documento oficial com foto'),
              (Icons.bedtime_outlined, 'Dormir bem na noite anterior'),
            ])
              Container(
                margin: const EdgeInsets.only(bottom: 6),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(item.$1, size: 18, color: AppColors.primary),
                    const SizedBox(width: 8),
                    Text(item.$2, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                  ],
                ),
              ),

            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primarySoft,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.favorite, color: AppColors.primary, size: 16),
                  const SizedBox(width: 8),
                  Text(
                    'Suas ${profile.totalDonations} doações ajudaram até ${profile.totalDonations * 4} pessoas.',
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
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

class _Quick extends StatelessWidget {
  final IconData icon;
  final String title, sub;
  const _Quick(this.icon, this.title, this.sub);

  @override
  Widget build(BuildContext context) => AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: AppColors.primary),
            const SizedBox(height: 4),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
            Text(sub, style: const TextStyle(fontSize: 11, color: AppColors.muted), maxLines: 1, overflow: TextOverflow.ellipsis),
          ],
        ),
      );
}
