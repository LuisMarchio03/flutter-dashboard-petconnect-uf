import 'package:flutter/material.dart';
import '../../domain/models/animal_vinculado_model.dart';

class AnimalLinkForm extends StatelessWidget {
  final TextEditingController searchController;
  final List<AnimalVinculadoModel> animaisVinculados;
  final Function(String) onSearch;
  final Function() onAdicionar;
  final Function(AnimalVinculadoModel) onApadrinhar;
  final Function(AnimalVinculadoModel) onAdotar;
  final Function(AnimalVinculadoModel) onRemover;

  const AnimalLinkForm({
    Key? key,
    required this.searchController,
    required this.animaisVinculados,
    required this.onSearch,
    required this.onAdicionar,
    required this.onApadrinhar,
    required this.onAdotar,
    required this.onRemover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Vincular Animal',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF374151),
          ),
        ),
        const SizedBox(height: 24),
        
        // Barra de pesquisa e botão adicionar
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: searchController,
                onChanged: onSearch,
                decoration: InputDecoration(
                  hintText: 'Buscar Animal',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: onAdicionar,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00A3D7),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
        const SizedBox(height: 16),
        
        // Lista de animais
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: animaisVinculados.length,
          itemBuilder: (context, index) {
            final animal = animaisVinculados[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                children: [
                  // Imagem do animal
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(animal.imageUrl),
                  ),
                  const SizedBox(width: 16),
                  
                  // Nome e tipo do animal
                  Expanded(
                    child: Text(
                      '${animal.nome} - ${animal.tipo}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  
                  // Botões de ação
                  ElevatedButton(
                    onPressed: () => onApadrinhar(animal),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black87,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                    child: const Text('Apadrinhar'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () => onAdotar(animal),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black87,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                    child: const Text('Adotar'),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () => onRemover(animal),
                    icon: const Icon(Icons.delete, color: Colors.red),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}