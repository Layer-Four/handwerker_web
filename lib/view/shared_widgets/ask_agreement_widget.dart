import 'package:flutter/material.dart';

import 'symetric_button_widget.dart';

class AskoForAgreement extends StatelessWidget {
  final String message;
  final Function() onAccept;
  final Function() onReject;
  const AskoForAgreement({
    super.key,
    required this.message,
    required this.onAccept,
    required this.onReject,
  });
  @override
  Widget build(BuildContext context) => Dialog(
        backgroundColor: Colors.white,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(),
          ),
          height: 350,
          width: MediaQuery.of(context).size.width * 0.60,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(right: 8, bottom: 50),
                alignment: Alignment.centerRight,
                width: MediaQuery.of(context).size.width * 0.60,
                child: IconButton(
                  onPressed: onReject,
                  icon: const Icon(Icons.close),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        message,
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40.0),
                            child: SymmetricButton(
                              text: 'Ja',
                              onPressed: onAccept,
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40.0),
                            child: SymmetricButton(
                              text: 'Nein',
                              onPressed: onReject,
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
//    showDialog(
          //   //  TODO: Add on rigth top corner a close button('X')
          //   context: context,
          //   barrierColor: const Color.fromARGB(20, 0, 0, 0),
          //   builder: (context) => Dialog(
          //     backgroundColor: Colors.white,
          //     child: Container(
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(24),
          //         border: Border.all(),
          //       ),
          //       height: 350,
          //       width: MediaQuery.of(context).size.width * 0.60,
          //       child: Column(
          //         // mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           SizedBox(
          //             width: MediaQuery.of(context).size.width * 0.60,
          //             child: IconButton(
          //               onPressed: onReject,
          //               icon: const Icon(Icons.close),
          //             ),
          //           ),
          //           Center(
          //             child: Padding(
          //               padding: const EdgeInsets.all(8.0),
          //               child: Column(
          //                 children: [
          //                   Text(
          //                     message,
          //                     style: Theme.of(context).textTheme.titleLarge,
          //                     textAlign: TextAlign.center,
          //                   ),
          //                   Row(
          //                     mainAxisAlignment: MainAxisAlignment.center,
          //                     children: [
          //                       Padding(
          //                         padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40.0),
          //                         child: SymmetricButton(
          //                           text: 'Ja',
          //                           onPressed: onAccept,
          //                           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          //                         ),
          //                       ),
          //                       Padding(
          //                         padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40.0),
          //                         child: SymmetricButton(
          //                           text: 'Nein',
          //                           onPressed: onReject,
          //                           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // );