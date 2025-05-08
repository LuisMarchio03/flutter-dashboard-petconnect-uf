import 'package:flutter/material.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/widgets/sidebar_menu.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Widget _buildDashboardCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required String routeName,
  }) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, routeName);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
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
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF6B7280),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Menu lateral
          const SidebarMenu(selectedItem: 'Dashboard'),
          
          // Conteúdo principal
          Expanded(
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
                        children: const [
                          Text(
                            'Dashboard',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF333333),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Visão geral do sistema',
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
                            children: const [
                              Text(
                                'Andrew D.',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF333333),
                                ),
                              ),
                              Text(
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
                  const SizedBox(height: 32),
                  
                  // Cards do dashboard
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 3,
                      crossAxisSpacing: 24,
                      mainAxisSpacing: 24,
                      children: [
                        _buildDashboardCard(
                          title: 'Denúncias',
                          subtitle: 'Gerenciar denúncias',
                          icon: Icons.announcement,
                          color: const Color(0xFFEF4444),
                          routeName: AppRoutes.complaints,
                        ),
                        _buildDashboardCard(
                          title: 'Animais',
                          subtitle: 'Gerenciar animais',
                          icon: Icons.pets,
                          color: const Color(0xFF10B981),
                          routeName: AppRoutes.animals,
                        ),
                        _buildDashboardCard(
                          title: 'Resgates',
                          subtitle: 'Gerenciar resgates',
                          icon: Icons.local_shipping,
                          color: const Color(0xFFF59E0B),
                          routeName: AppRoutes.rescues,
                        ),
                        _buildDashboardCard(
                          title: 'Usuários',
                          subtitle: 'Gerenciar usuários',
                          icon: Icons.people,
                          color: const Color(0xFF3B82F6),
                          routeName: AppRoutes.users,
                        ),
                        _buildDashboardCard(
                          title: 'Relatórios',
                          subtitle: 'Visualizar relatórios',
                          icon: Icons.bar_chart,
                          color: const Color(0xFF8B5CF6),
                          routeName: AppRoutes.dashboard,
                        ),
                        _buildDashboardCard(
                          title: 'Configurações',
                          subtitle: 'Ajustes do sistema',
                          icon: Icons.settings,
                          color: const Color(0xFF6B7280),
                          routeName: AppRoutes.dashboard,
                        ),
                      ],
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
}