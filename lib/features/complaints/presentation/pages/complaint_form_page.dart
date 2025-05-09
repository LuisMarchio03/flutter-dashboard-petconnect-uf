import 'package:flutter/material.dart';
import 'package:myapp/core/widgets/sidebar_menu.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/models/complaint_form_model.dart';
import '../widgets/header_widget.dart';
import '../widgets/form_section_widget.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/action_buttons.dart';

class ComplaintFormPage extends StatefulWidget {
  final ComplaintFormModel? complaint;
  final bool isEditing;

  const ComplaintFormPage({super.key, this.complaint, this.isEditing = false});

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
            child: Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeaderWidget(
                    title: 'Cadastro de Denúncia',
                    subtitle: 'Registre uma nova denúncia de maus-tratos',
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildDenuncianteInfo(),
                            const SizedBox(height: 24),
                            _buildAnimalInfo(),
                            const SizedBox(height: 24),
                            _buildDenunciaInfo(),
                            const SizedBox(height: 32),
                            ActionButtons(
                              onSave: _salvarDenuncia,
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

  Widget _buildDenuncianteInfo() {
    return FormSectionWidget(
      title: 'Informações do Denunciante',
      icon: '',
      child: Column(
        children: [
          CustomTextField(
            controller: _nomeCompletoController,
            label: 'Nome Completo',
            hint: 'Digite seu nome completo',
            icon: Icons.person,
            prefixIcon: Icons.person,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, digite seu nome';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: _numeroCelularController,
            label: 'Telefone',
            hint: 'Digite seu número de telefone',
            icon: Icons.phone,
            prefixIcon: Icons.phone,
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, digite seu telefone';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: _enderecoController,
            label: 'Endereço',
            hint: 'Digite seu endereço completo',
            icon: Icons.home,
            prefixIcon: Icons.home,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, digite seu endereço';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAnimalInfo() {
    return FormSectionWidget(
      title: 'Informações do Animal',
      icon: '',
      child: Column(
        children: [
          CustomTextField(
            controller: _especieAnimalController,
            label: 'Espécie do Animal',
            hint: 'Digite a espécie do animal (ex: cachorro, gato)',
            icon: Icons.pets,
            prefixIcon: Icons.pets,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, digite a espécie do animal';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: _localizacaoController,
            label: 'Localização do Animal',
            hint: 'Digite onde o animal foi visto',
            icon: Icons.location_on,
            prefixIcon: Icons.location_on,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, digite a localização do animal';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDenunciaInfo() {
    return FormSectionWidget(
      title: 'Detalhes da Denúncia',
      icon: '',
      child: Column(
        children: [
          CustomTextField(
            controller: _descricaoController,
            label: 'Descrição',
            hint: 'Descreva a situação em detalhes',
            icon: Icons.description,
            prefixIcon: Icons.description,
            maxLines: 5,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, descreva a situação';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child:
                _fotoUrl != null
                    ? Image.network(_fotoUrl!, fit: BoxFit.cover)
                    : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.photo_camera,
                            size: 40,
                            color: Color(0xFF6B7280),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Adicione uma foto ou vídeo',
                            style: TextStyle(
                              color: Color(0xFF6B7280),
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          TextButton.icon(
                            onPressed: () {
                              // TODO: Implementar upload de foto
                            },
                            icon: const Icon(Icons.upload_file, size: 16),
                            label: const Text('Selecionar arquivo'),
                            style: TextButton.styleFrom(
                              foregroundColor: const Color(0xFF00A3D7),
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
}
