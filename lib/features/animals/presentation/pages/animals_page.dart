import 'package:flutter/material.dart';
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
    AnimalModel(nome: 'Nome', genero: 'Gênero', raca: 'Raça', status: 'Status'),
    AnimalModel(nome: 'Nome', genero: 'Gênero', raca: 'Raça', status: 'Status'),
    AnimalModel(nome: 'Nome', genero: 'Gênero', raca: 'Raça', status: 'Status'),
    AnimalModel(nome: 'Nome', genero: 'Gênero', raca: 'Raça', status: 'Status'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Menu lateral
          Container(
            width: 160,
            color: const Color(0xFF00A3D7),
            child: Column(
              children: [
                const SizedBox(height: 40),
                // Logo
                Column(
                  children: [
                    Image.asset(
                      'assets/logo.png',
                      width: 60,
                      height: 60,
                    ),
                    const Text(
                      'PetConnect',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Conectando Vidas',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                // Itens do menu
                _buildMenuItem(Icons.dashboard, 'Dashboard', false),
                _buildMenuItem(Icons.announcement, 'Denúncias', false),
                _buildMenuItem(Icons.pets, 'Animais', true),
                _buildMenuItem(Icons.assignment, 'Resgates', false),
                _buildMenuItem(Icons.people, 'Usuários', false),
                const Spacer(),
                // Botões de tema
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.dark_mode, color: Colors.white),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.light_mode, color: Colors.white),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
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
                      ElevatedButton.icon(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                        icon: const Icon(Icons.add, color: Colors.white),
                        label: const Text(
                          'Adicionar Animal',
                          style: TextStyle(color: Colors.white),
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
                          Expanded(
                            child: ListView.builder(
                              itemCount: animais.length,
                              itemBuilder: (context, index) {
                                return AnimalListItem(animal: animais[index]);
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
}