import 'package:flutter/material.dart';
import 'package:myapp/core/widgets/confirm_delete_dialog.dart';
import 'package:myapp/core/widgets/sidebar_menu.dart';
import 'package:myapp/features/rescues/domain/models/rescue_form_model.dart';
import 'package:myapp/features/rescues/presentation/pages/rescue_form_page.dart';
import '../../domain/models/rescue_model.dart';
import '../widgets/rescue_list_item.dart';
import '../widgets/search_bar_widget.dart';

class RescuesPage extends StatefulWidget {
  const RescuesPage({super.key});

  @override
  State<RescuesPage> createState() => _RescuesPageState();
}

class _RescuesPageState extends State<RescuesPage> {
  // Lista de exemplo para demonstração
  final List<RescueModel> resgates = [
    RescueModel(
      endereco: '123 Rua Principal, Apt 4B',
      descricao:
          'Gato ferido encontrado embaixo de um carro estacionado. Parece ter uma pata ferida e é incapaz de andar corretamente. Muito assustado, mas não agressivo.',
      especie: 'Gato doméstico',
      status: 'Ativo',
      data: '2023-09-25',
      hora: '14:30',
      nomeAnimal: 'Max',
      idade: '3 anos',
    ),
    RescueModel(
      endereco: 'Avenida Oak, 456',
      descricao:
          'O guaxinim parece estar desorientado e andando em círculos. Possivelmente doente ou ferido. Localizado perto do parque infantil. Preocupado com a segurança pública.',
      especie: 'Guaxinim',
      status: 'Pendente',
      data: '2023-09-24',
      hora: '11:00',
      nomeAnimal: '',
      idade: '',
    ),
  ];

  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
                            'Resgate',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF333333),
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Listagem de resgate',
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
                // Barra de pesquisa
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
                      // Botão de adicionar resgate
                      ElevatedButton.icon(
                        onPressed: () {
                          _adicionarResgate();
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
                          'Novo Resgate',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Lista de resgates
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
                      child: ListView.builder(
                        itemCount: resgates.length,
                        itemBuilder: (context, index) {
                          return RescueListItem(
                            rescue: resgates[index],
                            onEdit: () {
                              _editarResgate(index);
                            },
                            onDelete: () {
                              _confirmarExclusao(context, () {
                                setState(() {
                                  resgates.removeAt(index);
                                });
                              });
                            },
                            onDetails: () {},
                            onUpdateStatus: () {},
                          );
                        },
                      ),
                    ),
                  ),
                ),
                // Paginação
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    children: [
                      Text(
                        'Mostrando ${resgates.length} de ${resgates.length} resgates',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFE5E7EB)),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.chevron_left),
                              onPressed: () {},
                              color: const Color(0xFF6B7280),
                              iconSize: 20,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: const BoxDecoration(
                                color: Color(0xFF00A3D7),
                                border: Border.symmetric(
                                  vertical: BorderSide(
                                    color: Color(0xFFE5E7EB),
                                  ),
                                ),
                              ),
                              child: const Text(
                                '1',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.chevron_right),
                              onPressed: () {},
                              color: const Color(0xFF6B7280),
                              iconSize: 20,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
        onTap: () {
          // Implementar navegação
        },
        dense: true,
        visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
      ),
    );
  }

  // Método para adicionar um novo resgate
  void _adicionarResgate() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RescueFormPage()),
    );

    if (result != null) {
      setState(() {
        resgates.add(result);
      });
    }
  }

  void _editarResgate(int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) =>
                RescueFormPage(rescue: resgates[index], isEditing: true),
      ),
    );

    if (result != null) {
      setState(() {
        resgates[index] = result;
      });
    }
  }
}

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
