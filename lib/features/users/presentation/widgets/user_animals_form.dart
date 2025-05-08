import 'package:flutter/material.dart';
import '../../domain/models/user_form_model.dart';

class UserAnimalsForm extends StatefulWidget {
  final List<AnimalVinculado> animaisVinculados;
  final Function(List<AnimalVinculado>) onAnimaisChanged;

  const UserAnimalsForm({
    Key? key,
    required this.animaisVinculados,
    required this.onAnimaisChanged, required void Function(AnimalVinculado animal) onAnimalAdded, required void Function(int index) onAnimalRemoved,
  }) : super(key: key);

  @override
  State<UserAnimalsForm> createState() => _UserAnimalsFormState();
}

class _UserAnimalsFormState extends State<UserAnimalsForm> {
  final TextEditingController _searchController = TextEditingController();
  
  // Lista de exemplo de animais disponíveis
  final List<AnimalVinculado> _animaisDisponiveis = [
    AnimalVinculado(id: '1', nome: 'Rex', tipo: 'Cachorro'),
    AnimalVinculado(id: '2', nome: 'Luna', tipo: 'Gato'),
    AnimalVinculado(id: '3', nome: 'Bob', tipo: 'Cachorro'),
    AnimalVinculado(id: '4', nome: 'Mia', tipo: 'Gato'),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _adicionarAnimal(AnimalVinculado animal) {
    if (!widget.animaisVinculados.any((a) => a.id == animal.id)) {
      List<AnimalVinculado> updatedAnimais = List.from(widget.animaisVinculados);
      updatedAnimais.add(animal);
      widget.onAnimaisChanged(updatedAnimais);
    }
  }

  void _removerAnimal(String id) {
    List<AnimalVinculado> updatedAnimais = List.from(widget.animaisVinculados);
    updatedAnimais.removeWhere((animal) => animal.id == id);
    widget.onAnimaisChanged(updatedAnimais);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Vincular Animal',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 24),
          
          // Buscar animal
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Buscar Animal',
                    filled: true,
                    fillColor: const Color(0xFFF9FAFB),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    prefixIcon: const Icon(Icons.search, color: Color(0xFF9CA3AF)),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  // Simulação de adição do primeiro animal disponível
                  if (_animaisDisponiveis.isNotEmpty) {
                    _adicionarAnimal(_animaisDisponiveis.first);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00A3D7),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Adicionar'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Lista de animais vinculados
          const Text(
            'Animais Vinculados',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF374151),
            ),
          ),
          const SizedBox(height: 12),
          
          // Lista de animais
          if (widget.animaisVinculados.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Text(
                  'Nenhum animal vinculado',
                  style: TextStyle(
                    color: Color(0xFF6B7280),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.animaisVinculados.length,
              itemBuilder: (context, index) {
                final animal = widget.animaisVinculados[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9FAFB),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: const Color(0xFF00A3D7).withOpacity(0.1),
                        child: const Icon(Icons.pets, color: Color(0xFF00A3D7)),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${animal.nome} - ${animal.tipo}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF333333),
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: () => _removerAnimal(animal.id),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}