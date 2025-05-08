import 'package:flutter/material.dart';
import 'package:myapp/core/routes/app_routes.dart';
import 'package:myapp/core/widgets/sidebar_menu.dart';
import 'package:myapp/features/users/domain/models/user_form_model.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/models/user_model.dart';
import '../widgets/user_list_item.dart';
import '../widgets/search_bar_widget.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  // Lista de exemplo para demonstração
  final List<UserModel> usuarios = [
    UserModel(nome: 'Carlos Silva', email: 'carlos.silva@email.com', perfil: 'Administrador'),
    UserModel(nome: 'Ana Oliveira', email: 'ana.oliveira@email.com', perfil: 'Veterinário'),
    UserModel(nome: 'Pedro Santos', email: 'pedro.santos@email.com', perfil: 'Cuidador'),
    UserModel(nome: 'Mariana Costa', email: 'mariana.costa@email.com', perfil: 'Voluntário'),
    UserModel(nome: 'Lucas Ferreira', email: 'lucas.ferreira@email.com', perfil: 'Administrador'),
  ];
  final List<UserModel> _usuarios = [];

  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildTableHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Color(0xFF6B7280),
      ),
    );
  }

  void _adicionarNovoUsuario() async {
    final result = await AppRoutes.navigateTo<UserFormModel>(
      context, 
      AppRoutes.userForm
    );
    
    if (result != null) {
      setState(() {
        _usuarios.add(result as UserModel);
      });
    }
  }

  void _editarUsuario(UserFormModel usuario) async {
    final result = await AppRoutes.navigateTo<UserFormModel>(
      context, 
      AppRoutes.userForm,
      arguments: usuario
    );
    
    if (result != null) {
      setState(() {
        final index = _usuarios.indexWhere((u) => u.email == usuario.email);
        if (index != -1) {
          _usuarios[index] = result as UserModel;
        }
      });
    }
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Cabeçalho
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Usuários',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF333333),
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Gestão completa dos usuários do sistema',
                            style: TextStyle(
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
                            radius: 16,
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
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF333333),
                                ),
                              ),
                              const Text(
                                'admin@gmail.com',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF6B7280),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Barra de pesquisa e botão de adicionar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Expanded(
                        child: SearchBarWidget(
                          controller: _searchController,
                          onChanged: (value) {
                            // Implementar pesquisa
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton.icon(
                        onPressed: () {
                          // Implementar adição de usuário
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00A3D7),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        icon: const Icon(Icons.add, color: Colors.white),
                        label: const Text(
                          'Adicionar Usuário',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Tabela de usuários
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Cabeçalho da tabela
                          Container(
                            decoration: const BoxDecoration(
                              color: Color(0xFFF9FAFB),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: _buildTableHeader('Nome'),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: _buildTableHeader('Email'),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: _buildTableHeader('Perfil'),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: _buildTableHeader('Ações'),
                                ),
                              ],
                            ),
                          ),
                          // Lista de usuários
                          Expanded(
                            child: ListView.builder(
                              itemCount: usuarios.length,
                              itemBuilder: (context, index) {
                                final user = usuarios[index];
                                return UserListItem(
                                  user: user,
                                  onEdit: () {
                                    // Implementar edição
                                  },
                                  onDelete: () {
                                    // Implementar exclusão
                                  },
                                );
                              },
                            ),
                          ),
                          // Paginação
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Text(
                                  'Mostrando ${usuarios.length} de 25 usuários',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF6B7280),
                                  ),
                                ),
                                const Spacer(),
                                TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    'Anterior',
                                    style: TextStyle(
                                      color: Color(0xFF6B7280),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF00A3D7),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    '1',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    '2',
                                    style: TextStyle(
                                      color: Color(0xFF6B7280),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    '3',
                                    style: TextStyle(
                                      color: Color(0xFF6B7280),
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    'Próximo',
                                    style: TextStyle(
                                      color: Color(0xFF6B7280),
                                    ),
                                  ),
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
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.white,
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        onTap: () {
          // Implementar navegação
        },
        dense: true,
        visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
      ),
    );
  }
}