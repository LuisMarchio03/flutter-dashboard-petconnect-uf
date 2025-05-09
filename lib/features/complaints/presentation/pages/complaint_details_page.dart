import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/models/complaint_model.dart';
import '../../../../core/widgets/sidebar_menu.dart';

class ComplaintDetailsPage extends StatelessWidget {
  final ComplaintModel complaint;

  const ComplaintDetailsPage({Key? key, required this.complaint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Menu lateral 
          const SidebarMenu(selectedItem: 'Denúncias'),
          
          // Conteúdo principal
          Expanded(
            child: Column(
              children: [
                // Barra superior
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () => Navigator.pop(context),
                            tooltip: 'Voltar',
                          ),
                          const SizedBox(width: 16),
                          const Text(
                            'Detalhes da Denúncia',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
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
                ),
                
                // Conteúdo com rolagem
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Breadcrumbs
                          Row(
                            children: [
                              InkWell(
                                onTap: () => Navigator.pop(context),
                                child: const Text(
                                  'Denúncias',
                                  style: TextStyle(
                                    color: Color(0xFF00A3D7),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(
                                Icons.chevron_right,
                                size: 16,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Detalhes',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          
                          // Layout em grid
                          LayoutBuilder(
                            builder: (context, constraints) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Coluna principal - informações
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Card com informações principais
                                        Card(
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            side: BorderSide(
                                              color: Colors.grey.shade200,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(24.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  'Informações da Denúncia',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.textPrimary,
                                                  ),
                                                ),
                                                const SizedBox(height: 24),
                                                _buildDetailItem(
                                                  Icons.location_on_outlined,
                                                  'Localização',
                                                  complaint.endereco,
                                                ),
                                                const Divider(height: 24),
                                                _buildDetailItem(
                                                  Icons.calendar_today_outlined,
                                                  'Data do Reporte',
                                                  complaint.dataReporte,
                                                ),
                                                const Divider(height: 24),
                                                _buildDetailItem(
                                                  Icons.person_outline,
                                                  'Responsável',
                                                  'Não especificado',
                                                ),
                                                const Divider(height: 24),
                                                _buildDetailItem(
                                                  Icons.phone_outlined,
                                                  'Contato',
                                                  'Não especificado',
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        
                                        const SizedBox(height: 24),
                                        
                                        // Seção de observações
                                        Card(
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            side: BorderSide(
                                              color: Colors.grey.shade200,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(24.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  'Observações',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.textPrimary,
                                                  ),
                                                ),
                                                const SizedBox(height: 16),
                                                Text(
                                                  complaint.descricao,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    color: AppColors.textPrimary,
                                                    height: 1.5,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  
                                  const SizedBox(width: 24),
                                  
                                  // Coluna lateral - imagem e ações
                                  if (constraints.maxWidth > 768)
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          // Exibir imagem se disponível
                                          if (complaint.imagemUrl != null &&
                                              complaint.imagemUrl!.isNotEmpty)
                                            Card(
                                              elevation: 0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(8),
                                                side: BorderSide(
                                                  color: Colors.grey.shade200,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const Padding(
                                                      padding: EdgeInsets.only(bottom: 16.0),
                                                      child: Text(
                                                        'Imagem Anexada',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.bold,
                                                          color: AppColors.textPrimary,
                                                        ),
                                                      ),
                                                    ),
                                                    ClipRRect(
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
                                                  ],
                                                ),
                                              ),
                                            ),
                                          
                                          const SizedBox(height: 24),
                                          
                                          // Card de ações
                                          Card(
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8),
                                              side: BorderSide(
                                                color: Colors.grey.shade200,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(24.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'Ações',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.bold,
                                                      color: AppColors.textPrimary,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 24),
                                                  
                                                  // Botões de ação
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                                    children: [
                                                      // Botão de atender denúncia (apenas mostrar se estiver pendente)
                                                      if (complaint.status == 'Pendente')
                                                        OutlinedButton.icon(
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
                                                                        Navigator.of(context).pop(); // Fecha o diálogo
                                                                        
                                                                        // Retorna para a tela anterior com o status atualizado
                                                                        Navigator.of(context).pop(
                                                                          ComplaintModel(
                                                                            
                                                                            descricao: complaint.descricao,
                                                                            endereco: complaint.endereco,
                                                                            dataReporte: complaint.dataReporte,
                                                                            status: 'Em Atendimento',
                                                                            imagemUrl: complaint.imagemUrl,
                                                                          ),
                                                                        );
                                                                      },
                                                                      child: const Text('Confirmar'),
                                                                    ),
                                                                    TextButton(
                                                                      onPressed: () {
                                                                        Navigator.of(context).pop(); // Fecha apenas o diálogo
                                                                      },
                                                                      child: const Text('Cancelar'),
                                                                    ),
                                                                  ],
                                                                );
                                                              },
                                                            );
                                                          },
                                                          icon: const Icon(Icons.check_circle_outline),
                                                          label: const Text('Atender Denúncia'),
                                                          style: OutlinedButton.styleFrom(
                                                            foregroundColor: const Color(0xFF00A3D7),
                                                            side: const BorderSide(color: Color(0xFF00A3D7)),
                                                            padding: const EdgeInsets.symmetric(
                                                              vertical: 16,
                                                            ),
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(8),
                                                            ),
                                                          ),
                                                        ),
                                                      
                                                      // Botão de resolver denúncia (apenas mostrar se estiver em atendimento)
                                                      if (complaint.status == 'Em Atendimento')
                                                        Padding(
                                                          padding: const EdgeInsets.only(top: 16.0),
                                                          child: ElevatedButton.icon(
                                                            onPressed: () {
                                                              // Mostrar modal de confirmação antes de resolver
                                                              showDialog(
                                                                context: context,
                                                                builder: (BuildContext context) {
                                                                  return AlertDialog(
                                                                    title: const Text('Confirmar Resolução'),
                                                                    content: const Text(
                                                                      'Tem certeza que deseja marcar esta denúncia como resolvida?',
                                                                    ),
                                                                    actions: [
                                                                      TextButton(
                                                                        onPressed: () {
                                                                          Navigator.of(context).pop(); // Fecha o diálogo
                                                                          
                                                                          // Retorna para a tela anterior com o status atualizado
                                                                          Navigator.of(context).pop(
                                                                            ComplaintModel(
                                                                              
                                                                              descricao: complaint.descricao,
                                                                              endereco: complaint.endereco,
                                                                              dataReporte: complaint.dataReporte,
                                                                              status: 'Resolvido',
                                                                              imagemUrl: complaint.imagemUrl,
                                                                            ),
                                                                          );
                                                                        },
                                                                        child: const Text('Confirmar'),
                                                                      ),
                                                                      TextButton(
                                                                        onPressed: () {
                                                                          Navigator.of(context).pop(); // Fecha apenas o diálogo
                                                                        },
                                                                        child: const Text('Cancelar'),
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                              );
                                                            },
                                                            icon: const Icon(Icons.task_alt),
                                                            label: const Text('Resolver Denúncia'),
                                                            style: ElevatedButton.styleFrom(
                                                              backgroundColor: const Color(0xFF00A3D7),
                                                              foregroundColor: Colors.white,
                                                              padding: const EdgeInsets.symmetric(
                                                                vertical: 16,
                                                              ),
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(8),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      
                                                      // Botão de reabrir denúncia (apenas mostrar se estiver resolvida)
                                                      if (complaint.status == 'Resolvido')
                                                        Padding(
                                                          padding: const EdgeInsets.only(top: 16.0),
                                                          child: OutlinedButton.icon(
                                                            onPressed: () {
                                                              // Mostrar modal de confirmação antes de reabrir
                                                              showDialog(
                                                                context: context,
                                                                builder: (BuildContext context) {
                                                                  return AlertDialog(
                                                                    title: const Text('Confirmar Reabertura'),
                                                                    content: const Text(
                                                                      'Tem certeza que deseja reabrir esta denúncia?',
                                                                    ),
                                                                    actions: [
                                                                      TextButton(
                                                                        onPressed: () {
                                                                          Navigator.of(context).pop(); // Fecha o diálogo
                                                                          
                                                                          // Retorna para a tela anterior com o status atualizado
                                                                          Navigator.of(context).pop(
                                                                            ComplaintModel(
                                                                             
                                                                              descricao: complaint.descricao,
                                                                              endereco: complaint.endereco,
                                                                              dataReporte: complaint.dataReporte,
                                                                              status: 'Em Atendimento',
                                                                              imagemUrl: complaint.imagemUrl,
                                                                            ),
                                                                          );
                                                                        },
                                                                        child: const Text('Confirmar'),
                                                                      ),
                                                                      TextButton(
                                                                        onPressed: () {
                                                                          Navigator.of(context).pop(); // Fecha apenas o diálogo
                                                                        },
                                                                        child: const Text('Cancelar'),
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                              );
                                                            },
                                                            icon: const Icon(Icons.refresh),
                                                            label: const Text('Reabrir Denúncia'),
                                                            style: OutlinedButton.styleFrom(
                                                              foregroundColor: Colors.orange,
                                                              side: const BorderSide(color: Colors.orange),
                                                              padding: const EdgeInsets.symmetric(
                                                                vertical: 16,
                                                              ),
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(8),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      
                                                      // Botão de cancelar denúncia (mostrar para pendente e em atendimento)
                                                      if (complaint.status == 'Pendente' || complaint.status == 'Em Atendimento')
                                                        Padding(
                                                          padding: const EdgeInsets.only(top: 16.0),
                                                          child: OutlinedButton.icon(
                                                            onPressed: () {
                                                              // Mostrar modal de confirmação antes de cancelar
                                                              showDialog(
                                                                context: context,
                                                                builder: (BuildContext context) {
                                                                  return AlertDialog(
                                                                    title: const Text('Confirmar Cancelamento'),
                                                                    content: const Text(
                                                                      'Tem certeza que deseja cancelar esta denúncia? Esta ação não pode ser desfeita.',
                                                                    ),
                                                                    actions: [
                                                                      TextButton(
                                                                        onPressed: () {
                                                                          Navigator.of(context).pop(); // Fecha o diálogo
                                                                          
                                                                          // Retorna para a tela anterior com o status atualizado
                                                                          Navigator.of(context).pop(
                                                                            ComplaintModel(
                                                                             
                                                                              descricao: complaint.descricao,
                                                                              endereco: complaint.endereco,
                                                                              dataReporte: complaint.dataReporte,
                                                                              status: 'Cancelado',
                                                                              imagemUrl: complaint.imagemUrl,
                                                                            ),
                                                                          );
                                                                        },
                                                                        child: const Text('Confirmar'),
                                                                      ),
                                                                      TextButton(
                                                                        onPressed: () {
                                                                          Navigator.of(context).pop(); // Fecha apenas o diálogo
                                                                        },
                                                                        child: const Text('Cancelar'),
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                              );
                                                            },
                                                            icon: const Icon(Icons.cancel_outlined),
                                                            label: const Text('Cancelar Denúncia'),
                                                            style: OutlinedButton.styleFrom(
                                                              foregroundColor: Colors.red,
                                                              side: const BorderSide(color: Colors.red),
                                                              padding: const EdgeInsets.symmetric(
                                                                vertical: 16,
                                                              ),
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(8),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Método auxiliar para construir itens de detalhes
  Widget _buildDetailItem(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20,
          color: Colors.grey.shade600,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Método para obter a cor de fundo com base no status
  Color _getStatusBackgroundColor(String status) {
    switch (status) {
      case 'Pendente':
        return const Color(0xFFFFF8E6);
      case 'Em Atendimento':
        return const Color(0xFFE6F4FF);
      case 'Resolvido':
        return const Color(0xFFE6FFF0);
      case 'Cancelado':
        return const Color(0xFFFFE6E6);
      default:
        return Colors.grey.shade100;
    }
  }

  // Método para obter a cor do texto com base no status
  Color _getStatusTextColor(String status) {
    switch (status) {
      case 'Pendente':
        return const Color(0xFFE6A700);
      case 'Em Atendimento':
        return const Color(0xFF0078D4);
      case 'Resolvido':
        return const Color(0xFF00A36C);
      case 'Cancelado':
        return const Color(0xFFD42A00);
      default:
        return Colors.grey.shade700;
    }
  }
}