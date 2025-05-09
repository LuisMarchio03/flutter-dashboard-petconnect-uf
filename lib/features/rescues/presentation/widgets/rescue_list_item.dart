import 'package:flutter/material.dart';
import 'package:myapp/core/widgets/status_badge_widget.dart';
import 'package:myapp/features/rescues/domain/models/rescue_model.dart';

class RescueListItem extends StatelessWidget {
  final RescueModel rescue;
  final VoidCallback onDetails;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onUpdateStatus;

  const RescueListItem({
    super.key,
    required this.rescue,
    required this.onDetails,
    required this.onEdit,
    required this.onDelete,
    required this.onUpdateStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: const Color(0xFFE5E7EB), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        rescue.nomeAnimal?.isNotEmpty == true
                            ? rescue.nomeAnimal!
                            : 'Não identificado',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF374151),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        rescue.especie ?? 'Não especificado',
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                ),
                StatusBadgeWidget(
                  status: rescue.status,
                  statusColors: {
                    RescueModel.STATUS_PENDENTE: const Color(0xFFFFF4E0),
                    RescueModel.STATUS_EM_ANDAMENTO: const Color(0xFFE0F7FF),
                    RescueModel.STATUS_RESGATADO: const Color(0xFFE0F7F0),
                    RescueModel.STATUS_CANCELADO: const Color(0xFFFFE0E6),
                  },
                  textColors: {
                    RescueModel.STATUS_PENDENTE: const Color(0xFFF59E0B),
                    RescueModel.STATUS_EM_ANDAMENTO: const Color(0xFF00A3D7),
                    RescueModel.STATUS_RESGATADO: const Color(0xFF10B981),
                    RescueModel.STATUS_CANCELADO: const Color(0xFFF43F5E),
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  size: 14,
                  color: Color(0xFF6B7280),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    rescue.localizacao ?? 'Não especificado',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(
                  Icons.calendar_today,
                  size: 14,
                  color: Color(0xFF6B7280),
                ),
                const SizedBox(width: 6),
                Text(
                  rescue.dataResgate ?? 'Não especificado',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.visibility, size: 18),
                  color: const Color(0xFF6B7280),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: onDetails,
                ),
                const SizedBox(width: 16),
                IconButton(
                  icon: const Icon(Icons.edit, size: 18),
                  color: const Color(0xFF6B7280),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: onEdit,
                ),
                const SizedBox(width: 16),
                IconButton(
                  icon: const Icon(Icons.update, size: 18),
                  color: const Color(0xFF00A3D7),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: onUpdateStatus,
                ),
                const SizedBox(width: 16),
                IconButton(
                  icon: const Icon(Icons.delete, size: 18),
                  color: const Color(0xFFF43F5E),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: onDelete,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
