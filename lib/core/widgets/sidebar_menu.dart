import 'package:flutter/material.dart';
import '../routes/app_routes.dart';

class SidebarMenu extends StatelessWidget {
  final String selectedItem;

  const SidebarMenu({
    Key? key,
    required this.selectedItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      // color: const Color(0xFF00A3D7),
      color: const Color(0xFF1E293B),
      child: Column(
        children: [
          const SizedBox(height: 40),
          // Logo
          Column(
            children: [
              Image.asset(
                'assets/logo.png',
                width: 140,
                height: 140,
              ),
              // const Text(
              //   'PetConnect',
              //   style: TextStyle(
              //     color: Colors.white,
              //     fontSize: 18,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              // const Text(
              //   'Conectando Vidas',
              //   style: TextStyle(
              //     color: Colors.white,
              //     fontSize: 12,
              //   ),
              // ),
            ],
          ),
          const SizedBox(height: 40),
          // Itens do menu
          _buildMenuItem(
            context,
            Icons.dashboard,
            'Dashboard',
            selectedItem == 'Dashboard',
            AppRoutes.dashboard,
          ),
          _buildMenuItem(
            context,
            Icons.announcement,
            'Denúncias',
            selectedItem == 'Denúncias',
            AppRoutes.complaints,
          ),
          _buildMenuItem(
            context,
            Icons.pets,
            'Animais',
            selectedItem == 'Animais',
            AppRoutes.animals,
          ),
          _buildMenuItem(
            context,
            Icons.local_shipping,
            'Resgates',
            selectedItem == 'Resgates',
            AppRoutes.rescues,
          ),
          _buildMenuItem(
            context,
            Icons.people,
            'Usuários',
            selectedItem == 'Usuários',
            AppRoutes.users,
          ),
          const Spacer(),
          // Botões de tema
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.dark_mode, color: Colors.white),
                onPressed: () {
                  // Implementar troca de tema
                },
              ),
              IconButton(
                icon: const Icon(Icons.light_mode, color: Colors.white),
                onPressed: () {
                  // Implementar troca de tema
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    IconData icon,
    String text,
    bool isSelected,
    String routeName,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white.withOpacity(0.2) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
        onTap: () {
          if (!isSelected) {
            Navigator.pushReplacementNamed(context, routeName);
          }
        },
        dense: true,
      ),
    );
  }
}