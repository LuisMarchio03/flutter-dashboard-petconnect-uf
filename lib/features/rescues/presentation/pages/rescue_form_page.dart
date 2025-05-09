import 'package:flutter/material.dart';
import 'package:myapp/core/widgets/sidebar_menu.dart';
import '../../../../features/rescues/domain/models/rescue_form_model.dart';
import '../../../../features/rescues/domain/models/rescue_model.dart';

class RescueFormPage extends StatefulWidget {
  final RescueModel? rescue;
  final bool isEditing;

  const RescueFormPage({
    Key? key,
    this.rescue,
    this.isEditing = false,
  }) : super(key: key);

  @override
  State<RescueFormPage> createState() => _RescueFormPageState();
}

class _RescueFormPageState extends State<RescueFormPage> {
  final _formKey = GlobalKey<FormState>();
  
  // Controladores para os campos do formulário
  final _nomeAnimalController = TextEditingController();
  final _especieController = TextEditingController();
  final _idadeController = TextEditingController();
  final _sexoController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _dataController = TextEditingController();
  final _horaController = TextEditingController();
  final _condicaoAnimalController = TextEditingController();
  final _observacoesController = TextEditingController();
  
  String _especie = '';
  String _sexo = '';
  String _condicaoAnimal = '';
  List<String> _fotos = [];

  @override
  void initState() {
    super.initState();
    
    // Se estiver editando, preencher os campos com os dados do resgate
    if (widget.isEditing && widget.rescue != null) {
      _nomeAnimalController.text = widget.rescue!.nomeAnimal ?? '';
      _especieController.text = widget.rescue!.especie ?? '';
      _idadeController.text = widget.rescue!.idade ?? '';
      _sexoController.text = widget.rescue!.sexo ?? '';
      _descricaoController.text = widget.rescue!.observacoes!;
      _enderecoController.text = widget.rescue!.localizacao!;
      _dataController.text = widget.rescue!.dataResgate!;
      _condicaoAnimalController.text = widget.rescue!.condicaoAnimal ?? '';
      _observacoesController.text = widget.rescue!.observacoes ?? '';
      
      _especie = widget.rescue!.especie ?? '';
      _sexo = widget.rescue!.sexo ?? '';
      _condicaoAnimal = widget.rescue!.condicaoAnimal ?? '';
    }
  }

  @override
  void dispose() {
    _nomeAnimalController.dispose();
    _especieController.dispose();
    _idadeController.dispose();
    _sexoController.dispose();
    _descricaoController.dispose();
    _enderecoController.dispose();
    _dataController.dispose();
    _horaController.dispose();
    _condicaoAnimalController.dispose();
    _observacoesController.dispose();
    super.dispose();
  }

  void _salvarResgate() {
    if (_formKey.currentState!.validate()) {
      // Criar um novo objeto RescueFormModel com os dados do formulário
      final rescue = RescueFormModel(
        nomeAnimal: _nomeAnimalController.text,
        especie: _especie,
        idade: _idadeController.text,
        sexo: _sexo,
        descricao: _descricaoController.text,
        endereco: _enderecoController.text,
        data: _dataController.text,
        hora: _horaController.text,
        condicaoAnimal: _condicaoAnimal,
        observacoes: _observacoesController.text,
        fotos: _fotos,
      );
      
      // Retornar o objeto para a tela anterior
      Navigator.pop(context, rescue);
    }
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    String? hintText,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    bool readOnly = false,
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
          maxLines: maxLines,
          keyboardType: keyboardType,
          readOnly: readOnly,
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
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF374151),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF9FAFB),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonFormField<String>(
            value: value.isNotEmpty ? value : null,
            hint: Text(label),
            decoration: InputDecoration(
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
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: onChanged,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Campo obrigatório';
              }
              return null;
            },
          ),
        ),
      ],
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
        title: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
        onTap: () {},
        dense: true,
        visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Menu lateral
          const SidebarMenu(selectedItem: 'Resgates'),
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
                              widget.isEditing ? 'Editar Resgate' : 'Resgates',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF333333),
                              ),
                            ),
                            Text(
                              widget.isEditing ? 'Atualize os dados do resgate' : 'Cadastrar um resgate',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF6B7280),
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
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Andrew D.',
                                  style: TextStyle(fontWeight: FontWeight.bold),
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
                          // Nome do Animal
                          _buildTextField(
                            label: 'Nome do Animal',
                            controller: _nomeAnimalController,
                            hintText: 'Digite o nome do animal',
                          ),
                          const SizedBox(height: 16),
                          
                          // Espécie
                          _buildDropdown(
                            label: 'Selecione a espécie',
                            value: _especie,
                            items: ['Cachorro', 'Gato', 'Ave', 'Outro'],
                            onChanged: (value) {
                              setState(() {
                                _especie = value ?? '';
                              });
                            },
                          ),
                          const SizedBox(height: 16),
                          
                          // Idade
                          Row(
                            children: [
                              Expanded(
                                child: _buildTextField(
                                  label: 'Idade',
                                  controller: _idadeController,
                                  hintText: 'Ex: 2',
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.only(top: 22),
                                  child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
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
                                    value: 'Unidade',
                                    items: const [
                                      DropdownMenuItem(
                                        value: 'Unidade',
                                        child: Text('Unidade'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Meses',
                                        child: Text('Meses'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Anos',
                                        child: Text('Anos'),
                                      ),
                                    ],
                                    onChanged: (value) {},
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          
                          // Sexo
                          _buildDropdown(
                            label: 'Selecione o sexo',
                            value: _sexo,
                            items: ['Macho', 'Fêmea'],
                            onChanged: (value) {
                              setState(() {
                                _sexo = value ?? '';
                              });
                            },
                          ),
                          const SizedBox(height: 16),
                          
                          // Descrição
                          _buildTextField(
                            label: 'Descrição',
                            controller: _descricaoController,
                            hintText: 'Descreva as características do animal',
                            maxLines: 4,
                          ),
                          const SizedBox(height: 32),
                          
                          // Local do Resgate
                          _buildTextField(
                            label: 'Local do Resgate',
                            controller: _enderecoController,
                            hintText: 'Digite o endereço',
                          ),
                          const SizedBox(height: 16),
                          
                          // Data e Hora
                          Row(
                            children: [
                              Expanded(
                                child: _buildTextField(
                                  label: 'Data',
                                  controller: _dataController,
                                  hintText: 'DD/MM/AAAA',
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildTextField(
                                  label: 'Hora',
                                  controller: _horaController,
                                  hintText: 'HH:MM',
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          
                          // Condição do animal
                          _buildDropdown(
                            label: 'Condição do animal',
                            value: _condicaoAnimal,
                            items: ['Saudável', 'Ferido', 'Doente', 'Crítico'],
                            onChanged: (value) {
                              setState(() {
                                _condicaoAnimal = value ?? '';
                              });
                            },
                          ),
                          const SizedBox(height: 16),
                          
                          // Observações
                          _buildTextField(
                            label: 'Observações',
                            controller: _observacoesController,
                            hintText: 'Informações adicionais sobre o resgate',
                            maxLines: 4,
                          ),
                          const SizedBox(height: 32),
                          
                          // Upload de fotos
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Fotos',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF374151),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                width: double.infinity,
                                height: 120,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF9FAFB),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    // Implementar upload de fotos
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.add_photo_alternate,
                                        size: 40,
                                        color: Colors.grey[600],
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Toque para adicionar fotos',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
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
                                  style: TextStyle(
                                    color: Color(0xFF6B7280),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              ElevatedButton(
                                onPressed: _salvarResgate,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF00A3D7),
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
}