import 'package:flutter/material.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/widgets/sidebar_menu.dart';
import '../../../../core/widgets/stats_card_widget.dart';

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
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
          border: Border.all(color: color.withOpacity(0.1), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                height: 1.4,
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
          const SidebarMenu(selectedItem: 'Dashboard'),
          Expanded(
            child: Container(
              color: const Color(0xFFF8FAFC),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
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
                                'Dashboard',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1E293B),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Bem-vindo ao PetConnect',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          // Perfil do usuário
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
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
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: const Color(0xFF3B82F6),
                                  child: const Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Andrew D.',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF1E293B),
                                      ),
                                    ),
                                    Text(
                                      'admin@gmail.com',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),

                      // Cards de estatísticas
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 4,
                        crossAxisSpacing: 24,
                        mainAxisSpacing: 24,
                        childAspectRatio: 3.0,
                        children: [
                          StatsCardWidget(
                            title: 'Total de Denúncias',
                            value: '24',
                            color: const Color(0xFFEF4444),
                            emoji: '🚨',
                          ),
                          StatsCardWidget(
                            title: 'Animais Cadastrados',
                            value: '156',
                            color: const Color(0xFF10B981),
                            emoji: '🐾',
                          ),
                          StatsCardWidget(
                            title: 'Resgates Realizados',
                            value: '89',
                            color: const Color(0xFFF59E0B),
                            emoji: '🚚',
                          ),
                          StatsCardWidget(
                            title: 'Usuários Ativos',
                            value: '1.2k',
                            color: const Color(0xFF3B82F6),
                            emoji: '👥',
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),

                      // Cards do dashboard
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 3,
                        crossAxisSpacing: 24,
                        mainAxisSpacing: 24,
                        childAspectRatio: 1.5,
                        children: [
                          _buildDashboardCard(
                            title: 'Denúncias',
                            subtitle:
                                'Gerencie e acompanhe as denúncias recebidas',
                            icon: Icons.announcement,
                            color: const Color(0xFFEF4444),
                            routeName: AppRoutes.complaints,
                          ),
                          _buildDashboardCard(
                            title: 'Animais',
                            subtitle:
                                'Cadastre e gerencie os animais do sistema',
                            icon: Icons.pets,
                            color: const Color(0xFF10B981),
                            routeName: AppRoutes.animals,
                          ),
                          _buildDashboardCard(
                            title: 'Resgates',
                            subtitle:
                                'Acompanhe e gerencie os resgates de animais',
                            icon: Icons.local_shipping,
                            color: const Color(0xFFF59E0B),
                            routeName: AppRoutes.rescues,
                          ),
                          _buildDashboardCard(
                            title: 'Usuários',
                            subtitle:
                                'Gerencie os usuários e permissões do sistema',
                            icon: Icons.people,
                            color: const Color(0xFF3B82F6),
                            routeName: AppRoutes.users,
                          ),
                          _buildDashboardCard(
                            title: 'Relatórios',
                            subtitle:
                                'Visualize relatórios e estatísticas do sistema',
                            icon: Icons.bar_chart,
                            color: const Color(0xFF8B5CF6),
                            routeName: AppRoutes.dashboard,
                          ),
                          _buildDashboardCard(
                            title: 'Configurações',
                            subtitle: 'Configure as preferências do sistema',
                            icon: Icons.settings,
                            color: const Color(0xFF6B7280),
                            routeName: AppRoutes.dashboard,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
