import 'package:flutter/material.dart';
import '../../domain/models/complaint_model.dart';

class ComplaintListItem extends StatelessWidget {
  final ComplaintModel complaint;
  final VoidCallback onDetails;
  final VoidCallback onAttend;

  const ComplaintListItem({
    super.key,
    required this.complaint,
    required this.onDetails,
    required this.onAttend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFEEEEEE), width: 1),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ícone de localização
              const Icon(
                Icons.location_on_outlined,
                color: Color(0xFF6B7280),
                size: 16,
              ),
              const SizedBox(width: 8),
              // Endereço
              Expanded(
                child: Text(
                  complaint.endereco,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF333333),
                  ),
                ),
              ),
              // Status
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: complaint.status == 'Pendente' 
                      ? const Color(0xFFFEF3C7) 
                      : const Color(0xFFD1FAE5),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  complaint.status,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: complaint.status == 'Pendente' 
                        ? const Color(0xFFD97706) 
                        : const Color(0xFF059669),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ícone de calendário
              const Icon(
                Icons.calendar_today_outlined,
                color: Color(0xFF6B7280),
                size: 16,
              ),
              const SizedBox(width: 8),
              // Data do reporte
              Text(
                'Reportado em ${complaint.dataReporte}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF6B7280),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Descrição
          Text(
            complaint.descricao,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 12),
          // Botões
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(
                onPressed: onDetails,
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF00A3D7),
                  side: const BorderSide(color: Color(0xFF00A3D7)),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: const Text('Detalhes'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: onAttend,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00A3D7),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: const Text('Atender'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}