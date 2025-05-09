import 'package:flutter/material.dart';
import 'package:myapp/core/theme/app_colors.dart';
import 'package:myapp/core/widgets/sidebar_menu.dart';
import 'package:myapp/core/widgets/status_badge_widget.dart';
import '../../domain/models/animal_model.dart';
import '../../domain/models/adoption_model.dart';
import '../../domain/models/sponsorship_model.dart';
import 'adoption_form_page.dart';
import 'sponsorship_form_page.dart';
import '../widgets/header_widget.dart';

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
          const SidebarMenu(selectedItem: "Animais"),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeaderWidget(
                    title: 'Detalhes do Animal',
                    subtitle: 'Informações completas sobre o animal',
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildProfileSection(),
                          const SizedBox(height: 24),
                          _buildInfoSections(),
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

  Widget _buildProfileSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar do animal
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: const Color(0xFF00A3D7).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.pets, size: 60, color: Color(0xFF00A3D7)),
          ),
          const SizedBox(width: 24),
          // Informações principais
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.animal.nome,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 8),
                _buildStatusBadge(widget.animal.status),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _buildInfoChip('🐕 ${widget.animal.especie}'),
                    const SizedBox(width: 12),
                    _buildInfoChip('🎨 ${widget.animal.cor}'),
                    const SizedBox(width: 12),
                    _buildInfoChip('⚖️ ${widget.animal.porte}'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSections() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _buildInfoCard('Informações Básicas', '📋', [
            _buildInfoRow('Nome', widget.animal.nome),
            _buildInfoRow('Espécie', widget.animal.especie),
            _buildInfoRow('Raça', widget.animal.raca),
            _buildInfoRow('Gênero', widget.animal.genero),
            _buildInfoRow('Idade', widget.animal.idade),
            _buildInfoRow('Porte', widget.animal.porte),
            _buildInfoRow('Cor', widget.animal.cor),
            _buildInfoRow('Localização', widget.animal.localizacao),
          ]),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildInfoCard('Saúde', '🏥', [
            _buildInfoRow('Última Vacina', widget.animal.ultimaVacina),
            _buildInfoRow('Próxima Vacina', widget.animal.proximaVacina),
            _buildInfoRow('Condições Médicas', widget.animal.condicoesMedicas),
            _buildInfoRow('Observações', widget.animal.observacoes),
          ]),
        ),
      ],
    );
  }

  Widget _buildInfoCard(String title, String emoji, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 24)),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF6B7280),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 14, color: Color(0xFF1F2937)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    final Map<String, Map<String, dynamic>> statusStyles = {
      'Disponível': {'color': const Color(0xFF10B981), 'icon': '🏠'},
      'Adotado': {'color': const Color(0xFF3B82F6), 'icon': '❤️'},
      'Em tratamento': {'color': const Color(0xFFF59E0B), 'icon': '🏥'},
    };

    final style =
        statusStyles[status] ?? {'color': const Color(0xFF6B7280), 'icon': '❓'};

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: (style['color'] as Color).withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(style['icon'] as String, style: const TextStyle(fontSize: 14)),
          const SizedBox(width: 6),
          Text(
            status,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: style['color'] as Color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 14, color: Color(0xFF4B5563)),
      ),
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
