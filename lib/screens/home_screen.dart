import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/common.dart';

class HomeScreen extends StatelessWidget {
  final ValueChanged<int> onTab;
  const HomeScreen({super.key, required this.onTab});

  @override
  Widget build(BuildContext context) {
    final ultima = DateTime(2026, 8, 30);
    final proxima = proximaDoacao(ultima, homem: false);
    final faltam = proxima.difference(DateTime(2026, 11, 15)).inDays.clamp(0, 90);
    return ListView(padding: const EdgeInsets.all(20), children: [
      const Text('Olá, Letícia 👋', style: TextStyle(color: AppColors.muted, fontSize: 12)),
      Text('João Pessoa', style: Theme.of(context).textTheme.titleLarge),
      const SizedBox(height: 12),
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(24)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('VOCÊ PODE DOAR NOVAMENTE EM', style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w800)),
          Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text('$faltam', style: const TextStyle(color: Colors.white, fontSize: 56, fontWeight: FontWeight.w800)),
            const Padding(padding: EdgeInsets.only(bottom: 10, left: 6), child: Text('dias', style: TextStyle(color: Colors.white, fontSize: 18))),
          ]),
          const Text('📅 28 de novembro · Tipo O+', style: TextStyle(color: Colors.white)),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(value: (90 - faltam) / 90, minHeight: 8, color: Colors.white, backgroundColor: Colors.white24),
          ),
          const SizedBox(height: 4),
          const Text('Intervalo de 90 dias · última doação em 30 ago', style: TextStyle(color: Colors.white70, fontSize: 11)),
        ]),
      ),
      const SizedBox(height: 12),
      Row(children: [
        Expanded(child: GestureDetector(onTap: () => onTab(2), child: const _Quick(Icons.calendar_month, 'Agendar doação', 'Dias e horários livres'))),
        const SizedBox(width: 8),
        Expanded(child: GestureDetector(onTap: () => onTab(1), child: const _Quick(Icons.location_on, 'Onde doar', Hemo.nome))),
      ]),
      const SizedBox(height: 16),
      const Text('Antes de doar', style: TextStyle(fontWeight: FontWeight.w800)),
      const SizedBox(height: 8),
      for (final (icon, t) in const [
        (Icons.restaurant, 'Estar bem alimentado'),
        (Icons.badge_outlined, 'Documento oficial com foto'),
        (Icons.bedtime_outlined, 'Dormir bem na noite anterior'),
      ])
        Container(
          margin: const EdgeInsets.only(bottom: 6),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(color: AppColors.secondary, borderRadius: BorderRadius.circular(12)),
          child: Row(children: [Icon(icon, size: 18, color: AppColors.primary), const SizedBox(width: 8), Text(t, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13))]),
        ),
    ]);
  }
}

class _Quick extends StatelessWidget {
  final IconData icon;
  final String title, sub;
  const _Quick(this.icon, this.title, this.sub);
  @override
  Widget build(BuildContext context) => AppCard(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(icon, color: AppColors.primary),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
          Text(sub, style: const TextStyle(fontSize: 11, color: AppColors.muted)),
        ]),
      );
}
