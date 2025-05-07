import 'package:flutter/material.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/animals/presentation/pages/animals_page.dart';
import 'features/users/presentation/pages/users_page.dart';
import 'core/theme/app_colors.dart';

void main() {
  runApp(const PetConnectApp());
}

class PetConnectApp extends StatelessWidget {
  const PetConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PetConnect',
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
      ),
      // Altere para a página que deseja visualizar
      // home: const LoginPage(),
      // home: const AnimalsPage(),
      home: const UsersPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
