import 'package:flutter/material.dart';

class UserTypeForm extends StatefulWidget {
  final String tipoUsuario;
  final List<String> perfisAcesso;
  final Function(String) onTipoUsuarioChanged;
  final Function(List<String>) onPerfisAcessoChanged;

  const UserTypeForm({
    Key? key,
    required this.tipoUsuario,
    required this.perfisAcesso,
    required this.onTipoUsuarioChanged,
    required this.onPerfisAcessoChanged,
  }) : super(key: key);

  @override
  State<UserTypeForm> createState() => _UserTypeFormState();
}

class _UserTypeFormState extends State<UserTypeForm> {
  final List<String> _tiposUsuario = ['Cliente', 'Acesso ao Dashboard'];
  final List<String> _perfisAcesso = ['Administrador', 'Veterinário', 'Recepcionista', 'Auxiliar', 'Financeiro'];
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tipo de Usuário',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 24),
          
          // Tipo de Usuário
          Row(
            children: _tiposUsuario.map((tipo) {
              final isSelected = widget.tipoUsuario == tipo;
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: ElevatedButton(
                  onPressed: () {
                    widget.onTipoUsuarioChanged(tipo);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isSelected ? const Color(0xFF00A3D7) : Colors.white,
                    foregroundColor: isSelected ? Colors.white : const Color(0xFF6B7280),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        color: isSelected ? Colors.transparent : const Color(0xFFE5E7EB),
                      ),
                    ),
                  ),
                  child: Text(tipo),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          
          // Perfil de Acesso (apenas se for Acesso ao Dashboard)
          if (widget.tipoUsuario == 'Acesso ao Dashboard') ...[
            const Text(
              'Perfil de Acesso (Dashboard)',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF374151),
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: _perfisAcesso.map((perfil) {
                final isSelected = widget.perfisAcesso.contains(perfil);
                return ElevatedButton(
                  onPressed: () {
                    List<String> updatedPerfis = List.from(widget.perfisAcesso);
                    if (isSelected) {
                      updatedPerfis.remove(perfil);
                    } else {
                      updatedPerfis.add(perfil);
                    }
                    widget.onPerfisAcessoChanged(updatedPerfis);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isSelected ? const Color(0xFF00A3D7) : Colors.white,
                    foregroundColor: isSelected ? Colors.white : const Color(0xFF6B7280),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        color: isSelected ? Colors.transparent : const Color(0xFFE5E7EB),
                      ),
                    ),
                  ),
                  child: Text(perfil),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
}