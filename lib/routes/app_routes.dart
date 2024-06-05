import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../view/administration_view/customers_view/customer_administration.dart';
import '../view/login_view/forgot_password_view.dart';
import '../view/login_view/login_view.dart';
import '../view/login_view/reset_password.dart';
import '../view/main_view/main_nav_view.dart';
import '../view/administration_view/project_management_view/project_managment_view.dart';
import '../view/start_view/start_view.dart';

class AppRoutes {
  static const initialRoute = '/start_view';
  static const anmeldeScreen = '/login_view';
  static const setPasswordScreen = '/set_password_view';
  static const viewScreen = '/view_view';
  static const forgotPassword = '/forgot_password';
  static const projectAdmin = '/project_management_view/doc_screen';
  static const customerScreen = '/customers_view/doc_screen';

  static Map<String, WidgetBuilder> routes = {
    anmeldeScreen: (context) => const LoginView(),
    forgotPassword: (context) => const ForgetScreen(),
    initialRoute: (context) => const StartView(),
    setPasswordScreen: (context) => const PasswordView(),
    viewScreen: (context) => const MainViewNavigator(),
    projectAdmin: (context) => const ProjectManagementBody(),
    customerScreen: (context) => const CustomerBody(),
  };
}
