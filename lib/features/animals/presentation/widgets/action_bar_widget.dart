import 'package:flutter/material.dart';

class ActionBarWidget extends StatelessWidget {
  final VoidCallback onAdd;
  final Function(bool) onViewChange;
  final bool isGridView;
  final TextEditingController searchController;
  final Function(String) onSearch;

  const ActionBarWidget({
    super.key,
    required this.onAdd,
    required this.onViewChange,
    required this.isGridView,
    required this.searchController,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Campo de busca
        Expanded(
          child: Container(
            height: 40,
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
            child: TextField(
              controller: searchController,
              onChanged: onSearch,
              decoration: InputDecoration(
                hintText: 'Buscar animais...',
                prefixIcon: const Icon(Icons.search, color: Color(0xFF6B7280)),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),

        // Botão de adicionar
        ElevatedButton.icon(
          onPressed: onAdd,
          icon: const Icon(Icons.add),
          label: const Text('Adicionar Animal'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF00A3D7),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
        const SizedBox(width: 16),

        // Opções de visualização
        Container(
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
          child: Row(
            children: [
              _buildViewOption(
                icon: Icons.list,
                isSelected: !isGridView,
                onTap: () => onViewChange(false),
              ),
              _buildViewOption(
                icon: Icons.grid_view,
                isSelected: isGridView,
                onTap: () => onViewChange(true),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildViewOption({
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? const Color(0xFF00A3D7).withOpacity(0.1)
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Icon(
          icon,
          color: isSelected ? const Color(0xFF00A3D7) : const Color(0xFF6B7280),
          size: 20,
        ),
      ),
    );
  }
}
