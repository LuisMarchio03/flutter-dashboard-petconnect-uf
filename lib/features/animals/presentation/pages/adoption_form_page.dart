import 'package:flutter/material.dart';
import 'package:myapp/core/theme/app_colors.dart';
import 'package:myapp/core/widgets/sidebar_menu.dart';
import '../../domain/models/adoption_model.dart';
import '../../domain/models/animal_model.dart';

class AdoptionFormPage extends StatefulWidget {
  final AnimalModel animal;
  final AdoptionModel? adoption;
  final bool isEditing;

  const AdoptionFormPage({
    super.key,
    required this.animal,
    this.adoption,
    this.isEditing = false,
  });

  @override
  State<AdoptionFormPage> createState() => _AdoptionFormPageState();
}

class _AdoptionFormPageState extends State<AdoptionFormPage> {
  final _formKey = GlobalKey<FormState>();

  // Controladores para os campos do formulário
  final _adopterNameController = TextEditingController();
  final _adopterEmailController = TextEditingController();
  final _adopterPhoneController = TextEditingController();
  final _observationsController = TextEditingController();

  String _status = AdoptionModel.STATUS_PENDING;
  DateTime? _adoptionDate;
  String? _contractUrl;
  String? _documentsUrl;

  @override
  void initState() {
    super.initState();
    if (widget.isEditing && widget.adoption != null) {
      _adopterNameController.text = widget.adoption!.adopterName;
      _adopterEmailController.text = widget.adoption!.adopterEmail;
      _adopterPhoneController.text = widget.adoption!.adopterPhone;
      _observationsController.text = widget.adoption!.observations ?? '';
      _status = widget.adoption!.status;
      _adoptionDate = DateTime.parse(widget.adoption!.adoptionDate);
      _contractUrl = widget.adoption!.contractUrl;
      _documentsUrl = widget.adoption!.documentsUrl;
    } else {
      _adoptionDate = DateTime.now();
    }
  }

  @override
  void dispose() {
    _adopterNameController.dispose();
    _adopterEmailController.dispose();
    _adopterPhoneController.dispose();
    _observationsController.dispose();
    super.dispose();
  }

  void _salvarAdocao() {
    if (_formKey.currentState!.validate()) {
      final adoption = AdoptionModel(
        id: widget.adoption?.id,
        animalId: widget.animal.nome,
        adopterId: '1', // TODO: Implementar autenticação
        adopterName: _adopterNameController.text,
        adopterEmail: _adopterEmailController.text,
        adopterPhone: _adopterPhoneController.text,
        adoptionDate: _adoptionDate!.toIso8601String(),
        status: _status,
        observations: _observationsController.text,
        contractUrl: _contractUrl,
        documentsUrl: _documentsUrl,
      );

      Navigator.pop(context, adoption);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const SidebarMenu(
            selectedItem: 'Animais',
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.isEditing ? 'Editar Adoção' : 'Nova Adoção',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Informações do Animal
                            const Text(
                              'Informações do Animal',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildAnimalInfo(),
                            const SizedBox(height: 32),

                            // Informações do Adotante
                            const Text(
                              'Informações do Adotante',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildTextField(
                              label: 'Nome Completo',
                              controller: _adopterNameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, insira o nome do adotante';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            _buildTextField(
                              label: 'E-mail',
                              controller: _adopterEmailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, insira o e-mail do adotante';
                                }
                                if (!value.contains('@')) {
                                  return 'Por favor, insira um e-mail válido';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            _buildTextField(
                              label: 'Telefone',
                              controller: _adopterPhoneController,
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, insira o telefone do adotante';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 32),

                            // Status e Data
                            Row(
                              children: [
                                Expanded(
                                  child: _buildDropdownField(
                                    label: 'Status',
                                    value: _status,
                                    items: AdoptionModel.getStatusList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _status = value!;
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: _buildDateField(
                                    label: 'Data da Adoção',
                                    value: _adoptionDate,
                                    onChanged: (date) {
                                      setState(() {
                                        _adoptionDate = date;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 32),

                            // Observações
                            _buildTextField(
                              label: 'Observações',
                              controller: _observationsController,
                              maxLines: 3,
                            ),
                            const SizedBox(height: 32),

                            // Botões de Ação
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Cancelar'),
                                ),
                                const SizedBox(width: 16),
                                ElevatedButton(
                                  onPressed: _salvarAdocao,
                                  child: const Text('Salvar'),
                                ),
                              ],
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
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Nome: ${widget.animal.nome}'),
          const SizedBox(height: 8),
          Text('Espécie: ${widget.animal.especie}'),
          const SizedBox(height: 8),
          Text('Raça: ${widget.animal.raca}'),
          const SizedBox(height: 8),
          Text('Gênero: ${widget.animal.genero}'),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    TextInputType? keyboardType,
    int? maxLines,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines ?? 1,
          validator: validator,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          items:
              items.map((String item) {
                return DropdownMenuItem<String>(value: item, child: Text(item));
              }).toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField({
    required String label,
    required DateTime? value,
    required Function(DateTime?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: value ?? DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );
            if (date != null) {
              onChanged(date);
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value?.toString().split(' ')[0] ?? 'Selecione uma data',
                  style: TextStyle(
                    color: value == null ? Colors.grey : Colors.black,
                  ),
                ),
                const Icon(Icons.calendar_today),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
