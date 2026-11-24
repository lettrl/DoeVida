import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/common.dart';
import '../models/user_session.dart';
import 'welcome_screen.dart';
import 'alert_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static const tipos = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _weightController;
  late TextEditingController _cityController;
  late String _tipo;
  late bool _isMale;
  bool _editing = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    final p = UserSession.instance.profile;
    _nameController = TextEditingController(text: p.name);
    _emailController = TextEditingController(text: p.email);
    _weightController = TextEditingController(text: p.weight.toStringAsFixed(0));
    _cityController = TextEditingController(text: p.city);
    _tipo = p.bloodType;
    _isMale = p.isMale;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _weightController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    final weight = double.tryParse(_weightController.text.replaceAll(',', '.')) ?? 60.0;
    UserSession.instance.updateProfile(
      name: _nameController.text.trim().isEmpty ? 'Doador' : _nameController.text.trim(),
      email: _emailController.text.trim(),
      bloodType: _tipo,
      weight: weight,
      city: _cityController.text.trim().isEmpty ? 'João Pessoa' : _cityController.text.trim(),
      isMale: _isMale,
    );
    setState(() => _editing = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Perfil atualizado com sucesso!'),
        backgroundColor: AppColors.success,
        duration: Duration(seconds: 2),
      ),
    );
  }

  InputDecoration _dec(String label, IconData icon) => InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppColors.primary),
        filled: true,
        fillColor: AppColors.card,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.border, width: 1.5),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: UserSession.instance,
      builder: (context, _) {
        final profile = UserSession.instance.profile;

        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Row(
              children: [
                Text('Meu Perfil', style: Theme.of(context).textTheme.titleLarge),
                const Spacer(),
                TextButton.icon(
                  onPressed: () {
                    if (_editing) {
                      _saveProfile();
                    } else {
                      setState(() => _editing = true);
                    }
                  },
                  icon: Icon(_editing ? Icons.check : Icons.edit, size: 18),
                  label: Text(_editing ? 'Salvar' : 'Editar'),
                  style: TextButton.styleFrom(foregroundColor: AppColors.primary),
                ),
              ],
            ),
            const SizedBox(height: 16),

            Center(
              child: Column(
                children: [
                  Container(
                    width: 76,
                    height: 76,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x33D7263D),
                          blurRadius: 12,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        profile.name.isNotEmpty ? profile.name[0].toUpperCase() : 'D',
                        style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w800, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    profile.name,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                  Text(
                    profile.email,
                    style: const TextStyle(color: AppColors.muted, fontSize: 13),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primarySoft,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Tipo Sanguíneo: ${profile.bloodType}',
                      style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w800, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            if (_editing) ...[
              const Text('EDITAR INFORMAÇÕES', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.muted)),
              const SizedBox(height: 10),
              TextField(
                controller: _nameController,
                decoration: _dec('Nome completo', Icons.person_outline),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _cityController,
                decoration: _dec('Cidade', Icons.location_city),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _weightController,
                decoration: _dec('Peso (kg)', Icons.monitor_weight_outlined),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 14),
              const Text('TIPO SANGUÍNEO', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.muted)),
              const SizedBox(height: 8),
              GridView.count(
                crossAxisCount: 4,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 6,
                crossAxisSpacing: 6,
                childAspectRatio: 1.8,
                children: tipos.map((t) {
                  final sel = t == _tipo;
                  return GestureDetector(
                    onTap: () => setState(() => _tipo = t),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: sel ? AppColors.primary : AppColors.card,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: sel ? AppColors.primary : AppColors.border,
                          width: 2,
                        ),
                      ),
                      child: Text(
                        t,
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: sel ? Colors.white : AppColors.ink,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 14),
              const Text('INTERVALO BIOLÓGICO', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.muted)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _isMale = false),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: !_isMale ? AppColors.primarySoft : AppColors.card,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: !_isMale ? AppColors.primary : AppColors.border, width: 2),
                        ),
                        child: Text(
                          'Feminino (90 dias)',
                          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: !_isMale ? AppColors.primary : AppColors.ink),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _isMale = true),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: _isMale ? AppColors.primarySoft : AppColors.card,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: _isMale ? AppColors.primary : AppColors.border, width: 2),
                        ),
                        child: Text(
                          'Masculino (60 dias)',
                          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _isMale ? AppColors.primary : AppColors.ink),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              PrimaryButton('Salvar alterações', onTap: _saveProfile),
            ] else ...[
              AppCard(
                child: Column(
                  children: [
                    _ProfileRow(Icons.location_city, 'Cidade', profile.city),
                    const Divider(color: AppColors.border, height: 16),
                    _ProfileRow(Icons.monitor_weight_outlined, 'Peso', '${profile.weight.toStringAsFixed(0)} kg'),
                    const Divider(color: AppColors.border, height: 16),
                    _ProfileRow(
                      Icons.timer_outlined,
                      'Intervalo entre doações',
                      '${profile.donationIntervalDays} dias (${profile.isMale ? "Homem" : "Mulher"})',
                    ),
                    const Divider(color: AppColors.border, height: 16),
                    _ProfileRow(Icons.favorite, 'Total de doações', '${profile.totalDonations} doações'),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              OutlinedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AlertScreen()),
                  );
                },
                icon: const Icon(Icons.notifications_active_outlined, size: 18),
                label: const Text('Simular Avisos / Notificações'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.ink,
                  side: const BorderSide(color: AppColors.border, width: 1.5),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
              ),
              const SizedBox(height: 10),

              OutlinedButton.icon(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const WelcomeScreen()),
                    (_) => false,
                  );
                },
                icon: const Icon(Icons.logout, size: 18, color: AppColors.primary),
                label: const Text('Trocar de conta / Sair', style: TextStyle(color: AppColors.primary)),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.border, width: 1.5),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}

class _ProfileRow extends StatelessWidget {
  final IconData icon;
  final String label, value;
  const _ProfileRow(this.icon, this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.primary),
        const SizedBox(width: 12),
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: AppColors.muted)),
        const Spacer(),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13)),
      ],
    );
  }
}
