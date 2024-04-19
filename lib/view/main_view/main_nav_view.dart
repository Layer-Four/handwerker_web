import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../provider/settings_provider/nav_provider.dart';
import '../../routes/app_routes.dart';
import '../consumable_view/consumable_view.dart';
import '../customer_project_view/doc_screen.dart';
import '../customers_view/doc_screen.dart';
import '../home_view/home_body.dart';
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
              width: width <= 1000 ? width - 50 : width - width / 5,
              child: switch (view) {
                MainView.home => const HomeBody(),
                MainView.timeEntry => const TimeEntryBody(),
                MainView.projectCustomer => const CustomerProjectMain(),
                MainView.consumables => const ConsumableBody(),
                MainView.customer => const CustomerBody(),
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
                width: MediaQuery.of(context).size.width / 5,
                color: const Color.fromARGB(255, 208, 207, 207),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 50),
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
                    ),
                    const NavButtonWidget(
                      title: 'Zeiteintrag',
                      nextView: MainView.timeEntry,
                    ),
                    const NavButtonWidget(
                      title: 'Kunde/Projekt',
                      nextView: MainView.projectCustomer,
                    ),
                    const NavButtonWidget(
                      title: 'Material',
                      nextView: MainView.consumables,
                    ),
                    const NavButtonWidget(
                      title: 'Kunden',
                      nextView: MainView.customer,
                    ),
                    const NavButtonWidget(
                      title: 'Mitarbeiter',
                      nextView: MainView.users,
                    ),
                    const Spacer(),
                    const NavButtonWidget(
                      title: 'Log Out',
                      nextView: MainView.projectCustomer,
                    ),
                  ],
                ),
              ),
            ),
            icon: const Icon(Icons.menu),
          )
        : Container(
            height: double.infinity,
            width: MediaQuery.of(context).size.width / 5,
            color: const Color.fromARGB(255, 208, 207, 207),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50),
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
                ),
                const NavButtonWidget(
                  title: 'Zeiteintrag',
                  nextView: MainView.timeEntry,
                ),
                const NavButtonWidget(
                  title: 'Kunde/Projekt',
                  nextView: MainView.projectCustomer,
                ),
                const NavButtonWidget(
                  title: 'Material',
                  nextView: MainView.consumables,
                ),
                const NavButtonWidget(
                  title: 'Kunden',
                  nextView: MainView.customer,
                ),
                const NavButtonWidget(
                  title: 'Mitarbeiter',
                  nextView: MainView.users,
                ),
                const Spacer(),
                const NavButtonWidget(
                  title: 'Log Out',
                  // nextView: MainView.docs,
                  // color: Colors.teal,
                ),
              ],
            ),
          );
  }
}

class NavButtonWidget extends ConsumerWidget {
  final String title;
  final MainView? nextView;
  final Color? color;
  const NavButtonWidget({
    super.key,
    required this.title,
    this.nextView,
    this.color,
  });

  @override
  Widget build(BuildContext context, ref) {
    final viewFromTitle = ref.read(mainNavProvider).getMainview(title);
    final selecetView = ref.watch(mainNavProvider);
    final isCurrent = viewFromTitle == selecetView;

    return GestureDetector(
      onTap: () {
        if (nextView != null) {
          ref.read(mainNavProvider.notifier).state = nextView!;
          return;
        } else {
          Navigator.of(context).pushReplacementNamed(AppRoutes.initialRoute);
          return;
        }
      },
      child: Container(
        color: color,
        width: double.infinity,
        height: isCurrent ? 130 : 100,
        margin: const EdgeInsets.all(4),
        child: Center(
            child: Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: isCurrent ? Colors.orange : Colors.black,
              fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w500,
              fontSize: isCurrent ? 21 : 19),
        )),
      ),
    );
  }
}
