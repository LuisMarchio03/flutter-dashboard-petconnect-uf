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
          // Menu lateral
          const SidebarMenu(selectedItem: 'Resgates'),
          // Conteúdo principal
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Cabeçalho
                  Container(
                  padding: const EdgeInsets.all(24.0),
                  child: HeaderWidget(
                    title: 'Resgates',
                    subtitle: 'Lista de resgates',
                  ),
                ),
              // Barra de pesquisa e filtros
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
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
                      // Filtro de status
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFE5E7EB)),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _filtroStatus.isEmpty ? null : _filtroStatus,
                            hint: const Text('Filtrar por status'),
                            onChanged: (String? newValue) {
                              setState(() {
                                _filtroStatus = newValue ?? '';
                              });
                            },
                            items: [
                              const DropdownMenuItem<String>(
                                value: '',
                                child: Text('Todos'),
                              ),
                              ...RescueModel.getStatusList().map((
                                String status,
                              ) {
                                return DropdownMenuItem<String>(
                                  value: status,
                                  child: Text(status),
                                );
                              }).toList(),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Botão de adicionar resgate
                      ElevatedButton.icon(
                        onPressed: () {
                          _adicionarNovoResgate();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00A3D7),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        icon: const Icon(Icons.add, color: Colors.white),
                        label: const Text(
                          'Novo Resgate',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Tabela de resgates com o novo componente DataTableWidget
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: DataTableWidget(
                      columns: const [
                        'Animal',
                        'Espécie',
                        'Local',
                        'Data',
                        'Status',
                        'Ações',
                      ],
                      rows:
                          resgatesFiltrados
                              .map(
                                (resgate) => {
                                  'animal':
                                      resgate.nomeAnimal?.isNotEmpty == true
                                          ? resgate.nomeAnimal!
                                          : 'Não identificado',
                                  'espécie':
                                      resgate.especie ?? 'Não especificado',
                                  'local':
                                      resgate.localizacao ?? 'Não especificado',
                                  'data':
                                      resgate.dataResgate ?? 'Não especificado',
                                  'status': resgate.status,
                                },
                              )
                              .toList(),
                      customCellBuilders: {
                        'status':
                            (value) => StatusBadgeWidget(
                              status: value.toString(),
                              statusColors: {
                                RescueModel.STATUS_PENDENTE: Colors.orange,
                                RescueModel.STATUS_EM_ANDAMENTO: Colors.blue,
                                RescueModel.STATUS_RESGATADO: Colors.green,
                                RescueModel.STATUS_NAO_LOCALIZADO: Colors.red,
                              },
                            ),
                      },
                      actions: [
                        DataTableAction(
                          icon: Icons.visibility,
                          color: const Color(0xFF6B7280),
                          tooltip: 'Ver detalhes',
                          onPressed:
                              (index) =>
                                  _visualizarResgate(resgatesFiltrados[index]),
                        ),
                        DataTableAction(
                          icon: Icons.edit,
                          color: const Color(0xFF6B7280),
                          tooltip: 'Editar',
                          onPressed: (index) {
                            final originalIndex = resgates.indexOf(
                              resgatesFiltrados[index],
                            );
                            _editarResgate(
                              resgatesFiltrados[index],
                            );
                          },
                        ),
                        DataTableAction(
                          icon: Icons.update,
                          color: const Color(0xFF00A3D7),
                          tooltip: 'Atualizar status',
                          onPressed: (index) {
                            final originalIndex = resgates.indexOf(
                              resgatesFiltrados[index],
                            );
                            _atualizarStatusResgate(
                              resgatesFiltrados[index],
                              originalIndex,
                            );
                          },
                        ),
                        DataTableAction(
                          icon: Icons.delete,
                          color: Colors.red,
                          tooltip: 'Excluir',
                          onPressed: (index) {
                            final originalIndex = resgates.indexOf(
                              resgatesFiltrados[index],
                            );
                            _confirmarExclusao(context, () {
                              setState(() {
                                resgates.removeAt(originalIndex);
                              });
                            });
                          },
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

  // Widget _buildTableHeader(String text) {
  //   return Text(
  //     text,
  //     style: const TextStyle(
  //       fontWeight: FontWeight.bold,
  //       color: Color(0xFF374151),
  //     ),
  //   );
  // }

  // Widget _buildRescueRow(RescueModel resgate, int index) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
  //     child: Row(
  //       children: [
  //         // Nome do animal
  //         Expanded(
  //           flex: 2,
  //           child: Text(
  //             resgate.nomeAnimal?.isNotEmpty == true ? resgate.nomeAnimal! : 'Não identificado',
  //             style: const TextStyle(color: Color(0xFF374151)),
  //           ),
  //         ),
  //         // Espécie
  //         Expanded(
  //           flex: 2,
  //           child: Text(
  //             resgate.especie ?? 'Não especificado',
  //             style: const TextStyle(color: Color(0xFF374151)),
  //           ),
  //         ),
  //         // Local
  //         Expanded(
  //           flex: 2,
  //           child: Text(
  //             resgate.localizacao ?? 'Não especificado',
  //             overflow: TextOverflow.ellipsis,
  //             style: const TextStyle(color: Color(0xFF374151)),
  //           ),
  //         ),
  //         // Data
  //         Expanded(
  //           flex: 1,
  //           child: Text(
  //             resgate.dataResgate ?? 'Não especificado',
  //             style: const TextStyle(color: Color(0xFF374151)),
  //           ),
  //         ),
  //         // Status
  //         Expanded(
  //           flex: 1,
  //           child: Container(
  //             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  //             decoration: BoxDecoration(
  //               color: _getStatusColor(resgate.status),
  //               borderRadius: BorderRadius.circular(4),
  //             ),
  //             child: Text(
  //               resgate.status,
  //               textAlign: TextAlign.center,
  //               style: const TextStyle(
  //                 color: Colors.white,
  //                 fontSize: 12,
  //                 fontWeight: FontWeight.w500,
  //               ),
  //             ),
  //           ),
  //         ),
  //         // Ações
  //         Expanded(
  //           flex: 2,
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.end,
  //             children: [
  //               // Botão de detalhes
  //               IconButton(
  //                 icon: const Icon(Icons.visibility, size: 20),
  //                 color: const Color(0xFF6B7280),
  //                 onPressed: () => _verDetalhesResgate(resgate),
  //               ),
  //               // Botão de editar
  //               IconButton(
  //                 icon: const Icon(Icons.edit, size: 20),
  //                 color: const Color(0xFF6B7280),
  //                 onPressed: () => _editarResgate(index),
  //               ),
  //               // Botão de atualizar status
  //               IconButton(
  //                 icon: const Icon(Icons.update, size: 20),
  //                 color: const Color(0xFF00A3D7),
  //                 onPressed: () => _atualizarStatusResgate(resgate, index),
  //               ),
  //               // Botão de excluir
  //               IconButton(
  //                 icon: const Icon(Icons.delete, size: 20),
  //                 color: Colors.red,
  //                 onPressed: () {
  //                   _confirmarExclusao(context, () {
  //                     setState(() {
  //                       resgates.removeAt(index);
  //                     });
  //                   });
  //                 },
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Color _getStatusColor(String status) {
  //   switch (status) {
  //     case RescueModel.STATUS_PENDENTE:
  //       return Colors.orange;
  //     case RescueModel.STATUS_EM_ANDAMENTO:
  //       return Colors.blue;
  //     case RescueModel.STATUS_RESGATADO:
  //       return Colors.green;
  //     case RescueModel.STATUS_NAO_LOCALIZADO:
  //       return Colors.red;
  //     default:
  //       return Colors.grey;
  //   }
  // }

  // Método para adicionar um novo resgate
  void _adicionarNovoResgate() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RescueFormPage(title: 'Novo Resgate'),
      ),
    );

    if (result != null && result is RescueModel) {
      setState(() {
        resgates.add(result);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Resgate cadastrado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _editarResgate(RescueModel resgate) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => RescueFormPage(
              rescue: resgate,
              isEditing: true,
              title: 'Editar Resgate',
            ),
      ),
    );

    if (result != null && result is RescueModel) {
      setState(() {
        final index = resgates.indexWhere((r) => r.id == result.id);
        if (index != -1) {
          resgates[index] = result;
        }
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Resgate atualizado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _verDetalhesResgate(RescueModel resgate) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RescueDetailsPage(rescue: resgate),
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
                // Atualizar o status do resgate
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

                // Se o status for "Resgatado", perguntar se deseja cadastrar o animal
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

  void _visualizarResgate(RescueModel resgate) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RescueDetailsPage(rescue: resgate),
      ),
    );

    if (result != null && result is RescueModel) {
      setState(() {
        final index = resgates.indexWhere((r) => r.id == result.id);
        if (index != -1) {
          resgates[index] = result;
        }
      });
    }
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
