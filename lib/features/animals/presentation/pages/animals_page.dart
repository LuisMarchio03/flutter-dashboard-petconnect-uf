import 'package:flutter/material.dart';
import 'package:myapp/core/routes/app_routes.dart';
import 'package:myapp/core/widgets/sidebar_menu.dart';
import 'package:myapp/features/animals/presentation/pages/animal_form_page.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/models/animal_model.dart';
import '../widgets/animal_list_item.dart';
import '../widgets/search_bar_widget.dart';

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
      status: 'Disponível'
    ),
    AnimalModel(
      nome: 'Luna', 
      genero: 'Fêmea', 
      raca: 'Poodle', 
      cor: 'Branco',
      status: 'Adotado'
    ),
    AnimalModel(
      nome: 'Thor', 
      genero: 'Macho', 
      raca: 'Pastor Alemão', 
      cor: 'Marrom',
      status: 'Em tratamento'
    ),
    AnimalModel(
      nome: 'Mel', 
      genero: 'Fêmea', 
      raca: 'Vira-lata', 
      cor: 'Caramelo',
      status: 'Disponível'
    ),
  ];
  final List<AnimalModel> _animais = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Menu lateral
          const SidebarMenu(selectedItem: 'Animais'),
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
                            'Animais',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const Text(
                            'Gestão completa dos animais',
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
                  const SizedBox(height: 24),
                  // Barra de pesquisa e botão de adicionar
                  Row(
                    children: [
                      const Expanded(
                        child: SearchBarWidget(),
                      ),
                      const SizedBox(width: 16),
                      // Atualizar o botão de adicionar animal
                      ElevatedButton.icon(
                        onPressed: _adicionarNovoAnimal,
                        icon: const Icon(Icons.add, color: Colors.white),
                        label: const Text(
                          'Adicionar Animal',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00A3D7),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Tabela de animais
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
                                  flex: 2,
                                  child: _buildTableHeader('Nome'),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: _buildTableHeader('Gênero'),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: _buildTableHeader('Raça'),
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
                          // Lista de animais
                          // Na parte do ListView.builder
                          Expanded(
                            child: ListView.builder(
                              itemCount: animais.length,
                              itemBuilder: (context, index) {
                                return AnimalListItem(
                                  animal: animais[index],
                                  onEdit: (animal) => _editarAnimal(animal, index),
                                  onDelete: () {
                                    setState(() {
                                      animais.removeAt(index);
                                    });
                                  },
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
        title: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
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

  // Método para adicionar um novo animal
  void _adicionarNovoAnimal() async {
    final result = await AppRoutes.navigateTo<AnimalModel>(
      context, 
      AppRoutes.animalForm
    );
    
    if (result != null) {
      setState(() {
        _animais.add(result);
      });
    }
  }

  // Método para editar um animal existente
  void _editarAnimal(AnimalModel animal, int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AnimalFormPage(
          animal: animal,
          isEditing: true,
        ),
      ),
    );

    if (result != null && result is AnimalModel) {
      setState(() {
        animais[index] = result;
      });
    }
  }
}