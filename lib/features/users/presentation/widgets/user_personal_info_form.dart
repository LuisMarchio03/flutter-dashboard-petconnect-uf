import 'package:flutter/material.dart';

class UserPersonalInfoForm extends StatelessWidget {
  final TextEditingController nomeCompletoController;
  final TextEditingController cpfController;
  final TextEditingController dataNascimentoController;
  final TextEditingController emailController;
  final TextEditingController telefoneController;
  final String? fotoUrl;
  final Function() onChangeFoto;

  const UserPersonalInfoForm({
    Key? key,
    required this.nomeCompletoController,
    required this.cpfController,
    required this.dataNascimentoController,
    required this.emailController,
    required this.telefoneController,
    this.fotoUrl,
    required this.onChangeFoto, required void Function(String url) onFotoChanged,
  }) : super(key: key);

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
            'Informações Pessoais',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 24),
          
          // Foto do usuário
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: fotoUrl != null
                      ? NetworkImage(fotoUrl!)
                      : const AssetImage('assets/default_avatar.png') as ImageProvider,
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: onChangeFoto,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00A3D7),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
            controller: nomeCompletoController,
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
                  hintText: '000.000.000-00',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildTextField(
                  label: 'Data de Nascimento',
                  controller: dataNascimentoController,
                  hintText: 'DD/MM/AAAA',
                  suffixIcon: const Icon(Icons.calendar_today, size: 20),
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
                  hintText: 'exemplo@email.com',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildTextField(
                  label: 'Telefone',
                  controller: telefoneController,
                  hintText: '(00) 00000-0000',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    String? hintText,
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