import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/models/complaint_model.dart';

class ComplaintDetailsPage extends StatelessWidget {
  final ComplaintModel complaint;

  const ComplaintDetailsPage({Key? key, required this.complaint})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da Denúncia'),
        backgroundColor: const Color(0xFF00A3D7),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cabeçalho com status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Informações da Denúncia',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusBackgroundColor(complaint.status),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    complaint.status,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: _getStatusTextColor(complaint.status),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Detalhes da denúncia
            _buildDetailItem(
              Icons.location_on_outlined,
              'Endereço',
              complaint.endereco,
            ),
            const SizedBox(height: 16),
            _buildDetailItem(
              Icons.calendar_today_outlined,
              'Data do Reporte',
              complaint.dataReporte,
            ),
            const SizedBox(height: 16),
            _buildDetailItem(
              Icons.description_outlined,
              'Descrição',
              complaint.descricao,
              isMultiline: true,
            ),

            // Exibir imagem se disponível
            if (complaint.imagemUrl != null &&
                complaint.imagemUrl!.isNotEmpty) ...[
              const SizedBox(height: 24),
              const Text(
                'Imagem Anexada',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    complaint.imagemUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.broken_image,
                              size: 48,
                              color: Colors.grey.shade400,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Não foi possível carregar a imagem',
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value:
                              loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                          color: const Color(0xFF00A3D7),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],

            const Spacer(),

            // Botões de ação
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Botão de atender denúncia (apenas mostrar se estiver pendente)
                if (complaint.status == 'Pendente') ...[
                  OutlinedButton(
                    onPressed: () {
                      // Mostrar modal de confirmação antes de atender
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Confirmar Atendimento'),
                            content: const Text(
                              'Tem certeza que deseja atender esta denúncia?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(
                                    context,
                                  ).pop(); // Fecha o diálogo
                                },
                                child: const Text('Cancelar'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(
                                    context,
                                  ).pop(); // Fecha o diálogo

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Status atualizado para "Em andamento"',
                                      ),
                                      duration: Duration(seconds: 2),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                      ),
                                      backgroundColor: Color.fromARGB(
                                        255,
                                        11,
                                        139,
                                        88,
                                      ),
                                    ),
                                  );

                                  // Retorna para a tela anterior com o status atualizado
                                  Navigator.of(context).pop(
                                    ComplaintModel(
                                      endereco: complaint.endereco,
                                      dataReporte: complaint.dataReporte,
                                      descricao: complaint.descricao,
                                      status: 'Em andamento',
                                      imagemUrl: complaint.imagemUrl,
                                    ),
                                  );
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: const Color(0xFF00A3D7),
                                ),
                                child: const Text('Confirmar'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Color(0xFF00A3D7),
                      side: const BorderSide(color: Color(0xFF00A3D7)),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Atender Denúncia'),
                  ),
                  const SizedBox(width: 16),
                ],

                // Botão para marcar como atendido (apenas mostrar se estiver em andamento)
                if (complaint.status == 'Em andamento') ...[
                  ElevatedButton(
                    onPressed: () {
                      // Mostrar modal de confirmação antes de finalizar
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Confirmar Finalização'),
                            content: const Text(
                              'Tem certeza que deseja marcar esta denúncia como atendida?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(
                                    context,
                                  ).pop(); // Fecha o diálogo
                                },
                                child: const Text('Cancelar'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(
                                    context,
                                  ).pop(); // Fecha o diálogo

                                  // Retorna para a tela anterior com o status atualizado
                                  Navigator.of(context).pop(
                                    ComplaintModel(
                                      endereco: complaint.endereco,
                                      dataReporte: complaint.dataReporte,
                                      descricao: complaint.descricao,
                                      status: 'Atendido',
                                      imagemUrl: complaint.imagemUrl,
                                    ),
                                  );

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Denúncia finalizada com sucesso!',
                                      ),
                                      duration: Duration(seconds: 2),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                      ),
                                      backgroundColor: Color.fromARGB(
                                        255,
                                        11,
                                        139,
                                        88,
                                      ),
                                    ),
                                  );

                                  // Navegar para a tela de criar um resgate após um pequeno delay
                                  Navigator.of(context).pushNamed(
                                    '/resgates/formulario',
                                    arguments: {
                                      'endereco': complaint.endereco,
                                      'descricao': complaint.descricao,
                                      'imagemUrl': complaint.imagemUrl,
                                      'origemDenuncia': true,
                                    },
                                  );
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: const Color(0xFF00A3D7),
                                ),
                                child: const Text('Confirmar'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00A3D7),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Finalizar Atendimento'),
                  ),
                  const SizedBox(width: 16),
                ],

                // Botão para cancelar denúncia (mostrar para pendente e em andamento)
                if (complaint.status == 'Pendente' ||
                    complaint.status == 'Em andamento') ...[
                  ElevatedButton(
                    onPressed: () {
                      // Mostrar modal de confirmação antes de cancelar
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Confirmar Cancelamento'),
                            content: const Text(
                              'Tem certeza que deseja cancelar esta denúncia?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(
                                    context,
                                  ).pop(); // Fecha o diálogo
                                },
                                child: const Text('Voltar'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(
                                    context,
                                  ).pop(); // Fecha o diálogo

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Denúncia cancelada com sucesso!',
                                      ),
                                      duration: Duration(seconds: 2),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                      ),
                                      backgroundColor: Color.fromARGB(
                                        255,
                                        11,
                                        139,
                                        88,
                                      ),
                                    ),
                                  );

                                  // Retorna para a tela anterior com o status atualizado
                                  Navigator.of(context).pop(
                                    ComplaintModel(
                                      endereco: complaint.endereco,
                                      dataReporte: complaint.dataReporte,
                                      descricao: complaint.descricao,
                                      status: 'Cancelado',
                                      imagemUrl: complaint.imagemUrl,
                                    ),
                                  );
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.red,
                                ),
                                child: const Text('Cancelar Denúncia'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Cancelar Denúncia'),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(
    IconData icon,
    String label,
    String value, {
    bool isMultiline = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment:
              isMultiline
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.textSecondary, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Método para obter a cor de fundo com base no status
  Color _getStatusBackgroundColor(String status) {
    switch (status) {
      case 'Pendente':
        return const Color(0xFFFEF3C7); // Amarelo claro
      case 'Em andamento':
        return const Color(0xFFDCFCE7); // Verde claro
      case 'Atendido':
        return const Color(0xFFD1FAE5); // Verde mais claro
      case 'Cancelado':
        return const Color(0xFFFEE2E2); // Vermelho claro
      default:
        return const Color(0xFFE5E7EB); // Cinza claro
    }
  }

  // Método para obter a cor do texto com base no status
  Color _getStatusTextColor(String status) {
    switch (status) {
      case 'Pendente':
        return const Color(0xFFD97706); // Laranja
      case 'Em andamento':
        return const Color(0xFF059669); // Verde
      case 'Atendido':
        return const Color(0xFF047857); // Verde escuro
      case 'Cancelado':
        return const Color(0xFFDC2626); // Vermelho
      default:
        return const Color(0xFF6B7280); // Cinza
    }
  }
}
