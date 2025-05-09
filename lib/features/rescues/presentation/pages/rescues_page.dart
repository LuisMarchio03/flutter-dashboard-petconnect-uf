import 'package:flutter/material.dart';
import 'package:myapp/core/widgets/confirm_delete_dialog.dart';
import 'package:myapp/core/widgets/data_table_widget.dart';
import 'package:myapp/core/widgets/sidebar_menu.dart';
import 'package:myapp/core/widgets/status_badge_widget.dart';
import 'package:myapp/features/animals/presentation/widgets/header_widget.dart';
import 'package:myapp/features/rescues/domain/models/rescue_form_model.dart';
import 'package:myapp/features/rescues/presentation/pages/rescue_form_page.dart';
import 'package:myapp/features/animals/presentation/pages/animal_form_page.dart';
import 'package:myapp/features/rescues/presentation/pages/rescue_details_page.dart';
import '../../domain/models/rescue_model.dart';
import '../widgets/rescue_list_item.dart';
import '../widgets/search_bar_widget.dart';

class RescuesPage extends StatefulWidget {
  const RescuesPage({super.key});

  @override
  State<RescuesPage> createState() => _RescuesPageState();
}

class _RescuesPageState extends State<RescuesPage> {
  // Lista de exemplo para demonstração
  final List<RescueModel> resgates = [
    RescueModel(
      id: '1',
      localizacao: '123 Rua Principal, Apt 4B',
      observacoes:
          'Gato ferido encontrado embaixo de um carro estacionado. Parece ter uma pata ferida e é incapaz de andar corretamente. Muito assustado, mas não agressivo.',
      especie: 'Gato doméstico',
      status: RescueModel.STATUS_PENDENTE,
      dataResgate: '2023-09-25',
      nomeAnimal: 'Max',
      idade: '3 anos',
    ),
    RescueModel(
      id: '2',
      localizacao: 'Avenida Oak, 456',
      observacoes:
          'O guaxinim parece estar desorientado e andando em círculos. Possivelmente doente ou ferido. Localizado perto do parque infantil. Preocupado com a segurança pública.',
      especie: 'Guaxinim',
      status: RescueModel.STATUS_EM_ANDAMENTO,
      dataResgate: '2023-09-24',
      nomeAnimal: '',
      idade: '',
    ),
    RescueModel(
      id: '3',
      localizacao: 'Praça Central, próximo ao chafariz',
      observacoes:
          'Cachorro abandonado, aparentemente sem dono. Está no local há 3 dias. Amigável com pessoas.',
      especie: 'Cachorro',
      status: RescueModel.STATUS_RESGATADO,
      dataResgate: '2023-09-22',
      nomeAnimal: 'Thor',
      idade: '2 anos',
    ),
  ];

  final TextEditingController _searchController = TextEditingController();
  String _filtroStatus = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Filtrar resgates com base na pesquisa e status
    List<RescueModel> resgatesFiltrados = resgates;

    if (_searchController.text.isNotEmpty) {
      resgatesFiltrados =
          resgatesFiltrados.where((resgate) {
            return resgate.nomeAnimal?.toLowerCase().contains(
                      _searchController.text.toLowerCase(),
                    ) ==
                    true ||
                resgate.especie?.toLowerCase().contains(
                      _searchController.text.toLowerCase(),
                    ) ==
                    true ||
                resgate.localizacao!.toLowerCase().contains(
                  _searchController.text.toLowerCase(),
                );
          }).toList();
    }

    if (_filtroStatus.isNotEmpty) {
      resgatesFiltrados =
          resgatesFiltrados
              .where((resgate) => resgate.status == _filtroStatus)
              .toList();
    }

