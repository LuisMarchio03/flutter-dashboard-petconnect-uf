import 'package:flutter/material.dart';
import 'package:myapp/core/widgets/sidebar_menu.dart';
import 'package:myapp/features/animals/domain/models/sponsorship_model.dart';
import '../../domain/models/animal_model.dart';
import '../widgets/header_widget.dart';
import '../widgets/form_section_widget.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/date_picker_field.dart';
import '../widgets/action_buttons.dart';

class SponsorshipFormPage extends StatefulWidget {
  final AnimalModel animal;

  const SponsorshipFormPage({Key? key, required this.animal, SponsorshipModel? sponsorship, required bool isEditing}) : super(key: key);

  @override
  State<SponsorshipFormPage> createState() => _SponsorshipFormPageState();
}

class _SponsorshipFormPageState extends State<SponsorshipFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _observacoesController = TextEditingController();
  final _valorController = TextEditingController();
  DateTime? _dataInicio;
  DateTime? _dataFim;
  String _tipoApadrinhamento = 'Mensal';

  final List<String> _tiposApadrinhamento = [
    'Mensal',
    'Trimestral',
    'Semestral',
    'Anual',
  ];

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _telefoneController.dispose();
    _observacoesController.dispose();
    _valorController.dispose();
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
                    title: 'Formulário de Apadrinhamento',
                    subtitle: 'Preencha os dados para apadrinhar um animal',
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
                            _buildSponsorInfo(),
                            const SizedBox(height: 24),
                            _buildSponsorshipInfo(),
                            const SizedBox(height: 32),
                            ActionButtons(
                              onSave: _salvarApadrinhamento,
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

  Widget _buildSponsorInfo() {
    return FormSectionWidget(
      title: 'Informações do Padrinho',
      icon: '👤',
      child: Column(
        children: [
          CustomTextField(
            controller: _nomeController,
            label: 'Nome Completo',
            hint: 'Digite o nome completo',
            icon: Icons.person,
            prefixIcon: Icons.person,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, digite o nome';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: _emailController,
            label: 'E-mail',
            hint: 'Digite o e-mail',
            icon: Icons.email,
            prefixIcon: Icons.email,
            keyboardType: TextInputType.emailAddress,
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
            prefixIcon: Icons.phone,
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, digite o telefone';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSponsorshipInfo() {
    return FormSectionWidget(
      title: 'Informações do Apadrinhamento',
      icon: '💝',
      child: Column(
        children: [
          DropdownButtonFormField<String>(
            value: _tipoApadrinhamento,
            decoration: const InputDecoration(
              labelText: 'Tipo de Apadrinhamento',
              prefixIcon: Icon(Icons.calendar_today, color: Color(0xFF6B7280)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
            items:
                _tiposApadrinhamento.map((String tipo) {
                  return DropdownMenuItem<String>(
                    value: tipo,
                    child: Text(tipo),
                  );
                }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  _tipoApadrinhamento = newValue;
                });
              }
            },
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: _valorController,
            label: 'Valor',
            hint: 'Digite o valor',
            icon: Icons.attach_money,
            prefixIcon: Icons.attach_money,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, digite o valor';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          DatePickerField(
            label: 'Data de Início',
            value: _dataInicio,
            onChanged: (date) {
              setState(() {
                _dataInicio = date;
              });
            },
            validator: (value) {
              if (value == null) {
                return 'Por favor, selecione a data de início';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          DatePickerField(
            label: 'Data de Término (Opcional)',
            value: _dataFim,
            onChanged: (date) {
              setState(() {
                _dataFim = date;
              });
            },
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: _observacoesController,
            label: 'Observações',
            hint: 'Digite observações adicionais',
            icon: Icons.note,
            maxLines: 3,
            prefixIcon: Icons.note,
          ),
        ],
      ),
    );
  }

  void _salvarApadrinhamento() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implementar lógica de salvamento
      Navigator.pop(context);
    }
  }
}
