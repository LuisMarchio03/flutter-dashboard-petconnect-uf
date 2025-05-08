import 'package:flutter/material.dart';
import 'package:myapp/features/rescues/domain/models/rescue_model.dart';
import 'features/animals/domain/models/animal_model.dart';
import 'features/animals/presentation/pages/animal_form_page.dart';
import 'features/complaints/domain/models/complaint_form_model.dart';
import 'features/complaints/presentation/pages/complaint_form_page.dart';
import 'features/rescues/domain/models/rescue_form_model.dart';
import 'features/rescues/presentation/pages/rescue_form_page.dart';
import 'features/users/domain/models/user_form_model.dart';
import 'features/users/presentation/pages/user_form_page.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(const PetConnectApp());
}

class PetConnectApp extends StatelessWidget {
  const PetConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PetConnect',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light, // Pode ser alterado para suportar troca de temas
      initialRoute: AppRoutes.dashboard,
      routes: AppRoutes.routes,
      onGenerateRoute: (settings) {
        // Tratamento para rotas dinâmicas ou com parâmetros
        if (settings.name == AppRoutes.complaintForm) {
          final args = settings.arguments;
          return MaterialPageRoute(
            builder: (context) => ComplaintFormPage(
              complaint: args != null ? args as ComplaintFormModel : null,
              isEditing: args != null,
            ),
          );
        }
        
        if (settings.name == AppRoutes.animalForm) {
          final args = settings.arguments;
          return MaterialPageRoute(
            builder: (context) => AnimalFormPage(
              animal: args != null ? args as AnimalModel : null,
              isEditing: args != null,
            ),
          );
        }
        
        if (settings.name == AppRoutes.rescueForm) {
          final args = settings.arguments;
          return MaterialPageRoute(
            builder: (context) => RescueFormPage(
              rescue: args != null ? args as RescueModel : null,
              isEditing: args != null,
            ),
          );
        }
        
        if (settings.name == AppRoutes.userForm) {
          final args = settings.arguments;
          return MaterialPageRoute(
            builder: (context) => UserFormPage(
              user: args != null ? args as UserFormModel : null,
              isEditing: args != null,
            ),
          );
        }
        
        return null;
      },
      debugShowCheckedModeBanner: false,
    );
  }
}