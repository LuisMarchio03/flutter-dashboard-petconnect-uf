import 'package:flutter/material.dart';
import 'package:myapp/core/widgets/sidebar_menu.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/models/complaint_model.dart';
import '../../domain/models/complaint_form_model.dart';
import '../widgets/complaint_list_item.dart';
import '../widgets/search_bar_widget.dart';
import 'complaint_form_page.dart';

class ComplaintsPage extends StatefulWidget {
  const ComplaintsPage({super.key});

  @override
  State<ComplaintsPage> createState() => _ComplaintsPageState();
}

class _ComplaintsPageState extends State<ComplaintsPage> {
  // Lista de exemplo para demonstração
  final List<ComplaintModel> denuncias = [
    ComplaintModel(
      endereco: 'Rua das Flores, 123 - Centro',
      dataReporte: '15/06/2023',
      descricao:
          'Cachorro amarrado sem água e comida, exposto ao sol. Animal aparenta estar desnutrido e com ferimentos.',
      status: 'Pendente',
    ),
    ComplaintModel(
      endereco: 'Av. Principal, 456 - Jardim',
      dataReporte: '10/06/2023',
      descricao:
          'Colônia de gatos em terreno abandonado sem acesso a alimentos. Vários filhotes em condições precárias.',
      status: 'Atendido',
    ),
    ComplaintModel(
      endereco: 'Praça Central, s/n - Centro',
      dataReporte: '08/06/2023',
      descricao:
          'Cão de grande porte abandonado na praça, aparentemente sem dono. Animal está magro e com comportamento agressivo.',
      status: 'Pendente',
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
          const SidebarMenu(selectedItem: 'Denúncias'),
          // Conteúdo principal
          Expanded(
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
                          const Text(
                            'Denúncias',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const Text(
                            'Gerencie as denúncias de maus-tratos',
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
                  const SizedBox(height: 24),
                  // Barra de pesquisa e botão de adicionar
                  Row(
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
                      // Botão de adicionar denúncia
                      ElevatedButton.icon(
                        onPressed: _adicionarDenuncia,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                        icon: const Icon(Icons.add, color: Colors.white),
                        label: const Text(
                          'Adicionar Denúncia',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Tabela de denúncias
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          // Cabeçalho da tabela
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: _buildTableHeader('Endereço'),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: _buildTableHeader('Data'),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: _buildTableHeader('Descrição'),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: _buildTableHeader('Status'),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: _buildTableHeader('Ações'),
                                ),
                              ],
                            ),
                          ),
                          // Lista de denúncias
                          Expanded(
                            child: ListView.builder(
                              itemCount: denuncias.length,
                              itemBuilder: (context, index) {
                                return ComplaintListItem(
                                  onDetails:
                                      () {}, // Added required onDetails callback
                                  complaint: denuncias[index],
                                  onEdit: () => _editarDenuncia(index),
                                  onDelete: () {
                                    setState(() {
                                      denuncias.removeAt(index);
                                    });
                                  },
                                  onAttend: () {},
                                );
                              },
                            ),
                          ),
                        ],
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

  Widget _buildTableHeader(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
    );
  }

  // Método para adicionar uma nova denúncia
  void _adicionarDenuncia() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ComplaintFormPage()),
    );

    if (result != null && result is ComplaintFormModel) {
      setState(() {
        // Converter ComplaintFormModel para ComplaintModel
        denuncias.add(
          ComplaintModel(
            endereco: result.endereco,
            dataReporte: DateTime.now().toString().substring(0, 10),
            descricao: result.descricao,
            status: result.status,
          ),
        );
      });
    }
  }

  // Método para editar uma denúncia existente
  void _editarDenuncia(int index) async {
    // Criar um ComplaintFormModel a partir do ComplaintModel
    final denuncia = denuncias[index];
    final formModel = ComplaintFormModel(
      nomeCompleto:
          'Nome do Denunciante', // Valor padrão, já que não temos esse campo no modelo atual
      numeroCelular:
          '(00) 00000-0000', // Valor padrão, já que não temos esse campo no modelo atual
      endereco: denuncia.endereco,
      especieAnimal:
          'Não especificado', // Valor padrão, já que não temos esse campo no modelo atual
      localizacao:
          'Não especificado', // Valor padrão, já que não temos esse campo no modelo atual
      descricao: denuncia.descricao,
      status: denuncia.status,
    );

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) =>
                ComplaintFormPage(complaint: formModel, isEditing: true),
      ),
    );

    if (result != null && result is ComplaintFormModel) {
      setState(() {
        // Atualizar o ComplaintModel com os dados do ComplaintFormModel
        denuncias[index] = ComplaintModel(
          endereco: result.endereco,
          dataReporte: denuncia.dataReporte, // Manter a data original
          descricao: result.descricao,
          status: result.status,
        );
      });
    }
  }
}
