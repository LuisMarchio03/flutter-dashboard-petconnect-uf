import 'package:flutter/material.dart';

class ProfileDropdown extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String email;

  const ProfileDropdown({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          final RenderBox button = context.findRenderObject() as RenderBox;
          final RenderBox overlay =
              Navigator.of(context).overlay!.context.findRenderObject()
                  as RenderBox;
          final RelativeRect position = RelativeRect.fromRect(
            Rect.fromPoints(
              button.localToGlobal(Offset.zero, ancestor: overlay),
              button.localToGlobal(
                button.size.bottomRight(Offset.zero),
                ancestor: overlay,
              ),
            ),
            Offset.zero & overlay.size,
          );

          showMenu<String>(
            context: context,
            position: position,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            items: [
              PopupMenuItem<String>(
                value: 'profile',
                child: Row(
                  children: [
                    const Icon(
                      Icons.person_outline,
                      size: 20,
                      color: Color(0xFF6B7280),
                    ),
                    const SizedBox(width: 8),
                    const Text('Perfil'),
                  ],
                ),
              ),
              const PopupMenuDivider(),
              PopupMenuItem<String>(
                value: 'logout',
                child: Row(
                  children: [
                    const Icon(
                      Icons.logout,
                      size: 20,
                      color: Color(0xFF6B7280),
                    ),
                    const SizedBox(width: 8),
                    const Text('Sair'),
                  ],
                ),
              ),
            ],
          ).then((value) {
            if (value == 'profile') {
              Navigator.pushNamed(context, '/profile');
            } else if (value == 'logout') {
              Navigator.pushReplacementNamed(context, '/login');
            }
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: Row(
            children: [
              CircleAvatar(radius: 20, backgroundImage: NetworkImage(imageUrl)),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF111827),
                    ),
                  ),
                  Text(
                    email,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_drop_down, color: Color(0xFF6B7280)),
            ],
          ),
        ),
      ),
    );
  }
}
