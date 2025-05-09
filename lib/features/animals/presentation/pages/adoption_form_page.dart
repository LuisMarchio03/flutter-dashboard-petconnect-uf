import 'package:flutter/material.dart';
import 'package:myapp/core/widgets/sidebar_menu.dart';
import 'package:myapp/features/animals/domain/models/adoption_model.dart';
import '../../domain/models/animal_model.dart';
import '../widgets/header_widget.dart';
import '../widgets/form_section_widget.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/date_picker_field.dart';
import '../widgets/action_buttons.dart';

class AdoptionFormPage extends StatefulWidget {
  final AnimalModel animal;

  const AdoptionFormPage({Key? key, required this.animal, AdoptionModel? adoption, required bool isEditing}) : super(key: key);

  @override
  State<AdoptionFormPage> createState() => _AdoptionFormPageState();
}

class _AdoptionFormPageState extends State<AdoptionFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _observacoesController = TextEditingController();
  DateTime? _dataAdocao;

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _telefoneController.dispose();
    _enderecoController.dispose();
    _observacoesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const SidebarMenu(selectedItem: "Animais"),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeaderWidget(
                    title: 'Formulário de Adoção',
                    subtitle: 'Preencha os dados para adotar um animal',
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildAnimalInfo(),
                            const SizedBox(height: 24),
                            _buildAdopterInfo(),
                            const SizedBox(height: 24),
                            _buildAdoptionInfo(),
                            const SizedBox(height: 32),
                            ActionButtons(
                              onSave: _salvarAdocao,
                              onCancel: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimalInfo() {
    return FormSectionWidget(
      title: 'Informações do Animal',
      icon: '🐾',
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFF00A3D7).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.pets, size: 40, color: Color(0xFF00A3D7)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.animal.nome,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${widget.animal.especie} - ${widget.animal.raca}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${widget.animal.idade} - ${widget.animal.porte}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdopterInfo() {
    return FormSectionWidget(
      title: 'Informações do Adotante',
      icon: '👤',
      child: Column(
        children: [
          CustomTextField(
            controller: _nomeController,
            label: 'Nome Completo',
            hint: 'Digite o nome completo',
            icon: Icons.person,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, digite o nome';
              }
              return null;
            }, 
            prefixIcon: Icons.person,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: _emailController,
            label: 'E-mail',
            hint: 'Digite o e-mail',
            icon: Icons.email,
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Icons.email,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, digite o e-mail';
              }
              if (!value.contains('@')) {
                return 'Por favor, digite um e-mail válido';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: _telefoneController,
            label: 'Telefone',
            hint: 'Digite o telefone',
            icon: Icons.phone,
            keyboardType: TextInputType.phone,
            prefixIcon: Icons.phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, digite o telefone';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: _enderecoController,
            label: 'Endereço',
            hint: 'Digite o endereço completo',
            icon: Icons.home,
            prefixIcon: Icons.home,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, digite o endereço';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAdoptionInfo() {
    return FormSectionWidget(
      title: 'Informações da Adoção',
      icon: '📝',
      child: Column(
        children: [
          DatePickerField(
            label: 'Data da Adoção',
            value: _dataAdocao,
            onChanged: (date) {
              setState(() {
                _dataAdocao = date;
              });
            },
            validator: (value) {
              if (value == null) {
                return 'Por favor, selecione a data';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: _observacoesController,
            label: 'Observações',
            hint: 'Digite observações adicionais',
            icon: Icons.note,
            prefixIcon: Icons.note,
            maxLines: 3,
          ),
        ],
      ),
    );
  }

  void _salvarAdocao() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implementar lógica de salvamento
      Navigator.pop(context);
    }
  }
}
