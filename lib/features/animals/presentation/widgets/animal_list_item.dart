import 'package:flutter/material.dart';
import '../../domain/models/animal_model.dart';

class AnimalListItem extends StatelessWidget {
  final AnimalModel animal;
  final Function(AnimalModel) onEdit;
  final Function() onDelete;

  const AnimalListItem({
    super.key,
    required this.animal,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[300]!),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(animal.nome),
          ),
          Expanded(
            flex: 2,
            child: Text(animal.genero),
          ),
          Expanded(
            flex: 2,
            child: Text(animal.raca),
          ),
          Expanded(
            flex: 2,
            child: Text(animal.status),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, size: 20),
                  onPressed: () => onEdit(animal),
                  color: Colors.blue,
                ),
                IconButton(
                  icon: const Icon(Icons.delete, size: 20),
                  onPressed: onDelete,
                  color: Colors.red,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}