import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class FilterWidget extends StatelessWidget {
  final TextEditingController searchController;
  final Function(String) onSearch;
  final List<FilterOption> filters;
  final Map<String, dynamic> selectedFilters;
  final Function(String, dynamic) onFilterChanged;
  final Widget? trailing;
  final VoidCallback? onAdd;
  final String? addButtonLabel;
  final bool showViewToggle;
  final bool isGridView;
  final Function(bool)? onViewChange;

  const FilterWidget({
    Key? key,
    required this.searchController,
    required this.onSearch,
    required this.filters,
    required this.selectedFilters,
    required this.onFilterChanged,
    this.trailing,
    this.onAdd,
    this.addButtonLabel,
    this.showViewToggle = false,
    this.isGridView = false,
    this.onViewChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Campo de busca
              Expanded(
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9FAFB),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: TextField(
                    controller: searchController,
                    onChanged: onSearch,
                    decoration: InputDecoration(
                      hintText: 'Buscar...',
                      hintStyle: const TextStyle(
                        color: Color(0xFF9CA3AF),
                        fontSize: 14,
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Color(0xFF9CA3AF),
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
              ),
              if (trailing != null) ...[const SizedBox(width: 16), trailing!],
              const SizedBox(width: 16),
              // Botão de adicionar
              if (onAdd != null)
                ElevatedButton.icon(
                  onPressed: onAdd,
                  icon: const Icon(Icons.add),
                  label: Text(addButtonLabel ?? 'Adicionar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00A3D7),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
              const SizedBox(width: 16),
              // Opções de visualização
              if (showViewToggle)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Row(
                    children: [
                      _buildViewOption(
                        icon: Icons.list,
                        isSelected: !isGridView,
                        onTap: () => onViewChange?.call(false),
                      ),
                      _buildViewOption(
                        icon: Icons.grid_view,
                        isSelected: isGridView,
                        onTap: () => onViewChange?.call(true),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          if (filters.isNotEmpty) ...[
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children:
                  filters.map((filter) {
                    return _buildFilterDropdown(filter);
                  }).toList(),
            ),
          ],
        ],
      ),
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

  Widget _buildFilterDropdown(FilterOption filter) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: DropdownButtonFormField<dynamic>(
        value: selectedFilters[filter.key],
        decoration: InputDecoration(
          labelText: filter.label,
          labelStyle: const TextStyle(color: Color(0xFF6B7280), fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        items:
            filter.options.map((option) {
              return DropdownMenuItem(
                value: option.value,
                child: Text(
                  option.label,
                  style: const TextStyle(
                    color: Color(0xFF374151),
                    fontSize: 14,
                  ),
                ),
              );
            }).toList(),
        onChanged: (value) => onFilterChanged(filter.key, value),
      ),
    );
  }
}

class FilterOption {
  final String key;
  final String label;
  final List<FilterOptionValue> options;

  const FilterOption({
    required this.key,
    required this.label,
    required this.options,
  });
}

class FilterOptionValue {
  final String label;
  final dynamic value;

  const FilterOptionValue({required this.label, required this.value});
}
