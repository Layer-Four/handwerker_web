import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';
import '../shared_widgets/background_widget.dart';

class StartView extends StatefulWidget {
  const StartView({super.key});

  @override
  State<StartView> createState() => _StartViewState();
}

class _StartViewState extends State<StartView> {
  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          body: BackgroundWidget(
            body: Padding(
              padding: const EdgeInsets.only(top: 60, left: 0, right: 0),
              child: Column(
                children: [
                  Flexible(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Revolutionieren \nSie Ihr Handwerk',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: const Color.fromARGB(192, 255, 255, 255),
                              fontWeight: FontWeight.bold,
                              fontSize: 27),
                        ),
                        Text(
                          'Alles, was Sie brauchen, in einer App!',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: const Color.fromARGB(255, 224, 142, 60),
                              fontWeight: FontWeight.w800,
                              fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1, // Adjust flex value as needed
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 240,
                          height: 40,
                          child: ElevatedButton(
                            autofocus: true,
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                context,
                                AppRoutes.anmeldeScreen,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              backgroundColor: const Color.fromARGB(255, 224, 142, 60),
                            ),
                            child: const Center(
                              child: Text(
                                'Los gehts!',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        SizedBox(
                          height: 40,
                          child: Image.asset(
                            'assets/images/img_techtool.png',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            imageName: 'img_anmelden.png',
          ),
        ),
      );
}
