import 'package:flutter/material.dart';
import 'package:myapp/core/widgets/confirm_delete_dialog.dart';
import 'package:myapp/core/widgets/sidebar_menu.dart';
import 'package:myapp/features/animals/presentation/widgets/header_widget.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/models/complaint_model.dart';
import '../../domain/models/complaint_form_model.dart';
import '../widgets/complaint_list_item.dart';
import '../widgets/search_bar_widget.dart';
import 'complaint_form_page.dart';
import 'complaint_details_page.dart'; // Adicionar importação

class ComplaintsPage extends StatefulWidget {
  const ComplaintsPage({super.key});

  @override
  State<ComplaintsPage> createState() => _ComplaintsPageState();
}

class _ComplaintsPageState extends State<ComplaintsPage> {
  // Lista de exemplo para demonstração
  final List<ComplaintModel> denuncias = [
    ComplaintModel(
      endereco: 'Rua das Flores, 123 - Centro',
      dataReporte: '15/06/2023',
      descricao:
          'Cachorro amarrado sem água e comida, exposto ao sol. Animal aparenta estar desnutrido e com ferimentos.',
      status: 'Pendente',
      imagemUrl:
          'https://images.unsplash.com/photo-1548199973-03cce0bbc87b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1169&q=80',
    ),
    ComplaintModel(
      endereco: 'Av. Principal, 456 - Jardim',
      dataReporte: '10/06/2023',
      descricao:
          'Colônia de gatos em terreno abandonado sem acesso a alimentos. Vários filhotes em condições precárias.',
      status: 'Atendido',
      imagemUrl:
          'https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1143&q=80',
    ),
    ComplaintModel(
      endereco: 'Praça Central, s/n - Centro',
      dataReporte: '08/06/2023',
      descricao:
          'Cão de grande porte abandonado na praça, aparentemente sem dono. Animal está magro e com comportamento agressivo.',
      status: 'Pendente',
      imagemUrl:
          'https://images.unsplash.com/photo-1561037404-61cd46aa615b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
    ),
  ];

  final TextEditingController _searchController = TextEditingController();

  // Filtros
  String _statusFiltro = 'Todos';
  String _dataFiltro = 'Todos';

  // Lista de opções para os filtros
  final List<String> _statusOptions = [
    'Todos',
    'Pendente',
    'Em andamento',
    'Atendido',
    'Cancelado',
  ];
  final List<String> _dataOptions = [
    'Todos',
    'Hoje',
    'Esta semana',
    'Este mês',
  ];

