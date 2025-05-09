import 'package:flutter/material.dart';
import 'package:myapp/core/routes/app_routes.dart';
import 'package:myapp/core/widgets/confirm_delete_dialog.dart';
import 'package:myapp/core/widgets/data_table_widget.dart';
import 'package:myapp/core/widgets/sidebar_menu.dart';
import 'package:myapp/core/widgets/status_badge_widget.dart';
import 'package:myapp/features/users/domain/models/user_form_model.dart';
import '../../domain/models/user_model.dart';
import '../widgets/search_bar_widget.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  // Lista de exemplo para demonstração
  final List<UserModel> usuarios = [
    UserModel(
      nome: 'Carlos Silva',
      email: 'carlos.silva@email.com',
      perfil: 'Administrador',
    ),
    UserModel(
      nome: 'Ana Oliveira',
      email: 'ana.oliveira@email.com',
      perfil: 'Veterinário',
    ),
    UserModel(
      nome: 'Pedro Santos',
      email: 'pedro.santos@email.com',
      perfil: 'Cuidador',
    ),
    UserModel(
      nome: 'Mariana Costa',
      email: 'mariana.costa@email.com',
      perfil: 'Voluntário',
    ),
    UserModel(
      nome: 'Lucas Ferreira',
      email: 'lucas.ferreira@email.com',
      perfil: 'Administrador',
    ),
  ];
  final List<UserModel> _usuarios = [];

  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Widget _buildTableHeader(String title) {
  //   return Text(
  //     title,
  //     style: const TextStyle(
  //       fontSize: 14,
  //       fontWeight: FontWeight.bold,
  //       color: Color(0xFF6B7280),
  //     ),
  //   );
  // }

  void _adicionarNovoUsuario() async {
    final result = await AppRoutes.navigateTo<UserFormModel>(
      context,
      AppRoutes.userForm,
    );

    if (result != null) {
      setState(() {
        _usuarios.add(result as UserModel);
      });
    }
  }

  void _editarUsuario(UserModel usuario) async {
    final result = await AppRoutes.navigateTo<UserFormModel>(
      context,
      AppRoutes.userForm,
      arguments: usuario as UserFormModel,
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
                          _adicionarNovoUsuario();
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
                    padding: const EdgeInsets.all(24),
                    child: DataTableWidget(
                      columns: const ['Nome', 'Email', 'Perfil'],
                      rows: usuarios
                          .map((usuario) => {
                                'nome': usuario.nome,
                                'email': usuario.email,
                                'perfil': usuario.perfil,
                              })
                          .toList(),
                      customCellBuilders: {
                        'perfil': (value) => StatusBadgeWidget(
                          status: value.toString(),
                          statusColors: {
                            'Administrador': const Color(0xFFEF4444), // Vermelho
                            'Veterinário': const Color(0xFF3B82F6), // Azul
                            'Cuidador': const Color(0xFF10B981), // Verde
                            'Voluntário': const Color(0xFF8B5CF6), // Roxo
                          },
                        ),
                      },
                      actions: [
                        DataTableAction(
                          icon: Icons.edit,
                          color: Colors.blue,
                          tooltip: 'Editar',
                          onPressed: (index) {
                            _editarUsuario(usuarios[index]);
                          },
                        ),
                        DataTableAction(
                          icon: Icons.delete,
                          color: Colors.red,
                          tooltip: 'Excluir',
                          onPressed: (index) {
                            _confirmarExclusao(context, () {
                              setState(() {
                                usuarios.removeAt(index);
                              });
                            });
                          },
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
    );
  }
}

//   Widget _buildMenuItem(IconData icon, String title, bool isSelected) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 8),
//       decoration: BoxDecoration(
//         color: isSelected ? Colors.white.withOpacity(0.1) : Colors.transparent,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: ListTile(
//         leading: Icon(icon, color: Colors.white),
//         title: Text(
//           title,
//           style: const TextStyle(color: Colors.white, fontSize: 14),
//         ),
//         onTap: () {
//           // Implementar navegação
//         },
//         dense: true,
//         visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
//       ),
//     );
//   }
// }

void _confirmarExclusao(BuildContext context, VoidCallback onConfirm) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ConfirmDeleteDialog(
        title: 'Confirmar Exclusão',
        content:
            'Tem certeza que deseja excluir este registro? Esta ação não pode ser desfeita.',
        onConfirm: onConfirm,
      );
    },
  );
}
