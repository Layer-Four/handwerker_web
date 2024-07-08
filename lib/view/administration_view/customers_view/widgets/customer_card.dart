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

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4.0),
        child: Material(
          borderRadius: BorderRadius.circular(6),
          elevation: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () => setState(() {
                  _showCustomerDetails = !_showCustomerDetails;
                }),
                child: Container(
                  height: 69,
                  padding: const EdgeInsets.only(left: 6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Tooltip(
                        message:
                            'Kunde: ${widget.customer.customerCredentials.customerName}\nKontaktname: ${widget.customer.customerCredentials.contactName}\nTelefonnummer: ${widget.customer.customerCredentials.customerPhone}\nE-Mail: ${widget.customer.customerCredentials.customerEmail}\nAdresse: \n${widget.customer.fullAdressFormated}',
                        textStyle: const TextStyle(fontSize: 20, color: Colors.white),
                        child: Text(
                          widget.customer.customerCredentials.contactName,
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => Utilitis.askPopUp(
                          context,
                          message: 'Sind Sie sicher, dass Sie diese Kunde löschen wollen?',
                          onAccept: () {
                            ref
                                .read(customerProvider.notifier)
                                .deleteCustomer(widget.customer.customerID!)
                                .then((success) {
                              if (success) {
                                Utilitis.showSnackBar(context, 'Kunde wurde erfolgreich gelöscht');
                                widget.onDelete();
                              } else {
                                Utilitis.showSnackBar(context,
                                    'Löschen fehlgeschlagen. Bitte versuchen Sie es erneut.');
                              }
                              Navigator.of(context).pop(); // Dismiss the dialog
                            });
                          },
                          onReject: () {
                            Navigator.of(context).pop(); // Dismiss the dialog on reject
                          },
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () =>
                            setState(() => _showCustomerDetails = !_showCustomerDetails),
                      ),
                    ],
                  ),
                ),
              ),
              _showCustomerDetails ? _customerDetailsWindow() : const SizedBox.shrink(),
            ],
          ),
        ),
      );

  Widget _customerDetailsWindow() => SizedBox(
        height: 400,
        child: Row(
          children: [
            UpdateCustomerWidget(
              onCancel: () => setState(() => _showCustomerDetails = false),
              customer: widget.customer,
              onSave: (updatedCustomer) {
                widget.onUpdate(updatedCustomer);
                setState(() => _showCustomerDetails = false);
              },
            ),
          ],
        ),
      );
}
