import 'package:flutter/material.dart';
import 'package:myapp/core/widgets/sidebar_menu.dart';
import 'package:myapp/features/rescues/domain/models/rescue_model.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/models/animal_model.dart';

class AnimalFormPage extends StatefulWidget {
  final AnimalModel? animal;
  final bool isEditing;

  const AnimalFormPage({super.key, this.animal, this.isEditing = false, required RescueModel resgate});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Menu lateral
          const SidebarMenu(selectedItem: 'Animais'),
          // Conteúdo principal
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Cabeçalho
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.isEditing
                                  ? 'Editar Animal'
                                  : 'Adicionar Animal',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const Text(
                              'Preencha os dados do animal',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                        // Perfil do usuário
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(
                                'https://randomuser.me/api/portraits/men/1.jpg',
                              ),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Andrew D.',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  'admin@gmail.com',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    // Formulário
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Informações Detalhadas
                          const Text(
                            'Informações Detalhadas',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          // Raça
                          _buildTextField(
                            label: 'Raça',
                            controller: _racaController,
                          ),
                          const SizedBox(height: 16),
                          // Cor
                          _buildTextField(
                            label: 'Cor',
                            controller: _corController,
                          ),
                          const SizedBox(height: 16),
                          // Peso
                          _buildTextField(
                            label: 'Peso (kg)',
                            controller: _pesoController,
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(height: 16),
                          // Observações
                          _buildTextField(
                            label: 'Observações',
                            controller: _observacoesController,
                            maxLines: 3,
                          ),
                          const SizedBox(height: 16),
                          // Porte
                          _buildTextField(
                            label: 'Porte',
                            controller: _porteController,
                          ),
                          const SizedBox(height: 16),
                          // Espécie
                          _buildTextField(
                            label: 'Espécie',
                            controller: _especieController,
                          ),
                          const SizedBox(height: 16),
                          // Idade
                          _buildTextField(
                            label: 'Idade',
                            controller: _idadeController,
                          ),
                          const SizedBox(height: 16),
                          // Localização
                          _buildTextField(
                            label: 'Onde ele foi localizado?',
                            controller: _localizacaoController,
                          ),
                          const SizedBox(height: 32),

                          // Informações de Saúde
                          const Text(
                            'Informações de Saúde',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          // Última Vacina
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Última Vacina'),
                                    const SizedBox(height: 8),
                                    InkWell(
                                      onTap: () async {
                                        final date = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime.now(),
                                        );
                                        if (date != null) {
                                          setState(() {
                                            _ultimaVacina = date;
                                          });
                                        }
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 12,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[100],
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.calendar_today,
                                              size: 20,
                                              color: Colors.blue,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              _ultimaVacina != null
                                                  ? '${_ultimaVacina!.day}/${_ultimaVacina!.month}/${_ultimaVacina!.year}'
                                                  : 'Selecionar Data',
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Próxima Vacina'),
                                    const SizedBox(height: 8),
                                    InkWell(
                                      onTap: () async {
                                        final date = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now().add(
                                            const Duration(days: 30),
                                          ),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime(2100),
                                        );
                                        if (date != null) {
                                          setState(() {
                                            _proximaVacina = date;
                                          });
                                        }
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 12,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[100],
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.calendar_today,
                                              size: 20,
                                              color: Colors.blue,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              _proximaVacina != null
                                                  ? '${_proximaVacina!.day}/${_proximaVacina!.month}/${_proximaVacina!.year}'
                                                  : 'Selecionar Data',
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // Condições Médicas
                          _buildTextField(
                            label: 'Condições Médicas',
                            controller: _condicoesMedicasController,
                            maxLines: 3,
                          ),
                          const SizedBox(height: 32),

                          // Botões de ação
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Cancelar',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                              const SizedBox(width: 16),
                              ElevatedButton(
                                onPressed: _salvarAnimal,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text(
                                  'Salvar',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String text, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white.withOpacity(0.2) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(text, style: const TextStyle(color: Colors.white)),
        onTap: () {},
        dense: true,
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[100],
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
