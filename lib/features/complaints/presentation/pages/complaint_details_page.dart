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
                                                            // ... existing code ...
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
                                                      
                                                      // Botão para marcar como atendido (apenas mostrar se estiver em andamento)
                                                      if (complaint.status == 'Em andamento') ...[
                                                        ElevatedButton.icon(
                                                          onPressed: () {
                                                            // ... existing code ...
                                                          },
                                                          icon: const Icon(Icons.task_alt),
                                                          label: const Text('Finalizar Atendimento'),
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
                                                        const SizedBox(height: 16),
                                                      ],
                                                      
                                                      // Botão para cancelar denúncia (mostrar para pendente e em andamento)
                                                      if (complaint.status == 'Pendente' ||
                                                          complaint.status == 'Em andamento')
                                                        ElevatedButton.icon(
                                                          onPressed: () {
                                                            // ... existing code ...
                                                          },
                                                          icon: const Icon(Icons.cancel_outlined),
                                                          label: const Text('Cancelar Denúncia'),
                                                          style: ElevatedButton.styleFrom(
                                                            backgroundColor: Colors.red.shade50,
                                                            foregroundColor: Colors.red,
                                                            padding: const EdgeInsets.symmetric(
                                                              vertical: 16,
                                                            ),
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(8),
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
                          
                          // Exibir imagem e botões em layout mobile
                          if (MediaQuery.of(context).size.width <= 768) ...[
                            const SizedBox(height: 24),
                            
                            // Exibir imagem se disponível
                            if (complaint.imagemUrl != null &&
                                complaint.imagemUrl!.isNotEmpty) ...[
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
                            ],
                            
                            // Card de ações para mobile
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
                                              // ... existing code ...
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
                                        
                                        // Botão para marcar como atendido (apenas mostrar se estiver em andamento)
                                        if (complaint.status == 'Em andamento') ...[
                                          ElevatedButton.icon(
                                            onPressed: () {
                                              // ... existing code ...
                                            },
                                            icon: const Icon(Icons.task_alt),
                                            label: const Text('Finalizar Atendimento'),
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
                                          const SizedBox(height: 16),
                                        ],
                                        
                                        // Botão para cancelar denúncia (mostrar para pendente e em andamento)
                                        if (complaint.status == 'Pendente' ||
                                            complaint.status == 'Em andamento')
                                          ElevatedButton.icon(
                                            onPressed: () {
                                              // ... existing code ...
                                            },
                                            icon: const Icon(Icons.cancel_outlined),
                                            label: const Text('Cancelar Denúncia'),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red.shade50,
                                              foregroundColor: Colors.red,
                                              padding: const EdgeInsets.symmetric(
                                                vertical: 16,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(8),
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

  Widget _buildDetailItem(
    IconData icon,
    String label,
    String value, {
    bool isMultiline = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.textSecondary, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
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
