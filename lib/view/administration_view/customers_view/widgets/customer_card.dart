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

  const CustomerCard({
    super.key,
    required this.customer,
    required this.onDelete,
    required this.onUpdate,
  });

  @override
  ConsumerState<CustomerCard> createState() => _CustomerCardState();
}

class _CustomerCardState extends ConsumerState<CustomerCard> {
  bool _showCustomerDetails = false;
  final bool _showMessage = false;

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide()),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _showCustomerDetails = !_showCustomerDetails;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 10),
                    Tooltip(
                      message:
                          'Kunde: ${widget.customer.customerCredentials.customerName}\nKontaktname: ${widget.customer.customerCredentials.contactName}\nTelefonnummer: ${widget.customer.customerCredentials.customerPhone}\nE-Mail: ${widget.customer.customerCredentials.customerEmail}\nAdresse: \n${widget.customer.fullAdressFormated}',
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
                    _iconButton(
                      icon: Icons.edit,
                      onPressed: () => setState(() => _showCustomerDetails = !_showCustomerDetails),
                    ),
                  ],
                ),
              ),
              _showMessage
                  ? const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'Kunde wurde erfolgreich gelöscht',
                        style: TextStyle(color: Colors.black),
                      ),
                    )
                  : const SizedBox.shrink(),
              _showCustomerDetails ? _customerDetailsWindow() : const SizedBox.shrink(),
            ],
          ),
        ),
      );

  Widget _iconButton({required IconData icon, required VoidCallback onPressed}) => IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
        ),
      );

  Widget _customerDetailsWindow() => SizedBox(
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
