import 'package:flutter/material.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/complaints/presentation/pages/complaints_page.dart';
import '../../features/complaints/presentation/pages/complaint_form_page.dart';
import '../../features/animals/presentation/pages/animals_page.dart';
import '../../features/animals/presentation/pages/animal_form_page.dart';
import '../../features/rescues/presentation/pages/rescues_page.dart';
import '../../features/rescues/presentation/pages/rescue_form_page.dart';
import '../../features/users/presentation/pages/users_page.dart';
import '../../features/users/presentation/pages/user_form_page.dart';

class AppRoutes {
  // Nomes das rotas
  static const String dashboard = '/';
  static const String complaints = '/denuncias';
  static const String complaintForm = '/denuncias/formulario';
  static const String animals = '/animais';
  static const String animalForm = '/animais/formulario';
  static const String rescues = '/resgates';
  static const String rescueForm = '/resgates/formulario';
  static const String users = '/usuarios';
  static const String userForm = '/usuarios/formulario';

  // Mapa de rotas
  static Map<String, WidgetBuilder> get routes => {
    dashboard: (context) => const DashboardPage(),
    complaints: (context) => const ComplaintsPage(),
    complaintForm: (context) => ComplaintFormPage(),
    animals: (context) => const AnimalsPage(),
    animalForm: (context) => AnimalFormPage(),
    rescues: (context) => const RescuesPage(),
    rescueForm: (context) => RescueFormPage(),
    users: (context) => const UsersPage(),
    userForm: (context) => UserFormPage(),
  };

  // Função para navegar para uma rota com argumentos
  static Future<T?> navigateTo<T>(BuildContext context, String routeName, {Object? arguments}) {
    return Navigator.pushNamed<T>(context, routeName, arguments: arguments);
  }

  // Função para substituir a rota atual
  static Future<T?> replaceWith<T>(BuildContext context, String routeName, {Object? arguments}) {
    return Navigator.pushReplacementNamed<T, dynamic>(context, routeName, arguments: arguments);
  }

  // Função para navegar para uma rota e remover todas as anteriores
  static Future<T?> navigateAndRemoveUntil<T>(BuildContext context, String routeName, {Object? arguments}) {
    return Navigator.pushNamedAndRemoveUntil<T>(
      context, 
      routeName, 
      (Route<dynamic> route) => false,
      arguments: arguments
    );
  }
}