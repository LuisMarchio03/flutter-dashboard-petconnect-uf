import 'package:flutter/material.dart';
import 'package:myapp/core/widgets/sidebar_menu.dart';
import 'package:myapp/features/rescues/domain/models/rescue_model.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/models/animal_model.dart';
import '../widgets/header_widget.dart';
import '../widgets/form_section_widget.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/date_picker_field.dart';
import '../widgets/action_buttons.dart';

class AnimalFormPage extends StatefulWidget {
  final AnimalModel? animal;
  final bool isEditing;
  final RescueModel resgate;

  const AnimalFormPage({
    super.key, 
    this.animal, 
    this.isEditing = false, 
    required this.resgate
  });

  @override
  State<AnimalFormPage> createState() => _AnimalFormPageState();
}

class _AnimalFormPageState extends State<AnimalFormPage> {
  final _formKey = GlobalKey<FormState>();

  // Controladores para os campos do formulário
  final _nomeController = TextEditingController();
  final _racaController = TextEditingController();
  final _corController = TextEditingController();
  final _pesoController = TextEditingController();
  final _observacoesController = TextEditingController();
  final _porteController = TextEditingController();
  final _especieController = TextEditingController();
  final _idadeController = TextEditingController();
  final _localizacaoController = TextEditingController();
  final _condicoesMedicasController = TextEditingController();

  String _genero = 'Macho';
  String _status = 'Disponível';

  DateTime? _ultimaVacina;
  DateTime? _proximaVacina;

  final List<String> _generoOptions = ['Macho', 'Fêmea'];
  final List<String> _statusOptions = ['Disponível', 'Adotado', 'Em tratamento'];

  @override
  void initState() {
    super.initState();

    // Preencher os campos se estiver editando
    if (widget.isEditing && widget.animal != null) {
      _nomeController.text = widget.animal!.nome;
      _racaController.text = widget.animal!.raca;
      _corController.text = widget.animal!.cor;
      _pesoController.text = widget.animal!.peso;
      _observacoesController.text = widget.animal!.observacoes;
      _porteController.text = widget.animal!.porte;
      _especieController.text = widget.animal!.especie;
      _idadeController.text = widget.animal!.idade;
      _localizacaoController.text = widget.animal!.localizacao;
      _condicoesMedicasController.text = widget.animal!.condicoesMedicas;

      _genero = widget.animal!.genero;
      _status = widget.animal!.status;

      // Converter strings de data para DateTime se necessário
      // Implementação simplificada
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _racaController.dispose();
    _corController.dispose();
    _pesoController.dispose();
    _observacoesController.dispose();
    _porteController.dispose();
    _especieController.dispose();
    _idadeController.dispose();
    _localizacaoController.dispose();
    _condicoesMedicasController.dispose();
    super.dispose();
  }

  void _salvarAnimal() {
    if (_formKey.currentState!.validate()) {
      // Criar um novo objeto AnimalModel com os dados do formulário
      final animal = AnimalModel(
        nome: _nomeController.text,
        genero: _genero,
        raca: _racaController.text,
        cor: _corController.text,
        porte: _porteController.text,
        especie: _especieController.text,
        idade: _idadeController.text,
        status: _status,
        peso: _pesoController.text,
        localizacao: _localizacaoController.text,
        observacoes: _observacoesController.text,
        ultimaVacina: _ultimaVacina?.toString() ?? '',
        proximaVacina: _proximaVacina?.toString() ?? '',
        condicoesMedicas: _condicoesMedicasController.text,
      );

      // Retornar o animal para a página anterior
      Navigator.pop(context, animal);
    }
  }

  Widget _buildDropdown({
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
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: Color(0xFF374151),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF9FAFB),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: DropdownButtonFormField<String>(
            value: value,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: onChanged,
            icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF6B7280)),
            dropdownColor: Colors.white,
            elevation: 8,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Menu lateral
          const SidebarMenu(selectedItem: 'Animais'),
          
          // Conteúdo principal
          Expanded(
            child: Container(
              color: const Color(0xFFF9FAFB),
              child: Column(
                children: [
                  // Cabeçalho
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: HeaderWidget(
                      title: widget.isEditing ? 'Editar Animal' : 'Adicionar Animal',
                      subtitle: 'Preencha os dados do animal',
                    ),
                  ),
                  
                  // Conteúdo do formulário
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Informações Básicas
                            FormSectionWidget(
                              title: 'Informações Básicas',
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomTextField(
                                        label: 'Nome',
                                        controller: _nomeController,
                                        prefixIcon: Icons.pets,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: _buildDropdown(
                                        label: 'Gênero',
                                        value: _genero,
                                        items: _generoOptions,
                                        onChanged: (value) {
                                          if (value != null) {
                                            setState(() {
                                              _genero = value;
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
                                      child: CustomTextField(
                                        label: 'Espécie',
                                        controller: _especieController,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: _buildDropdown(
                                        label: 'Status',
                                        value: _status,
                                        items: _statusOptions,
                                        onChanged: (value) {
                                          if (value != null) {
                                            setState(() {
                                              _status = value;
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            
                            // Características Físicas
                            FormSectionWidget(
                              title: 'Características Físicas',
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomTextField(
                                        label: 'Raça',
                                        controller: _racaController,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: CustomTextField(
                                        label: 'Cor',
                                        controller: _corController,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomTextField(
                                        label: 'Porte',
                                        controller: _porteController,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: CustomTextField(
                                        label: 'Peso (kg)',
                                        controller: _pesoController,
                                        keyboardType: TextInputType.number,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomTextField(
                                        label: 'Idade',
                                        controller: _idadeController,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: CustomTextField(
                                        label: 'Onde foi localizado?',
                                        controller: _localizacaoController,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                CustomTextField(
                                  label: 'Observações',
                                  controller: _observacoesController,
                                  maxLines: 3,
                                ),
                              ],
                            ),
                            
                            // Informações de Saúde
                            FormSectionWidget(
                              title: 'Informações de Saúde',
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: DatePickerField(
                                        label: 'Última Vacina',
                                        selectedDate: _ultimaVacina,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime.now(),
                                        onDateSelected: (date) {
                                          setState(() {
                                            _ultimaVacina = date;
                                          });
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: DatePickerField(
                                        label: 'Próxima Vacina',
                                        selectedDate: _proximaVacina,
                                        initialDate: DateTime.now().add(const Duration(days: 30)),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2100),
                                        onDateSelected: (date) {
                                          setState(() {
                                            _proximaVacina = date;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                CustomTextField(
                                  label: 'Condições Médicas',
                                  controller: _condicoesMedicasController,
                                  maxLines: 3,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  
                  // Botões de ação
                  ActionButtons(
                    onCancel: () {
                      Navigator.pop(context);
                    },
                    onSave: _salvarAnimal,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
