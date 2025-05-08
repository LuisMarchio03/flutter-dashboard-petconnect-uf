import 'package:flutter/material.dart';

class AccessInfoForm extends StatelessWidget {
  final TextEditingController nomeUsuarioController;
  final TextEditingController senhaController;
  final TextEditingController confirmarSenhaController;
  final bool mostrarSenha;
  final bool mostrarConfirmarSenha;
  final Function() toggleMostrarSenha;
  final Function() toggleMostrarConfirmarSenha;

  const AccessInfoForm({
    Key? key,
    required this.nomeUsuarioController,
    required this.senhaController,
    required this.confirmarSenhaController,
    required this.mostrarSenha,
    required this.mostrarConfirmarSenha,
    required this.toggleMostrarSenha,
    required this.toggleMostrarConfirmarSenha,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Informações de Acesso',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF374151),
          ),
        ),
        const SizedBox(height: 24),
        
        // Nome de Usuário
        _buildTextField(
          label: 'Nome de Usuário',
          controller: nomeUsuarioController,
          hintText: 'Digite o nome de usuário',
          suffixIcon: const Icon(Icons.person),
        ),
        const SizedBox(height: 16),
        
        // Senha
        _buildPasswordField(
          label: 'Senha',
          controller: senhaController,
          hintText: 'Digite a senha',
          mostrarSenha: mostrarSenha,
          toggleMostrarSenha: toggleMostrarSenha,
        ),
        const SizedBox(height: 16),
        
        // Confirmar Senha
        _buildPasswordField(
          label: 'Confirmar Senha',
          controller: confirmarSenhaController,
          hintText: 'Confirme a senha',
          mostrarSenha: mostrarConfirmarSenha,
          toggleMostrarSenha: toggleMostrarConfirmarSenha,
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String hintText,
    Widget? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF374151),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: const Color(0xFFF9FAFB),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            suffixIcon: suffixIcon,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Campo obrigatório';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildPasswordField({
    required String label,
    required TextEditingController controller,
    required String hintText,
    required bool mostrarSenha,
    required Function() toggleMostrarSenha,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF374151),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: !mostrarSenha,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: const Color(0xFFF9FAFB),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                mostrarSenha ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
              onPressed: toggleMostrarSenha,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Campo obrigatório';
            }
            return null;
          },
        ),
      ],
    );
  }
}