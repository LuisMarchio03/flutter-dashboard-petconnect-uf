import 'package:flutter/material.dart';
import 'package:myapp/features/animals/domain/models/animal_model.dart';
import 'package:myapp/features/rescues/domain/models/rescue_model.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/complaints/presentation/pages/complaints_page.dart';
import '../../features/complaints/presentation/pages/complaint_form_page.dart';
import '../../features/animals/presentation/pages/animals_page.dart';
import '../../features/animals/presentation/pages/animal_form_page.dart';
import '../../features/animals/presentation/pages/animal_details_page.dart';
import '../../features/animals/presentation/pages/adoption_form_page.dart';
import '../../features/animals/presentation/pages/sponsorship_form_page.dart';
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
  static const String animalDetails = '/animais/detalhes';
  static const String adoptionForm = '/animais/adocao';
  static const String sponsorshipForm = '/animais/apadrinhamento';
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
    animalForm:
        (context) => AnimalFormPage(resgate: RescueModel(status: 'pending')),
    animalDetails:
        (context) => AnimalDetailsPage(
          animal: AnimalModel(
            nome: '',
            genero: '',
            raca: '',
            cor: '',
            status: '',
          ),
        ),
    adoptionForm:
        (context) => AdoptionFormPage(
          animal: AnimalModel(
            nome: '',
            genero: '',
            raca: '',
            cor: '',
            status: '',
          ), isEditing: false,
        ),
    sponsorshipForm:
        (context) => SponsorshipFormPage(
          animal: AnimalModel(
            nome: '',
            genero: '',
            raca: '',
            cor: '',
            status: '',
            
          ), isEditing: false,
        ),
    rescues: (context) => const RescuesPage(),
    rescueForm: (context) => RescueFormPage(title: 'Registrar Resgate'),
    users: (context) => const UsersPage(),
    userForm: (context) => UserFormPage(),
  };

  // Método para navegação com retorno de dados
  static Future<T?> navigateTo<T>(BuildContext context, String routeName) {
    return Navigator.pushNamed(context, routeName);
  }
}
