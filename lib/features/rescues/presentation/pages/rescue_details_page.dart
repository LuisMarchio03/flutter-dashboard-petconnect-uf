import 'package:flutter/material.dart';
import 'package:myapp/core/widgets/sidebar_menu.dart';
import 'package:myapp/features/rescues/domain/models/rescue_model.dart';
import 'package:myapp/features/animals/presentation/pages/animal_form_page.dart';
import 'package:myapp/features/rescues/presentation/pages/rescue_update_page.dart';

class RescueDetailsPage extends StatelessWidget {
  final RescueModel rescue;

  const RescueDetailsPage({Key? key, required this.rescue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Menu lateral
          const SidebarMenu(selectedItem: 'Resgates'),
          // Conteúdo principal
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Cabeçalho
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Detalhes do Resgate',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF333333),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Resgate #${rescue.id}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF6B7280),
                              ),
                            ),
                          ],
                        ),
                        // Botão de voltar
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: const Color(0xFF6B7280),
                            side: const BorderSide(color: Color(0xFFE5E7EB)),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                          icon: const Icon(Icons.arrow_back),
                          label: const Text('Voltar'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // Status do resgate
                    Row(
                      children: [
                        const Text(
                          'Status: ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF374151),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: RescueModel.getStatusColor(rescue.status),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            rescue.status,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const Spacer(),

                        // Botões de ação baseados no status
                        Row(
                          children: [
                            // Botão para atualizar status
                            if (rescue.status != RescueModel.STATUS_RESGATADO &&
                                rescue.status != RescueModel.STATUS_CANCELADO)
                              OutlinedButton.icon(
                                onPressed: () {
                                  _atualizarResgate(context);
                                },
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: const Color(0xFF00A3D7),
                                  side: const BorderSide(
                                    color: Color(0xFF00A3D7),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                ),
                                icon: const Icon(Icons.edit),
                                label: const Text('Atualizar Status'),
                              ),

                            const SizedBox(width: 12),

                            // Botão para cadastrar animal se o status for "Resgatado"
                            if (rescue.status == RescueModel.STATUS_RESGATADO)
                              ElevatedButton.icon(
                                onPressed: () {
                                  _cadastrarAnimal(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF00A3D7),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.pets,
                                  color: Colors.white,
                                ),
                                label: const Text(
                                  'Cadastrar Animal',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Informações do resgate
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Informações do Animal',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF333333),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Dados do animal
                          _buildInfoRow(
                            'Nome do Animal',
                            rescue.nomeAnimal ?? 'Não identificado',
                          ),
                          _buildInfoRow(
                            'Espécie',
                            rescue.especie ?? 'Não especificado',
                          ),
                          _buildInfoRow(
                            'Idade',
                            rescue.idade ?? 'Não especificada',
                          ),
                          _buildInfoRow(
                            'Sexo',
                            rescue.sexo ?? 'Não especificado',
                          ),
                          _buildInfoRow(
                            'Condição',
                            rescue.condicaoAnimal ?? 'Não especificada',
                          ),

                          const SizedBox(height: 24),
                          const Text(
                            'Informações do Resgate',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF333333),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Dados do resgate
                          _buildInfoRow(
                            'Localização',
                            rescue.localizacao ?? 'Não especificada',
                          ),
                          _buildInfoRow(
                            'Data do Resgate',
                            rescue.dataResgate ?? 'Não especificada',
                          ),
                          _buildInfoRow(
                            'Responsável',
                            rescue.responsavel ?? 'Não especificado',
                          ),
                          _buildInfoRow(
                            'Contato',
                            rescue.contato ?? 'Não especificado',
                          ),

                          // Origem da denúncia
                          if (rescue.origemDenuncia == true)
                            _buildInfoRow(
                              'Origem',
                              'Denúncia',
                              isHighlighted: true,
                            ),

                          // Observações
                          if (rescue.observacoes != null &&
                              rescue.observacoes!.isNotEmpty) ...[
                            const SizedBox(height: 16),
                            const Text(
                              'Observações',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF374151),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF9FAFB),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                rescue.observacoes!,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF4B5563),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),

                    // Imagem do animal (se disponível)
                    if (rescue.imagemUrl != null &&
                        rescue.imagemUrl!.isNotEmpty) ...[
                      const SizedBox(height: 24),
                      const Text(
                        'Imagem do Animal',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF333333),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        height: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            rescue.imagemUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: const Color(0xFFF3F4F6),
                                child: const Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.broken_image,
                                        size: 48,
                                        color: Color(0xFFD1D5DB),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Não foi possível carregar a imagem',
                                        style: TextStyle(
                                          color: Color(0xFF6B7280),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],

                    const SizedBox(height: 32),

                    // Histórico de atualizações (mockup)
                    const Text(
                      'Histórico de Atualizações',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildTimelineItem(
                      'Resgate registrado',
                      'Status: ${RescueModel.STATUS_PENDENTE}',
                      rescue.dataResgate ?? 'Data não especificada',
                      isFirst: true,
                    ),
                    if (rescue.status != RescueModel.STATUS_PENDENTE)
                      _buildTimelineItem(
                        'Status atualizado',
                        'Status: ${rescue.status}',
                        'Atualizado recentemente',
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Método para construir uma linha de informação
  Widget _buildInfoRow(
    String label,
    String value, {
    bool isHighlighted = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF6B7280),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isHighlighted ? FontWeight.w600 : FontWeight.normal,
                color:
                    isHighlighted
                        ? const Color(0xFF00A3D7)
                        : const Color(0xFF111827),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Método para construir um item da linha do tempo
  Widget _buildTimelineItem(
    String title,
    String subtitle,
    String date, {
    bool isFirst = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: const Color(0xFF00A3D7),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
            if (!isFirst)
              Container(width: 2, height: 50, color: const Color(0xFFE5E7EB)),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF111827),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
              ),
              const SizedBox(height: 4),
              Text(
                date,
                style: const TextStyle(fontSize: 12, color: Color(0xFF9CA3AF)),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }

  // Método para navegar para a tela de cadastro de animal
  void _cadastrarAnimal(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AnimalFormPage(resgate: rescue)),
    );
  }

  // Método para navegar para a tela de atualização de resgate
  void _atualizarResgate(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => RescueUpdatePage(
              rescue: rescue,
              onUpdate: (updatedRescue) {
                // Atualizar o resgate na lista e retornar para a tela anterior
                Navigator.pop(context, updatedRescue);
              },
            ),
      ),
    );

    if (result != null && result is RescueModel) {
      // Retornar para a tela anterior com o resgate atualizado
      Navigator.pop(context, result);
    }
  }
}
