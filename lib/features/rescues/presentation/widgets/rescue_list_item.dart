import 'package:flutter/material.dart';
import '../../domain/models/rescue_model.dart';

class RescueListItem extends StatelessWidget {
  final RescueModel rescue;
  final VoidCallback onDetails;
  final VoidCallback onUpdateStatus;
  final VoidCallback onEdit;

  const RescueListItem({
    Key? key,
    required this.rescue,
    required this.onDetails,
    required this.onUpdateStatus,
    required this.onEdit,
  }) : super(key: key);

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
          // Cabeçalho com enviado por e status
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Enviado por
              Text(
                'Enviado - ${rescue.data} às ${rescue.hora}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
              const Spacer(),
              // Status
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: rescue.status == 'Pendente' 
                      ? const Color(0xFFFEF3C7) 
                      : const Color(0xFFD1FAE5),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  rescue.status,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: rescue.status == 'Pendente' 
                        ? const Color(0xFFD97706) 
                        : const Color(0xFF059669),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Endereço
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.location_on_outlined,
                color: Color(0xFF6B7280),
                size: 16,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  rescue.endereco,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF333333),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Localização
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 24),
              Text(
                rescue.endereco,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF6B7280),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Telefone
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.phone_outlined,
                color: Color(0xFF6B7280),
                size: 16,
              ),              
            ],
          ),
          const SizedBox(height: 8),
          // Espécie de animal
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.pets_outlined,
                color: Color(0xFF6B7280),
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                'Espécie de animal: ${rescue.especie}',
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
            rescue.descricao,
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
                child: const Text('Visualizar detalhes'),
              ),
              const SizedBox(width: 8),
              OutlinedButton(
                onPressed: onEdit,
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF059669),
                  side: const BorderSide(color: Color(0xFF059669)),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: const Text('Editar'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: onUpdateStatus,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00A3D7),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: const Text('Atualizar status'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}