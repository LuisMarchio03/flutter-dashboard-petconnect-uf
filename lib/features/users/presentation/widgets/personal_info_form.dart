import 'package:flutter/material.dart';

class PersonalInfoForm extends StatelessWidget {
  final TextEditingController nomeController;
  final TextEditingController cpfController;
  final TextEditingController dataNascimentoController;
  final TextEditingController emailController;
  final TextEditingController telefoneController;
  final Function() onAlterarFoto;

  const PersonalInfoForm({
    Key? key,
    required this.nomeController,
    required this.cpfController,
    required this.dataNascimentoController,
    required this.emailController,
    required this.telefoneController,
    required this.onAlterarFoto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Informações Pessoais',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF374151),
          ),
        ),
        const SizedBox(height: 24),
        
        // Foto e botão de alterar
        Center(
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: const AssetImage('assets/default_profile.png'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: onAlterarFoto,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00A3D7),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Alterar Foto'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        
        // Nome Completo
        _buildTextField(
          label: 'Nome Completo',
          controller: nomeController,
          hintText: 'Digite o nome completo',
        ),
        const SizedBox(height: 16),
        
        // CPF e Data de Nascimento
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                label: 'CPF',
                controller: cpfController,
                hintText: 'Digite o CPF',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildTextField(
                label: 'Data de Nascimento',
                controller: dataNascimentoController,
                hintText: 'DD/MM/AAAA',
                suffixIcon: const Icon(Icons.calendar_today),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        // Email e Telefone
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                label: 'Email',
                controller: emailController,
                hintText: 'Digite o email',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildTextField(
                label: 'Telefone',
                controller: telefoneController,
                hintText: 'Digite o telefone',
              ),
            ),
          ],
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
}