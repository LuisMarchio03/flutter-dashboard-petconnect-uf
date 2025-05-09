import 'package:flutter/material.dart';
import 'package:myapp/core/widgets/sidebar_menu.dart';
import 'package:myapp/features/animals/domain/models/animal_model.dart';
import 'package:myapp/features/animals/presentation/widgets/header_widget.dart';
import 'package:myapp/features/sponsorships/domain/models/sponsorship_model.dart';

class SponsorshipFormPage extends StatefulWidget {
  final AnimalModel animal;
  final SponsorshipModel? sponsorship;
  final bool isEditing;

  const SponsorshipFormPage({
    Key? key,
    required this.animal,
    this.sponsorship,
    this.isEditing = false,
  }) : super(key: key);

  @override
  State<SponsorshipFormPage> createState() => _SponsorshipFormPageState();
}

class _SponsorshipFormPageState extends State<SponsorshipFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _cpfController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _valorController = TextEditingController();
  final _observacoesController = TextEditingController();
  DateTime? _dataInicio;
  DateTime? _dataFim;
  String _status = 'Ativo';

  @override
  void initState() {
    super.initState();
    if (widget.isEditing && widget.sponsorship != null) {
      _nomeController.text = widget.sponsorship!.padrinho;
      _cpfController.text = widget.sponsorship!.cpf;
      _emailController.text = widget.sponsorship!.email;
      _telefoneController.text = widget.sponsorship!.telefone;
      _enderecoController.text = widget.sponsorship!.endereco;
      _valorController.text = widget.sponsorship!.valorMensal.toString();
      _observacoesController.text = widget.sponsorship!.observacoes;
      _dataInicio = widget.sponsorship!.dataInicio;
      _dataFim = widget.sponsorship!.dataFim;
      _status = widget.sponsorship!.status;
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _cpfController.dispose();
    _emailController.dispose();
    _telefoneController.dispose();
    _enderecoController.dispose();
    _valorController.dispose();
    _observacoesController.dispose();
    super.dispose();
  }

  Future<void> _selecionarDataInicio() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dataInicio ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _dataInicio) {
      setState(() {
        _dataInicio = picked;
      });
    }
  }

  Future<void> _selecionarDataFim() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dataFim ?? DateTime.now(),
      firstDate: _dataInicio ?? DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _dataFim) {
      setState(() {
        _dataFim = picked;
      });
    }
  }

  void _salvarApadrinhamento() {
    if (_formKey.currentState!.validate()) {
      final sponsorship = SponsorshipModel(
        id:
            widget.sponsorship?.id ??
            DateTime.now().millisecondsSinceEpoch.toString(),
        animalId: widget.animal.nome,
        animalNome: widget.animal.nome,
        padrinho: _nomeController.text,
        cpf: _cpfController.text,
        email: _emailController.text,
        telefone: _telefoneController.text,
        endereco: _enderecoController.text,
        dataInicio: _dataInicio ?? DateTime.now(),
        dataFim: _dataFim,
        valorMensal: double.parse(_valorController.text),
        status: _status,
        observacoes: _observacoesController.text,
      );

      Navigator.pop(context, sponsorship);
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
                  title:
                      widget.isEditing
                          ? 'Editar Apadrinhamento'
                          : 'Novo Apadrinhamento',
                  subtitle: 'Preencha os dados do padrinho',
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

                          // Informações do padrinho
                          _buildSection(
                            title: 'Informações do Padrinho',
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

                          // Valor mensal
                          _buildSection(
                            title: 'Valor Mensal',
                            child: TextFormField(
                              controller: _valorController,
                              decoration: const InputDecoration(
                                labelText: 'Valor Mensal',
                                border: OutlineInputBorder(),
                                prefixText: 'R\$ ',
                              ),
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
                          const SizedBox(height: 24),

                          // Datas
                          _buildSection(
                            title: 'Período',
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: _selecionarDataInicio,
                                  child: InputDecorator(
                                    decoration: const InputDecoration(
                                      labelText: 'Data de Início',
                                      border: OutlineInputBorder(),
                                    ),
                                    child: Text(
                                      _dataInicio != null
                                          ? '${_dataInicio!.day}/${_dataInicio!.month}/${_dataInicio!.year}'
                                          : 'Selecione a data',
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                InkWell(
                                  onTap: _selecionarDataFim,
                                  child: InputDecorator(
                                    decoration: const InputDecoration(
                                      labelText: 'Data de Término (opcional)',
                                      border: OutlineInputBorder(),
                                    ),
                                    child: Text(
                                      _dataFim != null
                                          ? '${_dataFim!.day}/${_dataFim!.month}/${_dataFim!.year}'
                                          : 'Selecione a data',
                                    ),
                                  ),
                                ),
                              ],
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
                                  value: 'Ativo',
                                  child: Text('Ativo'),
                                ),
                                DropdownMenuItem(
                                  value: 'Suspenso',
                                  child: Text('Suspenso'),
                                ),
                                DropdownMenuItem(
                                  value: 'Encerrado',
                                  child: Text('Encerrado'),
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
                                onPressed: _salvarApadrinhamento,
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
                                      : 'Registrar Apadrinhamento',
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