    return Scaffold(
      body: Row(
        children: [
          const SidebarMenu(selectedItem: "Resgates"),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeaderWidget(
                    title: 'Resgates',
                    subtitle: 'Gerencie os resgates de animais',
                  ),
                  const SizedBox(height: 24),
                  _buildStatusCards(),
                  const SizedBox(height: 24),
                  _buildActionBar(),
                  const SizedBox(height: 24),
                  Expanded(child: _buildRescuesList(resgatesFiltrados)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCards() {
    final Map<String, Map<String, dynamic>> statusInfo = {
      RescueModel.STATUS_PENDENTE: {
        'label': 'Pendentes',
        'icon': '⏳',
        'color': const Color(0xFFFFF4E0),
        'textColor': const Color(0xFFF59E0B),
        'count':
            resgates
                .where((r) => r.status == RescueModel.STATUS_PENDENTE)
                .length,
      },
      RescueModel.STATUS_EM_ANDAMENTO: {
        'label': 'Em Andamento',
        'icon': '🚑',
        'color': const Color(0xFFE0F7FF),
        'textColor': const Color(0xFF00A3D7),
        'count':
            resgates
                .where((r) => r.status == RescueModel.STATUS_EM_ANDAMENTO)
                .length,
      },
      RescueModel.STATUS_RESGATADO: {
        'label': 'Resgatados',
        'icon': '✅',
        'color': const Color(0xFFE0F7F0),
        'textColor': const Color(0xFF10B981),
        'count':
            resgates
                .where((r) => r.status == RescueModel.STATUS_RESGATADO)
                .length,
      },
      RescueModel.STATUS_CANCELADO: {
        'label': 'Cancelados',
        'icon': '❌',
        'color': const Color(0xFFFFE0E6),
        'textColor': const Color(0xFFF43F5E),
        'count':
            resgates
                .where((r) => r.status == RescueModel.STATUS_CANCELADO)
                .length,
      },
    };

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 2.0,
      ),
      itemCount: statusInfo.length,
      itemBuilder: (context, index) {
        final status = statusInfo.keys.elementAt(index);
        final info = statusInfo[status]!;
        return _buildStatusCard(
          label: info['label'] as String,
          icon: info['icon'] as String,
          color: info['color'] as Color,
          textColor: info['textColor'] as Color,
          count: info['count'] as int,
          onTap: () {
            setState(() {
              _filtroStatus = _filtroStatus == status ? '' : status;
            });
          },
          isSelected: _filtroStatus == status,
        );
      },
    );
  }

  Widget _buildStatusCard({
    required String label,
    required String icon,
    required Color color,
    required Color textColor,
    required int count,
    required VoidCallback onTap,
    required bool isSelected,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? textColor : textColor.withOpacity(0.2),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(icon, style: const TextStyle(fontSize: 24)),
              const SizedBox(height: 4),
              Text(
                count.toString(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: textColor,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionBar() {
    return Row(
      children: [
        Expanded(
          child: SearchBarWidget(
            controller: _searchController,
            onChanged: (value) {
              setState(() {});
            },
          ),
        ),
        const SizedBox(width: 16),
        ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => RescueFormPage(title: 'Registrar Resgate'),
              ),
            );
          },
          icon: const Icon(Icons.add),
          label: const Text('Novo Resgate'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF00A3D7),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRescuesList(List<RescueModel> resgates) {
    if (resgates.isEmpty) {
      return const Center(
        child: Text(
          'Nenhum resgate encontrado',
          style: TextStyle(fontSize: 16, color: Color(0xFF6B7280)),
        ),
      );
    }

    return ListView.builder(
      itemCount: resgates.length,
      itemBuilder: (context, index) {
        final resgate = resgates[index];
        return RescueListItem(
          rescue: resgate,
          onDetails: () => _verDetalhesResgate(resgate),
          onEdit: () => _editarResgate(resgate),
          onDelete:
              () => _confirmarExclusao(context, () {
                setState(() {
                  resgates.removeAt(index);
                });
              }),
          onUpdateStatus: () => _atualizarStatusResgate(resgate, index),
        );
      },
    );
  }

  void _verDetalhesResgate(RescueModel resgate) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RescueDetailsPage(rescue: resgate),
      ),
    );
  }

  void _editarResgate(RescueModel resgate) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) =>
                RescueFormPage(title: 'Editar Resgate', rescue: resgate),
      ),
    );
  }

  void _atualizarStatusResgate(RescueModel resgate, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String novoStatus = resgate.status;

        return AlertDialog(
          title: const Text('Atualizar Status do Resgate'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Selecione o novo status:'),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: novoStatus,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                ),
                items:
                    RescueModel.getStatusList().map((String status) {
                      return DropdownMenuItem<String>(
                        value: status,
                        child: Text(status),
                      );
                    }).toList(),
                onChanged: (String? value) {
                  novoStatus = value!;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  final resgateAtualizado = RescueModel(
                    id: resgate.id,
                    localizacao: resgate.localizacao,
                    dataResgate: resgate.dataResgate,
                    observacoes: resgate.observacoes,
                    status: novoStatus,
                    nomeAnimal: resgate.nomeAnimal,
                    especie: resgate.especie,
                    idade: resgate.idade,
                    sexo: resgate.sexo,
                    condicaoAnimal: resgate.condicaoAnimal,
                  );

                  resgates[index] = resgateAtualizado;
                });

                Navigator.pop(context);

                if (novoStatus == RescueModel.STATUS_RESGATADO) {
                  _perguntarCadastroAnimal(resgate);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00A3D7),
              ),
              child: const Text(
                'Salvar',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void _perguntarCadastroAnimal(RescueModel resgate) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Animal Resgatado'),
          content: const Text(
            'O animal foi resgatado com sucesso. Deseja cadastrá-lo no sistema?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Não'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _cadastrarAnimal(resgate);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00A3D7),
              ),
              child: const Text('Sim', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _cadastrarAnimal(RescueModel resgate) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AnimalFormPage(resgate: resgate)),
    );
  }
}

void _confirmarExclusao(BuildContext context, VoidCallback onConfirm) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ConfirmDeleteDialog(
        title: 'Confirmar Exclusão',
        content:
            'Tem certeza que deseja excluir este registro? Esta ação não pode ser desfeita.',
        onConfirm: onConfirm,
      );
    },
  );
}
