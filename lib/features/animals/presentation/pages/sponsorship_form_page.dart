import 'package:flutter/material.dart';
import 'package:myapp/core/theme/app_colors.dart';
import 'package:myapp/core/widgets/sidebar_menu.dart';
import '../../domain/models/sponsorship_model.dart';
import '../../domain/models/animal_model.dart';

class SponsorshipFormPage extends StatefulWidget {
  final AnimalModel animal;
  final SponsorshipModel? sponsorship;
  final bool isEditing;

  const SponsorshipFormPage({
    super.key,
    required this.animal,
    this.sponsorship,
    this.isEditing = false,
  });

  @override
  State<SponsorshipFormPage> createState() => _SponsorshipFormPageState();
}

class _SponsorshipFormPageState extends State<SponsorshipFormPage> {
  final _formKey = GlobalKey<FormState>();

  // Controladores para os campos do formulário
  final _sponsorNameController = TextEditingController();
  final _sponsorEmailController = TextEditingController();
  final _sponsorPhoneController = TextEditingController();
  final _monthlyValueController = TextEditingController();
  final _observationsController = TextEditingController();

  String _status = SponsorshipModel.STATUS_PENDING;
  String _sponsorshipType = SponsorshipModel.TYPE_FULL;
  DateTime? _startDate;
  DateTime? _endDate;
  String? _contractUrl;
  String? _documentsUrl;

  @override
  void initState() {
    super.initState();
    if (widget.isEditing && widget.sponsorship != null) {
      _sponsorNameController.text = widget.sponsorship!.sponsorName;
      _sponsorEmailController.text = widget.sponsorship!.sponsorEmail;
      _sponsorPhoneController.text = widget.sponsorship!.sponsorPhone;
      _monthlyValueController.text = widget.sponsorship!.monthlyValue.toString();
      _observationsController.text = widget.sponsorship!.observations ?? '';
      _status = widget.sponsorship!.status;
      _sponsorshipType = widget.sponsorship!.sponsorshipType;
      _startDate = DateTime.parse(widget.sponsorship!.startDate);
      _endDate = widget.sponsorship!.endDate != null
          ? DateTime.parse(widget.sponsorship!.endDate!)
          : null;
      _contractUrl = widget.sponsorship!.contractUrl;
      _documentsUrl = widget.sponsorship!.documentsUrl;
    } else {
      _startDate = DateTime.now();
    }
  }

  @override
  void dispose() {
    _sponsorNameController.dispose();
    _sponsorEmailController.dispose();
    _sponsorPhoneController.dispose();
    _monthlyValueController.dispose();
    _observationsController.dispose();
    super.dispose();
  }

  void _salvarApadrinhamento() {
    if (_formKey.currentState!.validate()) {
      final sponsorship = SponsorshipModel(
        id: widget.sponsorship?.id,
        animalId: widget.animal.nome,
        sponsorId: '1', // TODO: Implementar autenticação
        sponsorName: _sponsorNameController.text,
        sponsorEmail: _sponsorEmailController.text,
        sponsorPhone: _sponsorPhoneController.text,
        startDate: _startDate!.toIso8601String(),
        endDate: _endDate?.toIso8601String(),
        status: _status,
        sponsorshipType: _sponsorshipType,
        monthlyValue: double.parse(_monthlyValueController.text),
        observations: _observationsController.text,
        contractUrl: _contractUrl,
        documentsUrl: _documentsUrl,
      );

      Navigator.pop(context, sponsorship);
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
                    widget.isEditing ? 'Editar Apadrinhamento' : 'Novo Apadrinhamento',
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

                            // Informações do Padrinho
                            const Text(
                              'Informações do Padrinho',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildTextField(
                              label: 'Nome Completo',
                              controller: _sponsorNameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, insira o nome do padrinho';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            _buildTextField(
                              label: 'E-mail',
                              controller: _sponsorEmailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, insira o e-mail do padrinho';
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
                              controller: _sponsorPhoneController,
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, insira o telefone do padrinho';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 32),

                            // Tipo e Valor
                            Row(
                              children: [
                                Expanded(
                                  child: _buildDropdownField(
                                    label: 'Tipo de Apadrinhamento',
                                    value: _sponsorshipType,
                                    items: SponsorshipModel.getSponsorshipTypes(),
                                    onChanged: (value) {
                                      setState(() {
                                        _sponsorshipType = value!;
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: _buildTextField(
                                    label: 'Valor Mensal ',
                                    controller: _monthlyValueController,
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Por favor, insira o valor mensal';
                                      }
                                      if (double.tryParse(value) == null) {
                                        return 'Por favor, insira um valor válido';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 32),

                            // Status e Datas
                            Row(
                              children: [
                                Expanded(
                                  child: _buildDropdownField(
                                    label: 'Status',
                                    value: _status,
                                    items: SponsorshipModel.getStatusList(),
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
                                    label: 'Data de Início',
                                    value: _startDate,
                                    onChanged: (date) {
                                      setState(() {
                                        _startDate = date;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            _buildDateField(
                              label: 'Data de Término (opcional)',
                              value: _endDate,
                              onChanged: (date) {
                                setState(() {
                                  _endDate = date;
                                });
                              },
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
                                  onPressed: _salvarApadrinhamento,
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
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
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
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
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
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
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
