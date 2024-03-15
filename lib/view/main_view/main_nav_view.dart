import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_web/provider/nav_provider.dart';
import 'package:handwerker_web/routes/app_routes.dart';
import 'package:handwerker_web/view/consumable_view/consumable_view.dart';
import 'package:handwerker_web/view/doc_view/doc_view.dart';
import 'package:handwerker_web/view/home_view/home_body.dart';
import 'package:handwerker_web/view/time_entry_view/time_entry_view.dart';
import 'package:handwerker_web/view/users_view/user_view.dart';

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
              width: width <= 1000 ? width - 50 : width - width / 4,
              child: switch (view) {
                MainView.home => const HomeBody(),
                MainView.timeEntry => const TimeEntryBody(),
                MainView.docs => const DocumentBody(),
                MainView.consumables => const ConsumableBody(),
                MainView.users => const UserBody(),
                // _ => const HomeBody(),
              }),
        ],
      ),
    );
  }

  Widget _navToolbar(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width <= 1000) {
      return Consumer(
          builder: (context, ref, child) => IconButton(
                onPressed: () => showDialog(
                  barrierColor: Colors.transparent,
                  context: context,
                  builder: (context) => Container(
                    margin: EdgeInsets.only(right: MediaQuery.of(context).size.width / 1.5),
                    height: double.infinity,
                    width: MediaQuery.of(context).size.width / 4,
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
                          nextView: MainView.docs,
                        ),
                        const NavButtonWidget(
                          title: 'Material',
                          nextView: MainView.consumables,
                        ),
                        const NavButtonWidget(
                          title: 'Mitarbeiter',
                          nextView: MainView.users,
                        ),
                        const Spacer(),
                        const NavButtonWidget(
                          title: 'Log Out',
                          nextView: MainView.docs,
                        ),
                      ],
                    ),
                  ),
                ),
                icon: const Icon(Icons.menu),
              ));
    }
    return Consumer(
      builder: (context, ref, child) {
        return Container(
          height: double.infinity,
          width: MediaQuery.of(context).size.width / 4,
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
                color: Colors.blue,
              ),
              const NavButtonWidget(
                title: 'Zeiteintrag',
                nextView: MainView.timeEntry,
              ),
              const NavButtonWidget(
                title: 'Kunde/Projekt',
                nextView: MainView.docs,
                color: Colors.blueGrey,
              ),
              const NavButtonWidget(
                title: 'Material',
                nextView: MainView.consumables,
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
      },
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
