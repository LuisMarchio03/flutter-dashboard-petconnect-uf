import 'package:flutter/material.dart';
import 'package:myapp/core/theme/app_colors.dart';
import 'package:myapp/core/widgets/sidebar_menu.dart';
import 'package:myapp/core/widgets/status_badge_widget.dart';
import '../../domain/models/animal_model.dart';
import '../../domain/models/adoption_model.dart';
import '../../domain/models/sponsorship_model.dart';
import 'adoption_form_page.dart';
import 'sponsorship_form_page.dart';

class AnimalDetailsPage extends StatefulWidget {
  final AnimalModel animal;

  const AnimalDetailsPage({super.key, required this.animal});

  @override
  State<AnimalDetailsPage> createState() => _AnimalDetailsPageState();
}

class _AnimalDetailsPageState extends State<AnimalDetailsPage> {
  AdoptionModel? _adoption;
  SponsorshipModel? _sponsorship;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const SidebarMenu(
            selectedItem: "Animais",
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Cabeçalho
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Detalhes do Animal',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Row(
                        children: [
                          ElevatedButton.icon(
                            onPressed: () => _abrirFormularioAdocao(),
                            icon: const Icon(Icons.pets),
                            label: const Text('Adotar'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF10B981),
                              foregroundColor: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 16),
                          ElevatedButton.icon(
                            onPressed: () => _abrirFormularioApadrinhamento(),
                            icon: const Icon(Icons.favorite),
                            label: const Text('Apadrinhar'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF3B82F6),
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Conteúdo
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Informações Básicas
                          _buildSection(
                            title: 'Informações Básicas',
                            child: _buildBasicInfo(),
                          ),
                          const SizedBox(height: 24),

                          // Informações de Saúde
                          _buildSection(
                            title: 'Informações de Saúde',
                            child: _buildHealthInfo(),
                          ),
                          const SizedBox(height: 24),

                          // Status de Adoção/Apadrinhamento
                          _buildSection(
                            title: 'Status',
                            child: _buildStatusInfo(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildBasicInfo() {
    return Column(
      children: [
        _buildInfoRow('Nome', widget.animal.nome),
        const SizedBox(height: 12),
        _buildInfoRow('Espécie', widget.animal.especie),
        const SizedBox(height: 12),
        _buildInfoRow('Raça', widget.animal.raca),
        const SizedBox(height: 12),
        _buildInfoRow('Gênero', widget.animal.genero),
        const SizedBox(height: 12),
        _buildInfoRow('Idade', widget.animal.idade),
        const SizedBox(height: 12),
        _buildInfoRow('Porte', widget.animal.porte),
        const SizedBox(height: 12),
        _buildInfoRow('Cor', widget.animal.cor),
        const SizedBox(height: 12),
        _buildInfoRow('Localização', widget.animal.localizacao),
      ],
    );
  }

  Widget _buildHealthInfo() {
    return Column(
      children: [
        _buildInfoRow('Última Vacina', widget.animal.ultimaVacina),
        const SizedBox(height: 12),
        _buildInfoRow('Próxima Vacina', widget.animal.proximaVacina),
        const SizedBox(height: 12),
        _buildInfoRow('Condições Médicas', widget.animal.condicoesMedicas),
        const SizedBox(height: 12),
        _buildInfoRow('Observações', widget.animal.observacoes),
      ],
    );
  }

  Widget _buildStatusInfo() {
    return Column(
      children: [
        Row(
          children: [
            const Text(
              'Status Geral: ',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            StatusBadgeWidget(
              status: widget.animal.status,
              statusColors: {
                'Disponível': const Color(0xFF10B981), // Verde
                'Adotado': const Color(0xFF3B82F6), // Azul
                'Em tratamento': const Color(0xFFEAB308), // Amarelo
              },
            ),
          ],
        ),
        if (_adoption != null) ...[
          const SizedBox(height: 16),
          _buildAdoptionInfo(),
        ],
        if (_sponsorship != null) ...[
          const SizedBox(height: 16),
          _buildSponsorshipInfo(),
        ],
      ],
    );
  }

  Widget _buildAdoptionInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Informações da Adoção',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _buildInfoRow('Adotante', _adoption!.adopterName),
          const SizedBox(height: 8),
          _buildInfoRow('E-mail', _adoption!.adopterEmail),
          const SizedBox(height: 8),
          _buildInfoRow('Telefone', _adoption!.adopterPhone),
          const SizedBox(height: 8),
          _buildInfoRow('Data da Adoção', _adoption!.adoptionDate),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text(
                'Status: ',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              StatusBadgeWidget(
                status: _adoption!.status,
                statusColors: {
                  AdoptionModel.STATUS_PENDING: const Color(0xFFEAB308),
                  AdoptionModel.STATUS_APPROVED: const Color(0xFF3B82F6),
                  AdoptionModel.STATUS_REJECTED: const Color(0xFFEF4444),
                  AdoptionModel.STATUS_COMPLETED: const Color(0xFF10B981),
                  AdoptionModel.STATUS_CANCELLED: const Color(0xFF6B7280),
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSponsorshipInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Informações do Apadrinhamento',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _buildInfoRow('Padrinho', _sponsorship!.sponsorName),
          const SizedBox(height: 8),
          _buildInfoRow('E-mail', _sponsorship!.sponsorEmail),
          const SizedBox(height: 8),
          _buildInfoRow('Telefone', _sponsorship!.sponsorPhone),
          const SizedBox(height: 8),
          _buildInfoRow('Tipo', _sponsorship!.sponsorshipType),
          const SizedBox(height: 8),
          _buildInfoRow(
            'Valor Mensal',
            'R\$ ${_sponsorship!.monthlyValue.toStringAsFixed(2)}',
          ),
          const SizedBox(height: 8),
          _buildInfoRow('Data de Início', _sponsorship!.startDate),
          if (_sponsorship!.endDate != null) ...[
            const SizedBox(height: 8),
            _buildInfoRow('Data de Término', _sponsorship!.endDate!),
          ],
          const SizedBox(height: 8),
          Row(
            children: [
              const Text(
                'Status: ',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              StatusBadgeWidget(
                status: _sponsorship!.status,
                statusColors: {
                  SponsorshipModel.STATUS_ACTIVE: const Color(0xFF10B981),
                  SponsorshipModel.STATUS_PENDING: const Color(0xFFEAB308),
                  SponsorshipModel.STATUS_SUSPENDED: const Color(0xFFEF4444),
                  SponsorshipModel.STATUS_CANCELLED: const Color(0xFF6B7280),
                  SponsorshipModel.STATUS_COMPLETED: const Color(0xFF3B82F6),
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 150,
          child: Text(
            '$label:',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
          ),
        ),
      ],
    );
  }

  void _abrirFormularioAdocao() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => AdoptionFormPage(
              animal: widget.animal,
              adoption: _adoption,
              isEditing: _adoption != null,
            ),
      ),
    );

    if (result != null && result is AdoptionModel) {
      setState(() {
        _adoption = result;
      });
    }
  }

  void _abrirFormularioApadrinhamento() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => SponsorshipFormPage(
              animal: widget.animal,
              sponsorship: _sponsorship,
              isEditing: _sponsorship != null,
            ),
      ),
    );

    if (result != null && result is SponsorshipModel) {
      setState(() {
        _sponsorship = result;
      });
    }
  }
}
