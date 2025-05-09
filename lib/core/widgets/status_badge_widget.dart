import 'package:flutter/material.dart';

class StatusBadgeWidget extends StatelessWidget {
  final String status;
  final Map<String, Color> statusColors;
  final Map<String, Color> textColors;

  const StatusBadgeWidget({
    Key? key,
    required this.status,
    this.statusColors = const {},
    this.textColors = const {},
  }) : super(key: key);

  Color _getStatusColor() {
    if (statusColors.containsKey(status)) {
      return statusColors[status]!;
    }

    // Cores padrão baseadas no status
    switch (status.toLowerCase()) {
      case 'disponível':
        return const Color(0xFF10B981); // Verde
      case 'adotado':
        return const Color(0xFF3B82F6); // Azul
      case 'em tratamento':
        return const Color(0xFFEAB308); // Amarelo
      case 'pendente':
        return const Color(0xFFEAB308); // Amarelo
      case 'administrador':
        return const Color(0xFFEF4444); // Vermelho
      case 'veterinário':
        return const Color(0xFF3B82F6); // Azul
      case 'cuidador':
        return const Color(0xFF10B981); // Verde
      case 'voluntário':
        return const Color(0xFF8B5CF6); // Roxo
      default:
        return const Color(0xFF6B7280); // Cinza
    }
  }

  Color _getTextColor() {
    if (textColors.containsKey(status)) {
      return textColors[status]!;
    }
    
    // Por padrão, texto branco para todos os status
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getStatusColor(),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: _getTextColor(),
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}