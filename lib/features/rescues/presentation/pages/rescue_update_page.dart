import 'package:flutter/material.dart';
import 'package:myapp/core/widgets/sidebar_menu.dart';
import 'package:myapp/features/rescues/domain/models/rescue_model.dart';
import 'package:myapp/features/animals/presentation/pages/animal_form_page.dart';

class RescueUpdatePage extends StatefulWidget {
  final RescueModel rescue;
  final Function(RescueModel) onUpdate;

  const RescueUpdatePage({
    Key? key,
    required this.rescue,
    required this.onUpdate,
  }) : super(key: key);

  @override
  State<RescueUpdatePage> createState() => _RescueUpdatePageState();
}

class _RescueUpdatePageState extends State<RescueUpdatePage> {
  late String _selectedStatus;
  final TextEditingController _observacoesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.rescue.status;
    _observacoesController.text = widget.rescue.observacoes ?? '';
  }

  @override
  void dispose() {
    _observacoesController.dispose();
    super.dispose();
  }

  Widget _buildStatusCard(String status) {
    final bool isSelected = _selectedStatus == status;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedStatus = status;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? RescueModel.getStatusColor(status) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.transparent : const Color(0xFFE5E7EB),
          ),
        ),
        child: Text(
          status,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF6B7280),
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  void _salvarAtualizacao() {
    // Verificar se houve mudança
    if (_selectedStatus == widget.rescue.status &&
        _observacoesController.text == (widget.rescue.observacoes ?? '')) {
      // Se não houve mudança, mostrar mensagem e retornar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nenhuma alteração foi realizada.'),
          backgroundColor: Color(0xFF6B7280),
        ),
      );
      return;
    }

    // Criar um novo modelo de resgate com os dados atualizados
    final rescueAtualizado = RescueModel(
      id: widget.rescue.id,
      nomeAnimal: widget.rescue.nomeAnimal,
      especie: widget.rescue.especie,
      idade: widget.rescue.idade,
      sexo: widget.rescue.sexo,
      condicaoAnimal: widget.rescue.condicaoAnimal,
      observacoes: _observacoesController.text,
      status: _selectedStatus,
      localizacao: widget.rescue.localizacao,
      dataResgate: widget.rescue.dataResgate,
      responsavel: widget.rescue.responsavel,
      contato: widget.rescue.contato,
      origemDenuncia: widget.rescue.origemDenuncia,
    );

    // Chamar o callback de atualização
    widget.onUpdate(rescueAtualizado);

    // Mostrar mensagem de sucesso
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Resgate atualizado com sucesso!'),
        backgroundColor: Color(0xFF10B981),
      ),
    );

    // Se o status foi alterado para "Resgatado", redirecionar para o cadastro de animal
    if (_selectedStatus == RescueModel.STATUS_RESGATADO) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AnimalFormPage(resgate: rescueAtualizado),
        ),
      );
    } else {
      // Retornar para a tela anterior
      Navigator.pop(context);
    }
  }

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
                              'Atualizar Status do Resgate',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF333333),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Resgate #${widget.rescue.id}',
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

                    // Formulário de atualização
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
                          // Status atual
                          Row(
                            children: [
                              const Text(
                                'Status Atual: ',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF6B7280),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: RescueModel.getStatusColor(
                                    widget.rescue.status,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  widget.rescue.status,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          // Seleção de novo status
                          const Text(
                            'Novo Status',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF6B7280),
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Cards de seleção de status
                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children:
                                RescueModel.getStatusList()
                                    .map((status) => _buildStatusCard(status))
                                    .toList(),
                          ),

                          const SizedBox(height: 24),

                          // Campo de observações
                          const Text(
                            'Observações',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF6B7280),
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _observacoesController,
                            maxLines: 4,
                            decoration: InputDecoration(
                              hintText:
                                  'Adicione informações sobre a atualização...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Color(0xFFD1D5DB),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Color(0xFF00A3D7),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 32),

                          // Botão de salvar
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _salvarAtualizacao,
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
                              child: const Text(
                                'Salvar Atualização',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
}
