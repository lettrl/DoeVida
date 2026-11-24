import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/common.dart';
import '../models/user_session.dart';
import 'enable_alerts_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  static const tipos = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
  String tipo = 'O+';
  bool isMale = false;

  final TextEditingController _nameController = TextEditingController(text: 'Letícia');
  final TextEditingController _emailController = TextEditingController(text: 'leticia@email.com');
  final TextEditingController _passController = TextEditingController(text: '123456');
  final TextEditingController _weightController = TextEditingController(text: '62');
  final TextEditingController _cityController = TextEditingController(text: 'João Pessoa');

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passController.dispose();
    _weightController.dispose();
    _cityController.dispose();
    super.dispose();
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

  void _submit() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final weight = double.tryParse(_weightController.text.replaceAll(',', '.')) ?? 60.0;
    final city = _cityController.text.trim();

    UserSession.instance.updateProfile(
      name: name.isEmpty ? 'Doador' : name,
      email: email.isEmpty ? 'doador@email.com' : email,
      bloodType: tipo,
      weight: weight,
      city: city.isEmpty ? 'João Pessoa' : city,
      isMale: isMale,
    );

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const EnableAlertsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar conta'),
        backgroundColor: AppColors.background,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          TextField(
            controller: _nameController,
            decoration: _dec('Nome completo', Icons.person_outline),
            textCapitalization: TextCapitalization.words,
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _emailController,
            decoration: _dec('E-mail', Icons.mail_outline),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _passController,
            decoration: _dec('Senha', Icons.lock_outline),
            obscureText: true,
          ),
          const SizedBox(height: 16),
          const Text(
            'TIPO SANGUÍNEO',
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.muted),
          ),
          const SizedBox(height: 8),
          GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 6,
            crossAxisSpacing: 6,
            childAspectRatio: 1.8,
            children: tipos.map((t) {
              final sel = t == tipo;
              return GestureDetector(
                onTap: () => setState(() => tipo = t),
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
          const SizedBox(height: 6),
          const Text(
            'Usamos seu tipo só para avisar quando ele estiver em falta.',
            style: TextStyle(fontSize: 11, color: AppColors.muted),
          ),
          const SizedBox(height: 16),
          const Text(
            'INTERVALO DE DOAÇÃO (BIOLÓGICO)',
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.muted),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => isMale = false),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: !isMale ? AppColors.primarySoft : AppColors.card,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: !isMale ? AppColors.primary : AppColors.border,
                        width: 2,
                      ),
                    ),
                    child: Text(
                      'Feminino (90 dias)',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        color: !isMale ? AppColors.primary : AppColors.ink,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => isMale = true),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isMale ? AppColors.primarySoft : AppColors.card,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isMale ? AppColors.primary : AppColors.border,
                        width: 2,
                      ),
                    ),
                    child: Text(
                      'Masculino (60 dias)',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        color: isMale ? AppColors.primary : AppColors.ink,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _weightController,
                  decoration: _dec('Peso (kg)', Icons.monitor_weight_outlined),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: _cityController,
                  decoration: _dec('Cidade', Icons.location_city),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            'Criar conta',
            onTap: _submit,
          ),
        ],
      ),
    );
  }
}
