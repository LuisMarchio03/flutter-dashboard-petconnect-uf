import 'package:flutter/material.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/widgets/sidebar_menu.dart';
import '../../../../core/widgets/header_widget.dart';
import '../../domain/models/rescue_model.dart';

class RescueFormPage extends StatefulWidget {
  final bool isEditing;
  final RescueModel? rescue;
  final String title;

  const RescueFormPage({
    Key? key,
    this.isEditing = false,
    this.rescue,
    required this.title,
  }) : super(key: key);

  @override
  State<RescueFormPage> createState() => _RescueFormPageState();
}

class _RescueFormPageState extends State<RescueFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _locationController = TextEditingController();
  final _notesController = TextEditingController();
  final _animalNameController = TextEditingController();
  final _ageController = TextEditingController();
  final _responsibleController = TextEditingController();
  final _contactController = TextEditingController();
  final _conditionController = TextEditingController();

  String _selectedSpecies = 'Cachorro';
  String _selectedStatus = RescueModel.STATUS_PENDENTE;
  String _selectedGender = 'Macho';
  DateTime _selectedDate = DateTime.now();
  bool _isFromComplaint = false;

  @override
  void initState() {
    super.initState();
    if (widget.isEditing && widget.rescue != null) {
      _locationController.text = widget.rescue!.localizacao ?? '';
      _notesController.text = widget.rescue!.observacoes ?? '';
      _animalNameController.text = widget.rescue!.nomeAnimal ?? '';
      _ageController.text = widget.rescue!.idade ?? '';
      _responsibleController.text = widget.rescue!.responsavel ?? '';
      _contactController.text = widget.rescue!.contato ?? '';
      _conditionController.text = widget.rescue!.condicaoAnimal ?? '';
      _selectedSpecies = widget.rescue!.especie ?? 'Cachorro';
      _selectedStatus = widget.rescue!.status;
      _selectedGender = widget.rescue!.sexo ?? 'Macho';
      _isFromComplaint = widget.rescue!.origemDenuncia ?? false;
      if (widget.rescue!.dataResgate != null) {
        _selectedDate = DateTime.parse(widget.rescue!.dataResgate!);
      }
    }
  }

  @override
  void dispose() {
    _locationController.dispose();
    _notesController.dispose();
    _animalNameController.dispose();
    _ageController.dispose();
    _responsibleController.dispose();
    _contactController.dispose();
    _conditionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _salvarResgate() {
    if (_formKey.currentState!.validate()) {
      final rescue = RescueModel(
        id: widget.rescue?.id,
        nomeAnimal: _animalNameController.text,
        especie: _selectedSpecies,
        idade: _ageController.text,
        sexo: _selectedGender,
        condicaoAnimal: _conditionController.text,
        localizacao: _locationController.text,
        dataResgate: _selectedDate.toString().split(' ')[0],
        responsavel: _responsibleController.text,
        contato: _contactController.text,
        observacoes: _notesController.text,
        status: _selectedStatus,
        origemDenuncia: _isFromComplaint,
      );

      Navigator.pop(context, rescue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const SidebarMenu(selectedItem: 'Resgates'),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderWidget(
                  title: widget.title,
                  subtitle:
                      widget.isEditing
                          ? 'Atualize os dados do resgate'
                          : 'Cadastre um novo resgate',
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
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
                              color: Color(0xFF333333),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _animalNameController,
                                  decoration: const InputDecoration(
                                    labelText: 'Nome do Animal',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Por favor, insira o nome do animal';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  value: _selectedSpecies,
                                  decoration: const InputDecoration(
                                    labelText: 'Espécie',
                                    border: OutlineInputBorder(),
                                  ),
                                  items:
                                      ['Cachorro', 'Gato', 'Outros'].map((
                                        String value,
                                      ) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                  onChanged: (String? newValue) {
                                    if (newValue != null) {
                                      setState(() {
                                        _selectedSpecies = newValue;
                                      });
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _ageController,
                                  decoration: const InputDecoration(
                                    labelText: 'Idade',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  value: _selectedGender,
                                  decoration: const InputDecoration(
                                    labelText: 'Sexo',
                                    border: OutlineInputBorder(),
                                  ),
                                  items:
                                      ['Macho', 'Fêmea'].map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                  onChanged: (String? newValue) {
                                    if (newValue != null) {
                                      setState(() {
                                        _selectedGender = newValue;
                                      });
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _conditionController,
                            decoration: const InputDecoration(
                              labelText: 'Condição do Animal',
                              border: OutlineInputBorder(),
                            ),
                            maxLines: 2,
                          ),
                          const SizedBox(height: 24),

                          // Informações do Resgate
                          const Text(
                            'Informações do Resgate',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF333333),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _locationController,
                                  decoration: const InputDecoration(
                                    labelText: 'Localização',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Por favor, insira a localização';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: InkWell(
                                  onTap: () => _selectDate(context),
                                  child: InputDecorator(
                                    decoration: const InputDecoration(
                                      labelText: 'Data do Resgate',
                                      border: OutlineInputBorder(),
                                    ),
                                    child: Text(
                                      '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _responsibleController,
                                  decoration: const InputDecoration(
                                    labelText: 'Responsável',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: TextFormField(
                                  controller: _contactController,
                                  decoration: const InputDecoration(
                                    labelText: 'Contato',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _notesController,
                            decoration: const InputDecoration(
                              labelText: 'Observações',
                              border: OutlineInputBorder(),
                            ),
                            maxLines: 3,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  value: _selectedStatus,
                                  decoration: const InputDecoration(
                                    labelText: 'Status',
                                    border: OutlineInputBorder(),
                                  ),
                                  items:
                                      RescueModel.getStatusList().map((
                                        String value,
                                      ) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                  onChanged: (String? newValue) {
                                    if (newValue != null) {
                                      setState(() {
                                        _selectedStatus = newValue;
                                      });
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: CheckboxListTile(
                                  title: const Text('Origem: Denúncia'),
                                  value: _isFromComplaint,
                                  onChanged: (bool? value) {
                                    if (value != null) {
                                      setState(() {
                                        _isFromComplaint = value;
                                      });
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Cancelar'),
                              ),
                              const SizedBox(width: 16),
                              ElevatedButton(
                                onPressed: _salvarResgate,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF00A3D7),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 12,
                                  ),
                                ),
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
        ],
      ),
    );
  }
}
