import 'package:flutter/material.dart';
import 'package:myapp/core/widgets/sidebar_menu.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/models/complaint_form_model.dart';

class ComplaintFormPage extends StatefulWidget {
  final ComplaintFormModel? complaint;
  final bool isEditing;

  const ComplaintFormPage({
    super.key,
    this.complaint,
    this.isEditing = false,
  });

  @override
  State<ComplaintFormPage> createState() => _ComplaintFormPageState();
}

class _ComplaintFormPageState extends State<ComplaintFormPage> {
  final _formKey = GlobalKey<FormState>();
  
  // Controladores para os campos do formulário
  final _nomeCompletoController = TextEditingController();
  final _numeroCelularController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _especieAnimalController = TextEditingController();
  final _localizacaoController = TextEditingController();
  final _descricaoController = TextEditingController();
  
  String _status = 'Pendente';
  String? _fotoUrl;

  @override
  void initState() {
    super.initState();
    
    // Preencher os campos se estiver editando
    if (widget.isEditing && widget.complaint != null) {
      _nomeCompletoController.text = widget.complaint!.nomeCompleto;
      _numeroCelularController.text = widget.complaint!.numeroCelular;
      _enderecoController.text = widget.complaint!.endereco;
      _especieAnimalController.text = widget.complaint!.especieAnimal;
      _localizacaoController.text = widget.complaint!.localizacao;
      _descricaoController.text = widget.complaint!.descricao;
      _status = widget.complaint!.status;
      _fotoUrl = widget.complaint!.fotoUrl;
    }
  }

  @override
  void dispose() {
    _nomeCompletoController.dispose();
    _numeroCelularController.dispose();
    _enderecoController.dispose();
    _especieAnimalController.dispose();
    _localizacaoController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  void _salvarDenuncia() {
    if (_formKey.currentState!.validate()) {
      final complaint = ComplaintFormModel(
        id: widget.complaint?.id,
        nomeCompleto: _nomeCompletoController.text,
        numeroCelular: _numeroCelularController.text,
        endereco: _enderecoController.text,
        especieAnimal: _especieAnimalController.text,
        localizacao: _localizacaoController.text,
        descricao: _descricaoController.text,
        fotoUrl: _fotoUrl,
        status: _status,
      );
      
      // Retornar a denúncia para a página anterior
      Navigator.pop(context, complaint);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Menu lateral
          const SidebarMenu(selectedItem: 'Denúncias'),
          // Conteúdo principal
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
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
                                widget.isEditing ? 'Editar Denúncia' : 'Cadastrar Denúncias',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const Text(
                                'Cadastro de denúncias recebidas',
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
                              const SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Andrew D.',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
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
                      // Nome completo
                      _buildTextField(
                        label: 'Nome completo *',
                        controller: _nomeCompletoController,
                        hintText: 'Digite seu nome completo',
                      ),
                      const SizedBox(height: 16),
                      
                      // Número do celular
                      _buildTextField(
                        label: 'Número do celular *',
                        controller: _numeroCelularController,
                        hintText: 'Digite seu número de telefone',
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 16),
                      
                      // Endereço
                      _buildTextField(
                        label: 'Endereço *',
                        controller: _enderecoController,
                        hintText: 'Digite o endereço da denúncia',
                      ),
                      const SizedBox(height: 16),
                      
                      // Espécie do animal
                      _buildTextField(
                        label: 'Espécie do animal *',
                        controller: _especieAnimalController,
                        hintText: 'Insira as espécies do animais (por exemplo, cachorro, gato, pássaro)',
                      ),
                      const SizedBox(height: 16),
                      
                      // Localização
                      _buildTextField(
                        label: 'Localização *',
                        controller: _localizacaoController,
                        hintText: 'O local onde você viu o animal',
                      ),
                      const SizedBox(height: 16),
                      
                      // Descrição
                      _buildTextField(
                        label: 'Descrição *',
                        controller: _descricaoController,
                        hintText: 'Descreva a situação em detalhes',
                        maxLines: 5,
                      ),
                      const SizedBox(height: 16),
                      
                      // Foto ou vídeo
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Foto ou vídeo'),
                          const SizedBox(height: 8),
                          Container(
                            height: 150,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey[300]!),
                            ),
                            child: _fotoUrl != null
                                ? Image.network(_fotoUrl!, fit: BoxFit.cover)
                                : Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.photo_camera, size: 40, color: Colors.grey[400]),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Foto ou vídeo da denúncia',
                                          style: TextStyle(color: Colors.grey[500]),
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
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          const SizedBox(width: 16),
                          ElevatedButton(
                            onPressed: _salvarDenuncia,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                            ),
                            child: const Text(
                              'Salvar',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
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
        title: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
        onTap: () {},
        dense: true,
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    String? hintText,
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
            hintText: hintText,
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.all(12),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Este campo é obrigatório';
            }
            return null;
          },
        ),
      ],
    );
  }
}