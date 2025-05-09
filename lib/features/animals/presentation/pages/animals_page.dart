import 'package:flutter/material.dart';
import 'package:myapp/core/routes/app_routes.dart';
import 'package:myapp/core/widgets/confirm_delete_dialog.dart';
import 'package:myapp/core/widgets/data_table_widget.dart';
import 'package:myapp/core/widgets/sidebar_menu.dart';
import 'package:myapp/core/widgets/status_badge_widget.dart';
import 'package:myapp/features/animals/presentation/pages/animal_form_page.dart';
import 'package:myapp/features/animals/presentation/pages/animal_details_page.dart';
import 'package:myapp/features/rescues/domain/models/rescue_model.dart';
import '../../domain/models/animal_model.dart';
import '../widgets/header_widget.dart';
import '../widgets/action_bar_widget.dart';
import '../widgets/stats_widget.dart';

class AnimalsPage extends StatefulWidget {
  const AnimalsPage({super.key});

  @override
  State<AnimalsPage> createState() => _AnimalsPageState();
}

class _AnimalsPageState extends State<AnimalsPage> {
  // Lista de exemplo para demonstração
  final List<AnimalModel> animais = [
    AnimalModel(
      nome: 'Rex',
      genero: 'Macho',
      raca: 'Labrador',
      cor: 'Preto',
      status: 'Disponível',
    ),
    AnimalModel(
      nome: 'Luna',
      genero: 'Fêmea',
      raca: 'Poodle',
      cor: 'Branco',
      status: 'Adotado',
    ),
    AnimalModel(
      nome: 'Thor',
      genero: 'Macho',
      raca: 'Pastor Alemão',
      cor: 'Marrom',
      status: 'Em tratamento',
    ),
    AnimalModel(
      nome: 'Mel',
      genero: 'Fêmea',
      raca: 'Vira-lata',
      cor: 'Caramelo',
      status: 'Disponível',
    ),
  ];

  // Estado para controle de visualização
  bool _isGridView = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const SidebarMenu(
            selectedItem: "Animais",
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Cabeçalho
                  const HeaderWidget(
                    title: 'Animais',
                    subtitle: 'Gerencie os animais cadastrados no sistema',
                  ),
                  const SizedBox(height: 24),

                  // Estatísticas
                  const StatsWidget(
                    stats: [
                      {'label': 'Total de Animais', 'value': '150'},
                      {'label': 'Disponíveis', 'value': '45'},
                      {'label': 'Adotados', 'value': '85'},
                      {'label': 'Em Tratamento', 'value': '20'},
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Barra de Ações
                  ActionBarWidget(
                    onAdd: _adicionarNovoAnimal,
                    onViewChange: (isGrid) {
                      setState(() {
                        _isGridView = isGrid;
                      });
                    },
                    isGridView: _isGridView,
                    searchController: TextEditingController(),
                    onSearch: (value) {
                      // Implementar busca
                    },
                  ),
                  const SizedBox(height: 24),

                  // Lista de Animais
                  Expanded(
                    child: _isGridView ? _buildGridView() : _buildTableView(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableView() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: DataTableWidget(
        columns: const ['Nome', 'Gênero', 'Raça', 'Status'],
        rows:
            animais
                .map(
                  (animal) => {
                    'nome': animal.nome,
                    'genero': animal.genero,
                    'raca': animal.raca,
                    'status': animal.status,
                  },
                )
                .toList(),
        customCellBuilders: {
          'status':
              (value) => StatusBadgeWidget(
                status: value.toString(),
                statusColors: {
                  'Disponível': const Color(0xFF10B981), // Verde
                  'Adotado': const Color(0xFF3B82F6), // Azul
                  'Em tratamento': const Color(0xFFEAB308), // Amarelo
                },
              ),
        },
        actions: [
          DataTableAction(
            icon: Icons.visibility,
            color: Colors.blue,
            tooltip: 'Ver Detalhes',
            onPressed: (index) {
              _verDetalhesAnimal(animais[index]);
            },
          ),
          DataTableAction(
            icon: Icons.edit,
            color: Colors.blue,
            tooltip: 'Editar',
            onPressed: (index) {
              _editarAnimal(animais[index], index);
            },
          ),
          DataTableAction(
            icon: Icons.delete,
            color: Colors.red,
            tooltip: 'Excluir',
            onPressed: (index) {
              _confirmarExclusao(context, () {
                setState(() {
                  animais.removeAt(index);
                });
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.2,
      ),
      itemCount: animais.length,
      itemBuilder: (context, index) {
        final animal = animais[index];
        return _buildAnimalCard(animal, index);
      },
    );
  }

  Widget _buildAnimalCard(AnimalModel animal, int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Cabeçalho do card
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF00A3D7).withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    animal.nome,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF374151),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                StatusBadgeWidget(
                  status: animal.status,
                  statusColors: {
                    'Disponível': const Color(0xFF10B981), // Verde
                    'Adotado': const Color(0xFF3B82F6), // Azul
                    'Em tratamento': const Color(0xFFEAB308), // Amarelo
                  },
                ),
              ],
            ),
          ),

          // Conteúdo do card
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow('Gênero', animal.genero),
                  const SizedBox(height: 8),
                  _buildInfoRow('Raça', animal.raca),
                  const SizedBox(height: 8),
                  _buildInfoRow('Cor', animal.cor),
                ],
              ),
            ),
          ),

          // Ações do card
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.visibility, size: 20),
                  onPressed: () => _verDetalhesAnimal(animal),
                  color: Colors.blue,
                  tooltip: 'Ver Detalhes',
                ),
                IconButton(
                  icon: const Icon(Icons.edit, size: 20),
                  onPressed: () => _editarAnimal(animal, index),
                  color: Colors.blue,
                  tooltip: 'Editar',
                ),
                IconButton(
                  icon: const Icon(Icons.delete, size: 20),
                  onPressed:
                      () => _confirmarExclusao(context, () {
                        setState(() {
                          animais.removeAt(index);
                        });
                      }),
                  color: Colors.red,
                  tooltip: 'Excluir',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF6B7280),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 14, color: Color(0xFF374151)),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  // Método para adicionar um novo animal
  void _adicionarNovoAnimal() async {
    final result = await AppRoutes.navigateTo<AnimalModel>(
      context,
      AppRoutes.animalForm,
    );

    if (result != null) {
      setState(() {
        animais.add(result);
      });
    }
  }

  // Método para editar um animal existente
  void _editarAnimal(AnimalModel animal, int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => AnimalFormPage(
              animal: animal,
              isEditing: true,
              resgate: RescueModel(status: 'pending'),
            ),
      ),
    );

    if (result != null && result is AnimalModel) {
      setState(() {
        animais[index] = result;
      });
    }
  }

  // Método para ver detalhes do animal
  void _verDetalhesAnimal(AnimalModel animal) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AnimalDetailsPage(animal: animal),
      ),
    );
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
