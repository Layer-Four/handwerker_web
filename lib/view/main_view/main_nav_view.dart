import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../provider/settings_provider/nav_provider.dart';
import '../../routes/app_routes.dart';
import '../consumable_view/consumable_view.dart';
import '../customer_project_view/doc_screen.dart';
import '../customers_view/doc_screen.dart';
import '../home_view/home_body.dart';
import '../project_management_view/doc_screen.dart';
import '../time_entry_view/time_entry_view.dart';
import '../users_view/user_view.dart';

class MainViewNavigator extends ConsumerWidget {
  const MainViewNavigator({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final view = ref.watch(mainNavProvider);

    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _navToolbar(context),
          SizedBox(
              width: width <= 1000 ? width - 50 : width - width / 7,
              child: switch (view) {
                MainView.home => const HomeBody(),
                MainView.timeEntry => const TimeEntryBody(),
                MainView.projectCustomer => const CustomerProjectMain(),
                MainView.consumables => const ConsumableBody(),
                MainView.customer => const CustomerBody(),
                MainView.projectManagement => const ProjectManagementBody(),
                MainView.users => const EmployeeAdministration(),
                // _ => const TimeEntryBody(),
              }),
        ],
      ),
    );
  }

  Widget _navToolbar(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return width <= 1000
        ? IconButton(
            onPressed: () => showDialog(
              barrierColor: Colors.transparent,
              context: context,
              builder: (context) => Container(
                margin: EdgeInsets.only(right: (MediaQuery.of(context).size.width / 100) * 80),
                height: double.infinity,
                width: MediaQuery.of(context).size.width / 7,
                color: const Color.fromARGB(255, 208, 207, 207),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 35),
                      child: SizedBox(
                        height: 40,
                        child: Image.asset(
                          'assets/images/img_techtool.png',
                        ),
                      ),
                    ),
                    const NavButtonWidget(
                      title: 'Home',
                      nextView: MainView.home,
                      width: 200,
                      height: 60,
                    ),
                    const NavButtonWidget(
                      title: 'Zeiteintrag',
                      nextView: MainView.timeEntry,
                      width: 200,
                      height: 60,
                    ),
                    const NavButtonWidget(
                      title: 'Berichte',
                      nextView: MainView.projectCustomer,
                      width: 200,
                      height: 60,
                    ),
                    const NavButtonWidget(
                      title: 'Verwaltung',
                      nextView: MainView.consumables,
                      width: 200,
                      height: 150,
                    ),
                    const NavButtonWidget(
                      title: 'Kunden',
                      nextView: MainView.customer,
                      width: 200,
                      height: 60,
                    ),
                    const NavButtonWidget(
                      title: 'Projekte',
                      nextView: MainView.projectManagement,
                      width: 200,
                      height: 60,
                    ),
                    const NavButtonWidget(
                      title: 'Mitarbeiter',
                      nextView: MainView.users,
                      width: 200,
                      height: 60,
                    ),
                    const Spacer(),
                    const NavButtonWidget(
                      title: 'Log Out',
                      nextView: MainView.projectCustomer,
                      width: 200,
                      height: 60,
                    ),
                  ],
                ),
              ),
            ),
            icon: const Icon(Icons.menu),
          )
        : Container(
            height: double.infinity,
            width: MediaQuery.of(context).size.width / 7,
            color: const Color.fromARGB(255, 208, 207, 207),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 35),
                  child: SizedBox(
                    height: 40,
                    child: Image.asset(
                      'assets/images/img_techtool.png',
                    ),
                  ),
                ),
                const NavButtonWidget(
                  title: 'Home',
                  nextView: MainView.home,
                  icon: Icons.home_outlined,
                  width: 200,
                  height: 100,
                ),
                const NavButtonWidget(
                  title: 'Zeiteintrag',
                  nextView: MainView.timeEntry,
                  icon: Icons.access_time,
                  width: 200,
                  height: 100,
                ),
                const NavButtonWidget(
                  title: 'Berichte',
                  nextView: MainView.projectCustomer,
                  icon: Icons.signal_cellular_alt_sharp,
                  subcategories: ['Kunden/Projekte'],
                  width: 200,
                  height: 100,
                ),
                const NavButtonWidget(
                  title: 'Verwaltung',
                  nextView: MainView.consumables,
                  icon: Icons.folder_open,
                  subcategories: ['Projekte', 'Material', 'Kunden', 'Leistungen'],
                  width: 200,
                  height: 200,
                  subcategoryRoutes: [AppRoutes.projectAdmin, '/verwaltung/material', '/verwaltung/kunden', '/verwaltung/leistungen'], // Pass the route strings
                ),
                const NavButtonWidget(
                  title: 'Kunden',
                  nextView: MainView.customer,
                  width: 200,
                  height: 100,
                ),
                const NavButtonWidget(
                  title: 'Projekte',
                  nextView: MainView.projectManagement,
                  width: 200,
                  height: 100,
                ),
                const NavButtonWidget(
                  title: 'Mitarbeiter',
                  nextView: MainView.users,
                  icon: Icons.people_outline,
                  subcategories: ['Rechte'],
                  width: 200,
                  height: 100,
                ),
                const Spacer(),
                const NavButtonWidget(
                  title: 'Log Out',
                  // nextView: MainView.docs,
                  // color: Colors.teal,
                  width: 200,
                  height: 100,
                ),
              ],
            ),
          );
  }
}

