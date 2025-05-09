import 'package:flutter/material.dart';

class DataTableWidget extends StatelessWidget {
  final List<String> columns;
  final List<Map<String, dynamic>> rows;
  final List<DataTableAction> actions;
  final Function(int)? onRowTap;
  final bool showDivider;
  final bool isLoading;
  final String emptyMessage;
  final Map<String, Widget Function(dynamic)> customCellBuilders;

  const DataTableWidget({
    Key? key,
    required this.columns,
    required this.rows,
    this.actions = const [],
    this.onRowTap,
    this.showDivider = true,
    this.isLoading = false,
    this.emptyMessage = 'Nenhum dado encontrado',
    this.customCellBuilders = const {},
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (rows.isEmpty) {
      return Center(
        child: Text(
          emptyMessage,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF6B7280),
          ),
        ),
      );
    }

    return Container(
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
        children: [
          // Cabeçalho da tabela
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              border: const Border(
                bottom: BorderSide(color: Color(0xFFE5E7EB), width: 1),
              ),
            ),
            child: Row(
              children: [
                ...columns.map((column) {
                  return Expanded(
                    flex: column == 'Ações' ? 1 : 2,
                    child: Text(
                      column,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Color(0xFF374151),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
          // Linhas da tabela
          ...rows.asMap().entries.map((entry) {
            final index = entry.key;
            final row = entry.value;
            
            return InkWell(
              onTap: onRowTap != null ? () => onRowTap!(index) : null,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  border: showDivider ? const Border(
                    bottom: BorderSide(color: Color(0xFFE5E7EB), width: 1),
                  ) : null,
                  color: index % 2 == 0 ? Colors.white : const Color(0xFFF9FAFB),
                ),
                child: Row(
                  children: [
                    ...columns.asMap().entries.map((columnEntry) {
                      final column = columnEntry.value;
                      
                      if (column == 'Ações') {
                        return Expanded(
                          flex: 1,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: actions.map((action) {
                                return IconButton(
                                  icon: Icon(
                                    action.icon,
                                    size: 20,
                                    color: action.color,
                                  ),
                                  onPressed: () => action.onPressed(index),
                                  tooltip: action.tooltip,
                                  constraints: const BoxConstraints(
                                    minWidth: 36,
                                    minHeight: 36,
                                  ),
                                  padding: const EdgeInsets.all(8),
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      }
                      
                      final key = column.toLowerCase().replaceAll(' ', '_');
                      final value = row[key] ?? '';
                      
                      return Expanded(
                        flex: 2,
                        child: customCellBuilders.containsKey(key)
                            ? customCellBuilders[key]!(value)
                            : Text(
                                value.toString(),
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF374151),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}

class DataTableAction {
  final IconData icon;
  final Color color;
  final String tooltip;
  final Function(int) onPressed;

  const DataTableAction({
    required this.icon,
    required this.color,
    required this.tooltip,
    required this.onPressed,
  });
}