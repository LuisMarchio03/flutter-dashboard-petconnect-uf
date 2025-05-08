import 'package:flutter/material.dart';

class AddressForm extends StatelessWidget {
  final TextEditingController enderecoCompletoController;
  final TextEditingController cidadeController;
  final TextEditingController estadoController;
  final TextEditingController cepController;

  const AddressForm({
    Key? key,
    required this.enderecoCompletoController,
    required this.cidadeController,
    required this.estadoController,
    required this.cepController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Endereço',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF374151),
          ),
        ),
        const SizedBox(height: 24),
        
        // Endereço Completo
        _buildTextField(
          label: 'Endereço Completo',
          controller: enderecoCompletoController,
          hintText: 'Digite o endereço completo',
        ),
        const SizedBox(height: 16),
        
        // Cidade, Estado e CEP
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                label: 'Cidade',
                controller: cidadeController,
                hintText: 'Digite a cidade',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildTextField(
                label: 'Estado',
                controller: estadoController,
                hintText: 'Digite o estado',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildTextField(
                label: 'CEP',
                controller: cepController,
                hintText: 'Digite o CEP',
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