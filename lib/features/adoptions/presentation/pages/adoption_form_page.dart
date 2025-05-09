import 'package:flutter/material.dart';
import 'package:myapp/core/widgets/sidebar_menu.dart';
import 'package:myapp/features/animals/domain/models/adoption_model.dart';
import 'package:myapp/features/animals/domain/models/animal_model.dart';
import 'package:myapp/features/animals/presentation/widgets/header_widget.dart';

class AdoptionFormPage extends StatefulWidget {
  final AnimalModel animal;
  final AdoptionModel? adoption;
  final bool isEditing;

  const AdoptionFormPage({
    Key? key,
    required this.animal,
    this.adoption,
    this.isEditing = false,
  }) : super(key: key);

  @override
  State<AdoptionFormPage> createState() => _AdoptionFormPageState();
}

class _AdoptionFormPageState extends State<AdoptionFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _cpfController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _observacoesController = TextEditingController();
  DateTime? _dataAdocao;
  String _status = 'Pendente';

  @override
  void initState() {
    super.initState();
    if (widget.isEditing && widget.adoption != null) {
      _nomeController.text = widget.adoption!.adopterName;
      // _cpfController.text = widget.adoption!.adopterCpf ?? '';
      _emailController.text = widget.adoption!.adopterEmail;
      _telefoneController.text = widget.adoption!.adopterPhone;
      // _enderecoController.text = widget.adoption!.adopterAddress ?? '';
      _observacoesController.text = widget.adoption!.observations ?? '';
      _dataAdocao = new DateTime(int.parse(widget.adoption!.adoptionDate));
      _status = widget.adoption!.status;
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _cpfController.dispose();
    _emailController.dispose();
    _telefoneController.dispose();
    _enderecoController.dispose();
    _observacoesController.dispose();
    super.dispose();
  }

  Future<void> _selecionarData() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dataAdocao ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _dataAdocao) {
      setState(() {
        _dataAdocao = picked;
      });
    }
  }

  void _salvarAdocao() {
    if (_formKey.currentState!.validate()) {
      final adoption = AdoptionModel(
        id:
            widget.adoption?.id ??
            DateTime.now().millisecondsSinceEpoch.toString(),
        animalId: widget.animal.nome,

        status: _status,
        adopterEmail: _emailController.text,
        adopterPhone: _telefoneController.text,
        adopterName: _nomeController.text,
        // adopterAddress: _enderecoController.text,
        // adopterCpf: _cpfController.text,
        observations: _observacoesController.text,
        adoptionDate:
            _dataAdocao != null
                ? '${_dataAdocao!.day}/${_dataAdocao!.month}/${_dataAdocao!.year}'
                : '',
        adopterId: widget.adoption?.adopterId ?? '',
        // adopterCity: widget.adoption?.adopterCity ?? '',
        // adopterState: widget.adoption?.adopterState ?? '',
        contractUrl: widget.adoption?.contractUrl ?? '',
        documentsUrl: widget.adoption?.documentsUrl ?? '',
      );

      Navigator.pop(context, adoption);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const SidebarMenu(selectedItem: 'Animais'),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderWidget(
                  title: widget.isEditing ? 'Editar Adoção' : 'Nova Adoção',
                  subtitle: 'Preencha os dados do adotante',
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
                          // Informações do animal
                          _buildSection(
                            title: 'Informações do Animal',
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Nome: ${widget.animal.nome}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Espécie: ${widget.animal.especie}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Informações do adotante
                          _buildSection(
                            title: 'Informações do Adotante',
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _nomeController,
                                  decoration: const InputDecoration(
                                    labelText: 'Nome Completo',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Por favor, insira o nome';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  controller: _cpfController,
                                  decoration: const InputDecoration(
                                    labelText: 'CPF',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Por favor, insira o CPF';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  controller: _emailController,
                                  decoration: const InputDecoration(
                                    labelText: 'E-mail',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Por favor, insira o e-mail';
                                    }
                                    if (!value.contains('@')) {
                                      return 'Por favor, insira um e-mail válido';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  controller: _telefoneController,
                                  decoration: const InputDecoration(
                                    labelText: 'Telefone',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Por favor, insira o telefone';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  controller: _enderecoController,
                                  decoration: const InputDecoration(
                                    labelText: 'Endereço',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Por favor, insira o endereço';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Data da adoção
                          _buildSection(
                            title: 'Data da Adoção',
                            child: InkWell(
                              onTap: _selecionarData,
                              child: InputDecorator(
                                decoration: const InputDecoration(
                                  labelText: 'Data da Adoção',
                                  border: OutlineInputBorder(),
                                ),
                                child: Text(
                                  _dataAdocao != null
                                      ? '${_dataAdocao!.day}/${_dataAdocao!.month}/${_dataAdocao!.year}'
                                      : 'Selecione a data',
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Status
                          _buildSection(
                            title: 'Status',
                            child: DropdownButtonFormField<String>(
                              value: _status,
                              decoration: const InputDecoration(
                                labelText: 'Status',
                                border: OutlineInputBorder(),
                              ),
                              items: const [
                                DropdownMenuItem(
                                  value: 'Pendente',
                                  child: Text('Pendente'),
                                ),
                                DropdownMenuItem(
                                  value: 'Aprovado',
                                  child: Text('Aprovado'),
                                ),
                                DropdownMenuItem(
                                  value: 'Rejeitado',
                                  child: Text('Rejeitado'),
                                ),
                                DropdownMenuItem(
                                  value: 'Concluído',
                                  child: Text('Concluído'),
                                ),
                              ],
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    _status = value;
                                  });
                                }
                              },
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Observações
                          _buildSection(
                            title: 'Observações',
                            child: TextFormField(
                              controller: _observacoesController,
                              decoration: const InputDecoration(
                                labelText: 'Observações',
                                border: OutlineInputBorder(),
                              ),
                              maxLines: 3,
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Botões de ação
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              OutlinedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: const Color(0xFF6B7280),
                                  side: const BorderSide(
                                    color: Color(0xFFE5E7EB),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                ),
                                child: const Text('Cancelar'),
                              ),
                              const SizedBox(width: 12),
                              ElevatedButton(
                                onPressed: _salvarAdocao,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF00A3D7),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                ),
                                child: Text(
                                  widget.isEditing
                                      ? 'Salvar'
                                      : 'Registrar Adoção',
                                ),
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

  Widget _buildSection({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF111827),
          ),
        ),
        const SizedBox(height: 16),
        child,
      ],
    );
  }
}
