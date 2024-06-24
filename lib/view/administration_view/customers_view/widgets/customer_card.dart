import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../constants/utilitis/utilitis.dart';
import '../../../../models/consumable_models/customer_overview_dm/customer_overvew_dm.dart';
import '../../../../provider/customer_provider/customer_provider.dart';
import 'update_customer_widget.dart';

class CustomerCard extends ConsumerStatefulWidget {
  final CustomerOvervewDM customer;
  final VoidCallback onDelete;
  final ValueChanged<CustomerOvervewDM> onUpdate;

  const CustomerCard(this.customer, {super.key, required this.onDelete, required this.onUpdate});

  @override
  ConsumerState<CustomerCard> createState() => _CustomerCardState();
}

class _CustomerCardState extends ConsumerState<CustomerCard> {
  bool _showCustomerDetails = false;
  final bool _showMessage = false;

  @override
  Widget build(BuildContext context) {
    final screenWidthInPercent = (MediaQuery.of(context).size.width / 100);

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide()),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(height: 40),
                GestureDetector(
                  child: SizedBox(
                    width: screenWidthInPercent * 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(width: 10),
                        Tooltip(
                          message:
                              'Kunde: ${widget.customer.customerCredentials.contactName}\nKontaktname: ${widget.customer.customerCredentials.contactName}\nTelefonnummer: ${widget.customer.customerCredentials.customerPhone}\nE-Mail: ${widget.customer.customerCredentials.customerEmail}\nAdresse: \n${widget.customer.fullAdressFormated}',
                          textStyle: const TextStyle(fontSize: 20, color: Colors.white),
                          child: Text(
                            widget.customer.customerCredentials.contactName,
                            textAlign: TextAlign.left,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Spacer(),
                        _iconButton(
                          icon: Icons.delete,
                          onPressed: () => Utilitis.askPopUp(
                            context,
                            message: 'Sind Sie sicher, dass Sie diese Kunde löschen wollen?',
                            onAccept: () {
                              ref
                                  .read(customerProvider.notifier)
                                  .deleteCustomer(widget.customer.customerID!)
                                  .then((success) {
                                if (success) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Center(
                                        child: Text('Kunde wurde erfolgreich gelöscht'),
                                      ),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                  widget.onDelete();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Center(
                                        child: Text('Löschen fehlgeschlagen. Bitte versuchen Sie es erneut.'),
                                      ),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                }
                                Navigator.of(context).pop(); // Dismiss the dialog
                              });
                            },
                            onReject: () {
                              Navigator.of(context).pop(); // Dismiss the dialog on reject
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Consumer(
                  builder: (context, ref, child) => Row(
                    children: [
                      _iconButton(
                        icon: Icons.edit,
                        onPressed: () => setState(() => _showCustomerDetails = !_showCustomerDetails),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            _showMessage
                ? const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Kunde wurde erfolgreich gelöscht',
                      style: TextStyle(color: Colors.green),
                    ),
                  )
                : const SizedBox.shrink(),
            _showCustomerDetails ? _customerDetailsWindow() : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  Widget _iconButton({required IconData icon, required VoidCallback onPressed}) => IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
        ),
      );

  SizedBox _customerDetailsWindow() => SizedBox(
        height: 400,
        child: Row(
          children: [
            UpdateCustomerWidget(
              onCancel: () {},
              customer: widget.customer,
              onSave: (updatedCustomer) {
                widget.onUpdate(updatedCustomer);
                setState(() => _showCustomerDetails = false);
              },
            ),
          ],
        ),
      );

  String _calculateTotalTimeInHours(int duration) => '';
}