class NavButtonWidget extends ConsumerWidget {
  final String title;
  final MainView? nextView;
  final IconData? icon;
  final List<String>? subcategories;
  final Color? color;
  final double width; // Custom width for container
  final double height; // Custom height for container
  final List<String>? subcategoryRoutes; // List of route strings for subcategories

  const NavButtonWidget({
    Key? key,
    required this.title,
    this.nextView,
    this.icon,
    this.subcategories,
    this.color,
    required this.width, // Accept width as a parameter
    required this.height, // Accept height as a parameter
    this.subcategoryRoutes, // Accept list of route strings as a parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final viewFromTitle = ref.read(mainNavProvider).getMainview(title);
    final selecetView = ref.watch(mainNavProvider);
    final isCurrent = viewFromTitle == selecetView;

    return GestureDetector(
      onTap: () {
        if (nextView != null) {
          ref.read(mainNavProvider.notifier).state = nextView!;
        } else if (subcategoryRoutes != null && subcategoryRoutes!.isNotEmpty) {
          // Handle navigation for subcategories directly by pushing named routes
          Navigator.of(context).pushNamed(subcategoryRoutes![0]); // Navigate to the first subcategory for now
        } else {
          Navigator.of(context).pushReplacementNamed(AppRoutes.initialRoute);
        }
      },
      child: Container(
        color: color,
        width: width,
        height: height,
        margin: const EdgeInsets.all(4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon ?? Icons.home,
                  // Display the icon, default to home icon if not provided
                  color: isCurrent ? Colors.orange : Colors.black,
                  // Apply color based on current state
                  size: isCurrent
                      ? 30
                      : 24, // Adjust size based on current state
                ),
                const SizedBox(width: 8), // Add spacing between icon and title
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: isCurrent ? Colors.orange : Colors.black,
                    fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w500,
                    fontSize: isCurrent ? 21 : 19,
                  ),
                ),
              ],
            ),
            if (subcategories != null)
              Row(
                children: [
                  SizedBox(width: 32),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: List.generate(
                        subcategories!.length,
                            (index) => GestureDetector(
                          onTap: () {
                            if (index < subcategoryRoutes!.length) {
                              Navigator.of(context).pushNamed(subcategoryRoutes![index]);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 1),
                            child: Text(
                              subcategories![index],
                              style: TextStyle(
                                color: isCurrent ? Colors.orange : Colors.black,
                                fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w500,
                                fontSize: isCurrent ? 18 : 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
