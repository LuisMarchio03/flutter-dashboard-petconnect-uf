import 'package:flutter/material.dart';
import 'package:myapp/core/widgets/confirm_delete_dialog.dart';
import 'package:myapp/core/widgets/sidebar_menu.dart';
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
      resgatesFiltrados = resgatesFiltrados.where((resgate) {
        return resgate.nomeAnimal?.toLowerCase().contains(_searchController.text.toLowerCase()) == true ||
               resgate.especie?.toLowerCase().contains(_searchController.text.toLowerCase()) == true ||
               resgate.localizacao!.toLowerCase().contains(_searchController.text.toLowerCase());
      }).toList();
    }
    
    if (_filtroStatus.isNotEmpty) {
      resgatesFiltrados = resgatesFiltrados.where((resgate) => 
        resgate.status == _filtroStatus
      ).toList();
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
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Resgate',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF333333),
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Listagem de resgate',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF6B7280),
                            ),
                          ),
                        ],
                      ),
                      // Perfil do usuário
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 16,
                            backgroundImage: NetworkImage(
                              'https://randomuser.me/api/portraits/men/1.jpg',
                            ),
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Andrew D.',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF333333),
                                ),
                              ),
                              const Text(
                                'admin@gmail.com',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF6B7280),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
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
                              ...RescueModel.getStatusList().map((String status) {
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
                          _adicionarResgate();
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
                // Tabela de resgates
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Container(
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
                        children: [
                          // Cabeçalho da tabela
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: _buildTableHeader('Animal'),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: _buildTableHeader('Espécie'),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: _buildTableHeader('Local'),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: _buildTableHeader('Data'),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: _buildTableHeader('Status'),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: _buildTableHeader('Ações'),
                                ),
                              ],
                            ),
                          ),
                          const Divider(height: 1),
                          // Lista de resgates
                          Expanded(
                            child: ListView.separated(
                              itemCount: resgatesFiltrados.length,
                              separatorBuilder: (context, index) => const Divider(height: 1),
                              itemBuilder: (context, index) {
                                final resgate = resgatesFiltrados[index];
                                return _buildRescueRow(resgate, index);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Paginação
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    children: [
                      Text(
                        'Mostrando ${resgatesFiltrados.length} de ${resgates.length} resgates',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFE5E7EB)),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.chevron_left),
                              onPressed: () {},
                              color: const Color(0xFF6B7280),
                              iconSize: 20,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: const BoxDecoration(
                                color: Color(0xFF00A3D7),
                                border: Border.symmetric(
                                  vertical: BorderSide(
                                    color: Color(0xFFE5E7EB),
                                  ),
                                ),
                              ),
                              child: const Text(
                                '1',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.chevron_right),
                              onPressed: () {},
                              color: const Color(0xFF6B7280),
                              iconSize: 20,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Color(0xFF374151),
      ),
    );
  }

  Widget _buildRescueRow(RescueModel resgate, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        children: [
          // Nome do animal
          Expanded(
            flex: 2,
            child: Text(
              resgate.nomeAnimal?.isNotEmpty == true ? resgate.nomeAnimal! : 'Não identificado',
              style: const TextStyle(color: Color(0xFF374151)),
            ),
          ),
          // Espécie
          Expanded(
            flex: 2,
            child: Text(
              resgate.especie ?? 'Não especificado',
              style: const TextStyle(color: Color(0xFF374151)),
            ),
          ),
          // Local
          Expanded(
            flex: 2,
            child: Text(
              resgate.localizacao ?? 'Não especificado',
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Color(0xFF374151)),
            ),
          ),
          // Data
          Expanded(
            flex: 1,
            child: Text(
              resgate.dataResgate ?? 'Não especificado',
              style: const TextStyle(color: Color(0xFF374151)),
            ),
          ),
          // Status
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _getStatusColor(resgate.status),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                resgate.status,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          // Ações
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Botão de detalhes
                IconButton(
                  icon: const Icon(Icons.visibility, size: 20),
                  color: const Color(0xFF6B7280),
                  onPressed: () => _verDetalhesResgate(resgate),
                ),
                // Botão de editar
                IconButton(
                  icon: const Icon(Icons.edit, size: 20),
                  color: const Color(0xFF6B7280),
                  onPressed: () => _editarResgate(index),
                ),
                // Botão de atualizar status
                IconButton(
                  icon: const Icon(Icons.update, size: 20),
                  color: const Color(0xFF00A3D7),
                  onPressed: () => _atualizarStatusResgate(resgate, index),
                ),
                // Botão de excluir
                IconButton(
                  icon: const Icon(Icons.delete, size: 20),
                  color: Colors.red,
                  onPressed: () {
                    _confirmarExclusao(context, () {
                      setState(() {
                        resgates.removeAt(index);
                      });
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case RescueModel.STATUS_PENDENTE:
        return Colors.orange;
      case RescueModel.STATUS_EM_ANDAMENTO:
        return Colors.blue;
      case RescueModel.STATUS_RESGATADO:
        return Colors.green;
      case RescueModel.STATUS_NAO_LOCALIZADO:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  // Método para adicionar um novo resgate
  void _adicionarResgate() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RescueFormPage()),
    );

    if (result != null) {
      setState(() {
        resgates.add(result);
      });
    }
  }

  void _editarResgate(int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            RescueFormPage(rescue: resgates[index], isEditing: true),
      ),
    );

    if (result != null) {
      setState(() {
        resgates[index] = result;
      });
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
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                items: RescueModel.getStatusList().map((String status) {
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
              child: const Text('Salvar', style: TextStyle(color: Colors.white)),
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
          content: const Text('O animal foi resgatado com sucesso. Deseja cadastrá-lo no sistema?'),
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
      MaterialPageRoute(
        builder: (context) => AnimalFormPage(
          
          resgate: resgate,
        ),
      ),
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
