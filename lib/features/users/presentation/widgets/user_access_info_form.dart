import 'package:flutter/material.dart';

class UserAccessInfoForm extends StatefulWidget {
  final TextEditingController nomeUsuarioController;
  final TextEditingController senhaController;
  final TextEditingController confirmarSenhaController;

  const UserAccessInfoForm({
    Key? key,
    required this.nomeUsuarioController,
    required this.senhaController,
    required this.confirmarSenhaController, required bool isEditing,
  }) : super(key: key);

  @override
  State<UserAccessInfoForm> createState() => _UserAccessInfoFormState();
}

class _UserAccessInfoFormState extends State<UserAccessInfoForm> {
  bool _obscureSenha = true;
  bool _obscureConfirmarSenha = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Informações de Acesso',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 24),
          
          // Nome de Usuário
          _buildTextField(
            label: 'Nome de Usuário',
            controller: widget.nomeUsuarioController,
            hintText: 'Digite o nome de usuário',
            suffixIcon: const Icon(Icons.person, size: 20),
          ),
          const SizedBox(height: 16),
          
          // Senha
          _buildTextField(
            label: 'Senha',
            controller: widget.senhaController,
            hintText: 'Digite a senha',
            obscureText: _obscureSenha,
            suffixIcon: IconButton(
              icon: Icon(
                _obscureSenha ? Icons.visibility_off : Icons.visibility,
                size: 20,
              ),
              onPressed: () {
                setState(() {
                  _obscureSenha = !_obscureSenha;
                });
              },
            ),
          ),
          const SizedBox(height: 16),
          
          // Confirmar Senha
          _buildTextField(
            label: 'Confirmar Senha',
            controller: widget.confirmarSenhaController,
            hintText: 'Confirme a senha',
            obscureText: _obscureConfirmarSenha,
            suffixIcon: IconButton(
              icon: Icon(
                _obscureConfirmarSenha ? Icons.visibility_off : Icons.visibility,
                size: 20,
              ),
              onPressed: () {
                setState(() {
                  _obscureConfirmarSenha = !_obscureConfirmarSenha;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    String? hintText,
    bool obscureText = false,
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
          obscureText: obscureText,
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
}