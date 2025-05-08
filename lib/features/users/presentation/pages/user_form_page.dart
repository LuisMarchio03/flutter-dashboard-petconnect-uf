import 'package:flutter/material.dart';
import 'package:myapp/core/widgets/sidebar_menu.dart';
import '../../domain/models/user_form_model.dart';
import '../widgets/user_personal_info_form.dart';
import '../widgets/user_access_info_form.dart';
import '../widgets/user_type_form.dart';
import '../widgets/user_address_form.dart';
import '../widgets/user_animals_form.dart';
import '../../../../core/theme/app_colors.dart';

class UserFormPage extends StatefulWidget {
  final UserFormModel? user;
  final bool isEditing;

  const UserFormPage({
    Key? key,
    this.user,
    this.isEditing = false,
  }) : super(key: key);

  @override
  State<UserFormPage> createState() => _UserFormPageState();
}

class _UserFormPageState extends State<UserFormPage> {
  final _formKey = GlobalKey<FormState>();
  
  // Controladores para os campos do formulário
  final _nomeCompletoController = TextEditingController();
  final _cpfController = TextEditingController();
  final _dataNascimentoController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _nomeUsuarioController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmarSenhaController = TextEditingController();
  final _enderecoCompletoController = TextEditingController();
  final _cidadeController = TextEditingController();
  final _estadoController = TextEditingController();
  final _cepController = TextEditingController();
  
  String _tipoUsuario = 'Cliente';
  List<String> _perfisAcesso = [];
  List<AnimalVinculado> _animaisVinculados = [];
  String? _fotoUrl;

  @override
  void initState() {
    super.initState();
    
    // Preencher os campos se estiver editando
    if (widget.isEditing && widget.user != null) {
      _nomeCompletoController.text = widget.user!.nomeCompleto;
      _cpfController.text = widget.user!.cpf;
      _dataNascimentoController.text = widget.user!.dataNascimento;
      _emailController.text = widget.user!.email;
      _telefoneController.text = widget.user!.telefone;
      _nomeUsuarioController.text = widget.user!.nomeUsuario;
      _senhaController.text = '********'; // Senha mascarada
      _confirmarSenhaController.text = '********'; // Senha mascarada
      _enderecoCompletoController.text = widget.user!.enderecoCompleto;
      _cidadeController.text = widget.user!.cidade;
      _estadoController.text = widget.user!.estado;
      _cepController.text = widget.user!.cep;
      _tipoUsuario = widget.user!.tipoUsuario;
      _perfisAcesso = List<String>.from(widget.user!.perfisAcesso);
      _animaisVinculados = List<AnimalVinculado>.from(widget.user!.animaisVinculados);
      _fotoUrl = widget.user!.fotoUrl;
    }
  }

  @override
  void dispose() {
    _nomeCompletoController.dispose();
    _cpfController.dispose();
    _dataNascimentoController.dispose();
    _emailController.dispose();
    _telefoneController.dispose();
    _nomeUsuarioController.dispose();
    _senhaController.dispose();
    _confirmarSenhaController.dispose();
    _enderecoCompletoController.dispose();
    _cidadeController.dispose();
    _estadoController.dispose();
    _cepController.dispose();
    super.dispose();
  }

  void _salvarUsuario() {
    if (_formKey.currentState!.validate()) {
      // Criar um novo objeto UserFormModel com os dados do formulário
      final user = UserFormModel(
        nomeCompleto: _nomeCompletoController.text,
        cpf: _cpfController.text,
        dataNascimento: _dataNascimentoController.text,
        email: _emailController.text,
        telefone: _telefoneController.text,
        nomeUsuario: _nomeUsuarioController.text,
        senha: _senhaController.text,
        enderecoCompleto: _enderecoCompletoController.text,
        cidade: _cidadeController.text,
        estado: _estadoController.text,
        cep: _cepController.text,
        tipoUsuario: _tipoUsuario,
        perfisAcesso: _perfisAcesso,
        animaisVinculados: _animaisVinculados,
        fotoUrl: _fotoUrl,
      );
      
      // Retornar o objeto para a tela anterior
      Navigator.pop(context, user);
    }
  }

  void _atualizarFoto(String url) {
    setState(() {
      _fotoUrl = url;
    });
  }

  void _atualizarTipoUsuario(String tipo) {
    setState(() {
      _tipoUsuario = tipo;
    });
  }

  void _atualizarPerfisAcesso(List<String> perfis) {
    setState(() {
      _perfisAcesso = perfis;
    });
  }

  void _adicionarAnimal(AnimalVinculado animal) {
    setState(() {
      _animaisVinculados.add(animal);
    });
  }

  void _removerAnimal(int index) {
    setState(() {
      _animaisVinculados.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Menu lateral
          const SidebarMenu(selectedItem: 'Usuários'),
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
                              widget.isEditing ? 'Editar Usuário' : 'Cadastro de Usuário',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF333333),
                              ),
                            ),
                            Text(
                              widget.isEditing ? 'Atualize os dados do usuário' : 'Gerenciar usuários',
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
                          // Informações Pessoais
                          UserPersonalInfoForm(
                            nomeCompletoController: _nomeCompletoController,
                            cpfController: _cpfController,
                            dataNascimentoController: _dataNascimentoController,
                            emailController: _emailController,
                            telefoneController: _telefoneController,
                            fotoUrl: _fotoUrl,
                            onFotoChanged: _atualizarFoto, 
                            onChangeFoto: () {  },
                          ),
                          const SizedBox(height: 32),
                          
                          // Informações de Acesso
                          UserAccessInfoForm(
                            nomeUsuarioController: _nomeUsuarioController,
                            senhaController: _senhaController,
                            confirmarSenhaController: _confirmarSenhaController,
                            isEditing: widget.isEditing,
                          ),
                          const SizedBox(height: 32),
                          
                          // Tipo de Usuário
                          UserTypeForm(
                            tipoUsuario: _tipoUsuario,
                            perfisAcesso: _perfisAcesso,
                            onTipoUsuarioChanged: _atualizarTipoUsuario,
                            onPerfisAcessoChanged: _atualizarPerfisAcesso,
                          ),
                          const SizedBox(height: 32),
                          
                          // Endereço
                          UserAddressForm(
                            enderecoCompletoController: _enderecoCompletoController,
                            cidadeController: _cidadeController,
                            estadoController: _estadoController,
                            cepController: _cepController,
                          ),
                          const SizedBox(height: 32),
                          
                          // Vincular Animais
                          UserAnimalsForm(
                            animaisVinculados: _animaisVinculados,
                            onAnimalAdded: _adicionarAnimal,
                            onAnimalRemoved: _removerAnimal, onAnimaisChanged: (List<AnimalVinculado> animais) {
                                
                            }, 

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
                                onPressed: _salvarUsuario,
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
}