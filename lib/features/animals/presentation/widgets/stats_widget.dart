import 'package:flutter/material.dart';

class StatsWidget extends StatelessWidget {
  final List<Map<String, String>> stats;

  const StatsWidget({Key? key, required this.stats}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 2.0,
      ),
      itemCount: stats.length,
      itemBuilder: (context, index) {
        final stat = stats[index];
        return _buildStatCard(
          label: stat['label']!,
          value: stat['value']!,
          index: index,
        );
      },
    );
  }

  Widget _buildStatCard({
    required String label,
    required String value,
    required int index,
  }) {
    final Map<int, Map<String, dynamic>> cardStyles = {
      0: {
        'icon': '🐾',
        'color': const Color(0xFFE0F7FF),
        'textColor': const Color(0xFF00A3D7),
      },
      1: {
        'icon': '🏠',
        'color': const Color(0xFFE0F7F0),
        'textColor': const Color(0xFF10B981),
      },
      2: {
        'icon': '❤️',
        'color': const Color(0xFFFFE0E6),
        'textColor': const Color(0xFFF43F5E),
      },
      3: {
        'icon': '🏥',
        'color': const Color(0xFFFFF4E0),
        'textColor': const Color(0xFFF59E0B),
      },
    };

    final style = cardStyles[index]!;

    return Container(
      decoration: BoxDecoration(
        color: style['color'] as Color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: (style['textColor'] as Color).withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(style['icon'] as String, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: style['textColor'] as Color,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: style['textColor'] as Color,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