  // Lista filtrada
  List<ComplaintModel> get _denunciasFiltradas {
    return denuncias.where((denuncia) {
      // Filtro de texto
      final matchesSearch =
          _searchController.text.isEmpty ||
          denuncia.endereco.toLowerCase().contains(
            _searchController.text.toLowerCase(),
          ) ||
          denuncia.descricao.toLowerCase().contains(
            _searchController.text.toLowerCase(),
          );

      // Filtro de status
      final matchesStatus =
          _statusFiltro == 'Todos' || denuncia.status == _statusFiltro;

      // Filtro de data (simplificado para demonstração)
      bool matchesDate = true;
      if (_dataFiltro != 'Todos') {
        // Aqui você implementaria a lógica real de filtro por data
        // Este é apenas um exemplo simplificado
        matchesDate = true;
      }

      return matchesSearch && matchesStatus && matchesDate;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Método para adicionar nova denúncia
  void _adicionarDenuncia() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ComplaintFormPage()),
    );

    if (result != null && result is ComplaintModel) {
      setState(() {
        denuncias.add(result);
      });
    }
  }

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
                // Header global
                Container(
                  padding: const EdgeInsets.all(24.0),
                  child: HeaderWidget(
                    title: 'Adotantes',
                    subtitle: 'Preencha os dados do adotante',
                  ),
                ),
                // Conteúdo da página
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Filtrar Denúncias',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF333333),
                              ),
                            ),
                            // Botão para adicionar nova denúncia
                            ElevatedButton.icon(
                              onPressed: _adicionarDenuncia,
                              icon: const Icon(Icons.add),
                              label: const Text('Nova Denúncia'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF00A3D7),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Barra de pesquisa e filtros
                        Row(
                          children: [
                            // Barra de pesquisa
                            Expanded(
                              child: SearchBarWidget(
                                controller: _searchController,
                                onChanged: (value) {
                                  setState(() {});
                                },
                              ),
                            ),
                            const SizedBox(width: 16),

                            // Filtro de status
                            _buildFilterDropdown(
                              label: 'Status',
                              value: _statusFiltro,
                              items: _statusOptions,
                              onChanged: (value) {
                                setState(() {
                                  _statusFiltro = value!;
                                });
                              },
                            ),

                            const SizedBox(width: 16),

                            // Filtro de data
                            _buildFilterDropdown(
                              label: 'Data',
                              value: _dataFiltro,
                              items: _dataOptions,
                              onChanged: (value) {
                                setState(() {
                                  _dataFiltro = value!;
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Contador de resultados
                        Text(
                          '${_denunciasFiltradas.length} denúncias encontradas',
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Lista de denúncias
                        Expanded(
                          child: ListView.builder(
                            itemCount: _denunciasFiltradas.length,
                            itemBuilder: (context, index) {
                              final denunciaIndex = denuncias.indexOf(
                                _denunciasFiltradas[index],
                              );
                              return ComplaintListItem(
                                onDetails: () {
                                  _abrirDetalhes(denunciaIndex);
                                },
                                complaint: _denunciasFiltradas[index],
                                onEdit: () async {
                                  final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => ComplaintFormPage(
                                            complaint: ComplaintFormModel(
                                              endereco:
                                                  denuncias[denunciaIndex]
                                                      .endereco,
                                              descricao:
                                                  denuncias[denunciaIndex]
                                                      .descricao,
                                              status:
                                                  denuncias[denunciaIndex]
                                                      .status,
                                              nomeCompleto: '',
                                              especieAnimal: '',
                                              numeroCelular: '',
                                              localizacao:
                                                  denuncias[denunciaIndex]
                                                      .endereco,
                                            ),
                                          ),
                                    ),
                                  );
                                  if (result != null &&
                                      result is ComplaintModel) {
                                    setState(() {
                                      denuncias[denunciaIndex] = result;
                                    });
                                  }
                                },
                                onDelete: () {
                                  _confirmarExclusao(context, () {
                                    setState(() {
                                      denuncias.removeAt(denunciaIndex);
                                    });
                                  });
                                },
                                onAttend: () {
                                  _confirmarAtendimento(context, () {
                                    setState(() {
                                      denuncias[denunciaIndex] = ComplaintModel(
                                        endereco:
                                            denuncias[denunciaIndex].endereco,
                                        dataReporte:
                                            denuncias[denunciaIndex]
                                                .dataReporte,
                                        descricao:
                                            denuncias[denunciaIndex].descricao,
                                        status: 'Em Atendimento',
                                        imagemUrl:
                                            denuncias[denunciaIndex].imagemUrl,
                                      );
                                    });
                                  });
                                },
                              );
                            },
                          ),
                        ),
                      ],
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

  // Widget para construir os dropdowns de filtro
  Widget _buildFilterDropdown({
    required String label,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7FB),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          icon: const Icon(Icons.keyboard_arrow_down),
          isDense: true,
          hint: Text(label),
          items:
              items.map((String item) {
                return DropdownMenuItem<String>(value: item, child: Text(item));
              }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  // Método para confirmar exclusão
  void _confirmarExclusao(BuildContext context, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Exclusão'),
          content: const Text(
            'Tem certeza que deseja excluir esta denúncia? Esta ação não pode ser desfeita.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
                onConfirm(); // Executa a ação de exclusão
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Excluir'),
            ),
          ],
        );
      },
    );
  }

  // Método para confirmar atendimento
  void _confirmarAtendimento(BuildContext context, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Atendimento'),
          content: const Text('Tem certeza que deseja atender esta denúncia?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
                onConfirm(); // Executa a ação de atendimento
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
  }

  // Método para abrir a tela de detalhes
  void _abrirDetalhes(int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ComplaintDetailsPage(complaint: denuncias[index]),
      ),
    );

    // Atualizar o status se retornou um resultado
    if (result != null && result is ComplaintModel) {
      setState(() {
        denuncias[index] = result;
      });
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
}
