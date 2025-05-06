import 'package:flutter/material.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/custom_button.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          hintText: 'Email',
          controller: emailController,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          hintText: 'Senha',
          obscureText: obscurePassword,
          controller: passwordController,
        ),
        const SizedBox(height: 24),
        CustomButton(
          text: 'Entrar',
          onPressed: () {
            // TODO: Implementar lógica de login
          },
        ),
      ],
    );
  }
}
