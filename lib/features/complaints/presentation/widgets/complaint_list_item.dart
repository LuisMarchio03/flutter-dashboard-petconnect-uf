import 'package:flutter/material.dart';
import '../../domain/models/complaint_model.dart';

class ComplaintListItem extends StatelessWidget {
  final ComplaintModel complaint;
  final VoidCallback onDetails;
  final VoidCallback onAttend;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ComplaintListItem({
    super.key,
    required this.complaint,
    required this.onDetails,
    required this.onAttend,
    required this.onDelete,
    required this.onEdit,
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
                  color: _getStatusBackgroundColor(complaint.status),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  complaint.status,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: _getStatusTextColor(complaint.status),
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
              // ElevatedButton(
              //   onPressed: () {
              //     // Mostrar modal de confirmação antes de atender
              //     showDialog(
              //       context: context,
              //       builder: (BuildContext context) {
              //         return AlertDialog(
              //           title: const Text('Confirmar Atendimento'),
              //           content: const Text('Tem certeza que deseja atender esta denúncia?'),
              //           actions: [
              //             TextButton(
              //               onPressed: () {
              //                 Navigator.of(context).pop(); // Fecha o diálogo
              //               },
              //               child: const Text('Cancelar'),
              //             ),
              //             TextButton(
              //               onPressed: () {
              //                 Navigator.of(context).pop(); // Fecha o diálogo
              //                 onAttend(); // Executa a ação de atendimento
              //               },
              //               style: TextButton.styleFrom(
              //                 foregroundColor: const Color(0xFF00A3D7),
              //               ),
              //               child: const Text('Confirmar'),
              //             ),
              //           ],
              //         );
              //       },
              //     );
              //   },
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: const Color(0xFF00A3D7),
              //     foregroundColor: Colors.white,
              //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(4),
              //     ),
              //   ),
              //   child: const Text('Atender'),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}

// Método para obter a cor de fundo do status
Color _getStatusBackgroundColor(String status) {
  switch (status) {
    case 'Pendente':
      return const Color(0xFFFEF3C7); // Amarelo claro
    case 'Em andamento':
    case 'Em Atendimento':
      return const Color(0xFFDCFCE7); // Verde claro
    case 'Atendido':
      return const Color(0xFFD1FAE5); // Verde mais claro
    case 'Cancelado':
      return const Color(0xFFFEE2E2); // Vermelho claro
    default:
      return const Color(0xFFF3F4F6); // Cinza claro
  }
}

// Método para obter a cor do texto do status
Color _getStatusTextColor(String status) {
  switch (status) {
    case 'Pendente':
      return const Color(0xFFD97706); // Laranja
    case 'Em andamento':
    case 'Em Atendimento':
      return const Color(0xFF059669); // Verde
    case 'Atendido':
      return const Color(0xFF059669); // Verde
    case 'Cancelado':
      return const Color(0xFFDC2626); // Vermelho
    default:
      return const Color(0xFF6B7280); // Cinza
  }
}