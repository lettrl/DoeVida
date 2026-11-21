import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/common.dart';
import 'enable_alerts_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  static const tipos = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
  String tipo = 'O+';

  InputDecoration _dec(String label, IconData icon) => InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppColors.primary),
        filled: true,
        fillColor: AppColors.card,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Criar conta'), backgroundColor: AppColors.background),
      body: ListView(padding: const EdgeInsets.all(24), children: [
        TextField(decoration: _dec('E-mail', Icons.mail_outline), keyboardType: TextInputType.emailAddress),
        const SizedBox(height: 10),
        TextField(decoration: _dec('Senha', Icons.lock_outline), obscureText: true),
        const SizedBox(height: 16),
        const Text('TIPO SANGUÍNEO', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.muted)),
        const SizedBox(height: 8),
        GridView.count(
          crossAxisCount: 4, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 6, crossAxisSpacing: 6, childAspectRatio: 1.8,
          children: tipos.map((t) {
            final sel = t == tipo;
            return GestureDetector(
              onTap: () => setState(() => tipo = t),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: sel ? AppColors.primary : AppColors.card,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: sel ? AppColors.primary : AppColors.border, width: 2),
                ),
                child: Text(t, style: TextStyle(fontWeight: FontWeight.w800, color: sel ? Colors.white : AppColors.ink)),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 6),
        const Text('Usamos seu tipo só para avisar quando ele estiver em falta.', style: TextStyle(fontSize: 11, color: AppColors.muted)),
        const SizedBox(height: 16),
        Row(children: [
          Expanded(child: TextField(decoration: _dec('Peso (kg)', Icons.monitor_weight_outlined), keyboardType: TextInputType.number)),
          const SizedBox(width: 10),
          Expanded(child: TextField(decoration: _dec('Cidade', Icons.location_city), controller: TextEditingController(text: 'João Pessoa'))),
        ]),
        const SizedBox(height: 24),
        PrimaryButton('Criar conta', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EnableAlertsScreen()))),
      ]),
    );
  }
}
