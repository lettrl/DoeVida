import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/common.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final List<_DaySlot> _days = [
    _DaySlot('SÁB', '28'),
    _DaySlot('SEG', '30'),
    _DaySlot('TER', '1'),
    _DaySlot('QUA', '2'),
    _DaySlot('QUI', '3'),
  ];

  final List<String> _horarios = [
    '08:00', '08:30', '09:00',
    '09:30', '10:00', '10:30',
    '11:00', '11:30', '12:00',
  ];

  final Set<String> _ocupados = {'09:30', '10:00'};

  int _selectedDay = 0;
  String? _selectedHorario;
  bool _agendado = false;
  String? _horarioAgendado;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: () {},
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
            const SizedBox(width: 4),
            Text('Agendar doação', style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
        const SizedBox(height: 4),
        const Text('Novembro 2026', style: TextStyle(color: AppColors.muted, fontSize: 13)),
        const SizedBox(height: 16),

        SizedBox(
          height: 70,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _days.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, i) {
              final sel = i == _selectedDay;
              return GestureDetector(
                onTap: () => setState(() {
                  _selectedDay = i;
                  _selectedHorario = null;
                }),
                child: Container(
                  width: 56,
                  decoration: BoxDecoration(
                    color: sel ? AppColors.primary : AppColors.card,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: sel ? AppColors.primary : AppColors.border,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _days[i].weekday,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: sel ? Colors.white70 : AppColors.muted,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _days[i].day,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: sel ? Colors.white : AppColors.ink,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 16),
        const Text(
          'Horários livres',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        const Text(
          'Sábado: 7h às 13h',
          style: TextStyle(color: AppColors.muted, fontSize: 12),
        ),
        const SizedBox(height: 10),

        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 2.5,
          children: _horarios.map((h) {
            final ocupado = _ocupados.contains(h);
            final sel = h == _selectedHorario;
            return GestureDetector(
              onTap: ocupado ? null : () => setState(() => _selectedHorario = sel ? null : h),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: sel
                      ? AppColors.primary
                      : ocupado
                          ? AppColors.border
                          : AppColors.card,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: sel ? AppColors.primary : AppColors.border,
                    width: 2,
                  ),
                ),
                child: Text(
                  h,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: sel
                        ? Colors.white
                        : ocupado
                            ? AppColors.muted
                            : AppColors.ink,
                    fontSize: 13,
                  ),
                ),
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: 16),

        if (_agendado && _horarioAgendado != null) ...[
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.primarySoft,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.primary.withValues(alpha: 0.3), width: 2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'AGENDADO',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w800,
                    fontSize: 11,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Sáb, 28 nov · $_horarioAgendado',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const Text(
                  'Hemocentro da Paraíba – Jaguaribe',
                  style: TextStyle(color: AppColors.muted, fontSize: 12),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () => setState(() {
                    _agendado = false;
                    _horarioAgendado = null;
                    _selectedHorario = null;
                  }),
                  child: const Row(
                    children: [
                      Icon(Icons.close, size: 14, color: AppColors.primary),
                      SizedBox(width: 4),
                      Text(
                        'Cancelar agendamento',
                        style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],

        PrimaryButton(
          'Confirmar agendamento',
          icon: Icons.check,
          onTap: _selectedHorario == null
              ? null
              : () => setState(() {
                    _agendado = true;
                    _horarioAgendado = _selectedHorario;
                    _selectedHorario = null;
                  }),
        ),

        const SizedBox(height: 10),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.info_outline, size: 13, color: AppColors.muted),
            SizedBox(width: 4),
            Text(
              'Chegue 10 minutos antes · a doação dura cerca de 1 hora.',
              style: TextStyle(fontSize: 11, color: AppColors.muted),
            ),
          ],
        ),
      ],
    );
  }
}

class _DaySlot {
  final String weekday;
  final String day;
  const _DaySlot(this.weekday, this.day);
}
