import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../provider/settings_provider/nav_provider.dart';
import '../administration_view/consumable_view/consumable_view.dart';
import '../administration_view/customers_view/customer_administration.dart';
import '../administration_view/project_management_view/project_managment_view.dart';
import '../administration_view/service_view/service_body_view.dart';
import '../home_view/home_body.dart';
import '../project_reports_view/projekt_reports_view.dart';
import '../time_entry_view/work_calendar_view.dart';
import '../users_view/user_view.dart';
import 'widgets/nav_button_widget.dart';

class MainViewNavigator extends ConsumerStatefulWidget {
  const MainViewNavigator({super.key});

  @override
  ConsumerState<MainViewNavigator> createState() => _MainViewNavigatorState();
}

class _MainViewNavigatorState extends ConsumerState<MainViewNavigator> {
  @override
  Widget build(BuildContext context) {
    final view = ref.watch(mainNavProvider);
    return Builder(
      builder: (context) => Scaffold(
        body: LayoutBuilder(
          builder: (context, constrains) => Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // color: const Color.fromARGB(255, 245, 245, 245), //* smokewhite
                // color: const Color.fromARGB(255, 254, 254, 245), //* DeckWeiss David
                // color: const Color.fromARGB(250, 251, 251, 251), //* own Marten
                color: Colors.white,
                height: constrains.maxHeight,
                child: constrains.maxWidth <= 1000
                    ? _buildpopUpNav(context, constrains)
                    : _buildStandartNavBar(context, constrains),
              ),
              Container(
                // color: const Color.fromARGB(255, 254, 254, 245), //* DeckWeiss David
                color: Colors.white,
                // color: const Color.fromARGB(255, 238, 238, 238), //* Buchweis Lara
                // color: const Color.fromARGB(255, 255, 250, 250),//* Ghost
                // color: const Color.fromARGB(250, 251, 251, 251), //* own Marten
                width: constrains.maxWidth <= 1000
                    ? constrains.maxWidth - 50
                    : ((constrains.maxWidth - 250)),
                child: switch (view) {
                  MainView.home => const HomeBody(),
                  MainView.timeEntry => const WorkCalendarView(),
                  MainView.projectCustomer => ProjectReportOverviewView(),
                  MainView.consumables => const ConsumableBodyView(),
                  MainView.customer => const CustomerBody(),
                  MainView.projectManagement => const ProjectManagementBody(),
                  MainView.performance => const ServiceBodyView(),
                  MainView.users => const EmployeeAdministration(),
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStandartNavBar(BuildContext context, BoxConstraints constrains) => Container(
        width: 250,
        color: const Color.fromARGB(255, 208, 207, 207),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18, top: 35, bottom: 35),
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
              ),
              const NavButtonWidget(
                icon: Icons.access_time,
                title: 'Zeiteintrag',
                nextView: MainView.timeEntry,
                subcategoriestitles: ['Zeiteintrag'],
                subcategoryViews: [MainView.timeEntry],
              ),
              const NavButtonWidget(
                icon: Icons.signal_cellular_alt_sharp,
                title: 'Berichte',
                nextView: MainView.projectCustomer,
                subcategoriestitles: ['Kunden/Projekte'],
                subcategoryViews: [MainView.projectCustomer],
              ),
              const NavButtonWidget(
                title: 'Verwaltung',
                nextView: MainView.consumables,
                icon: Icons.folder_open,
                subcategoriestitles: [
                  'Material',
                  'Kunden',
                  'Projekte',
                  'Leistungen',
                ],
                height: 200,
                subcategoryViews: [
                  MainView.consumables,
                  MainView.customer,
                  MainView.projectManagement,
                  MainView.performance,
                ],
              ),
              const NavButtonWidget(
                title: 'Mitarbeiter',
                nextView: MainView.users,
                icon: Icons.people_outline,
                subcategoriestitles: ['Rechte'],
                subcategoryViews: [MainView.users],
              ),
              SizedBox(
                height: (constrains.maxHeight / 10) * 1.5,
              ),
              const NavButtonWidget(
                title: 'Log Out',
                icon: Icons.logout_outlined,
              ),
            ],
          ),
        ),
      );

  Widget _buildpopUpNav(BuildContext context, BoxConstraints constrains) => Container(
        alignment: Alignment.topLeft,
        child: IconButton(
          onPressed: () => showDialog(
            barrierColor: Colors.transparent,
            context: context,
            builder: (context) => Container(
              height: constrains.maxHeight,
              margin: EdgeInsets.only(right: (MediaQuery.of(context).size.width / 10) * 6),
              child: Material(
                color: const Color.fromARGB(255, 208, 207, 207),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 18, top: 35, bottom: 35),
                        child: SizedBox(
                          height: 40,
                          child: Image.asset(
                            'assets/images/img_techtool.png',
                          ),
                        ),
                      ),
                      const NavButtonWidget(
                        icon: Icons.home_outlined,
                        title: 'Home',
                        nextView: MainView.home,
                      ),
                      const NavButtonWidget(
                        icon: Icons.access_time,
                        title: 'Zeiteintrag',
                        nextView: MainView.timeEntry,
                        subcategoriestitles: ['Zeiteintrag'],
                        subcategoryViews: [MainView.timeEntry],
                      ),
                      const NavButtonWidget(
                        title: 'Berichte',
                        nextView: MainView.projectCustomer,
                        icon: Icons.signal_cellular_alt_sharp,
                        subcategoriestitles: ['Kunden/Projekte'],
                        subcategoryViews: [MainView.projectCustomer],
                      ),
                      const NavButtonWidget(
                        icon: Icons.folder_open,
                        title: 'Verwaltung',
                        nextView: MainView.consumables,
                        height: 200,
                        subcategoriestitles: ['Material', 'Kunden', 'Projekte', 'Leistungen'],
                        subcategoryViews: [
                          MainView.consumables,
                          MainView.customer,
                          MainView.projectManagement,
                          MainView.performance,
                        ],
                      ),
                      const NavButtonWidget(
                        title: 'Mitarbeiter',
                        nextView: MainView.users,
                        icon: Icons.people_outline,
                        subcategoriestitles: ['Rechte'],
                        subcategoryViews: [MainView.users],
                      ),
                      SizedBox(
                        height: (constrains.maxHeight / 10) * 1.5,
                      ),
                      const NavButtonWidget(
                        title: 'Log Out',
                        icon: Icons.logout_outlined,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          icon: const Icon(Icons.menu),
        ),
      );
}
