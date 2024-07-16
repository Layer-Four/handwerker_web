import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer_credential.freezed.dart';
part 'customer_credential.g.dart';

@freezed
class CustomerCredentialDM with _$CustomerCredentialDM {
  const factory CustomerCredentialDM({
    required String contactName,
    String? companyName,
    String? customerName,
    String? customerCity,
    String? customerEmail,
    String? customerNumber,
    String? customerPhone,
    String? customerStreet,
    String? customerStreetNr,
    String? customerZipcode,
    String? country,
  }) = _CustomerCredentialDM;

  factory CustomerCredentialDM.fromJson(Map<String, dynamic> json) =>
      _$CustomerCredentialDMFromJson(json);

  const CustomerCredentialDM._();
}



          // Consumer(
          //                   builder: (context, ref, _) => Row(
          //                     mainAxisAlignment: MainAxisAlignment.end,
          //                     children: [
          //                       Padding(
          //                         padding: const EdgeInsets.all(16.0),
          //                         child: SymmetricButton(
          //                           text: 'Verwerfen',
          //                           textStyle: Theme.of(context)
          //                               .textTheme
          //                               .labelMedium
          //                               ?.copyWith(color: AppColor.kPrimaryButtonColor),
          //                           color: AppColor.kWhite,
          //                           onPressed: widget.onCancel,
          //                         ),
          //                       ),
          //                       Padding(
          //                         padding: const EdgeInsets.all(16.0),
          //                         child: SymmetricButton(
          //                           text: 'Speichern',
          //                           onPressed: () async {
          //                             if (_streetController.text.isEmpty &&
          //                                 _cityController.text.isEmpty &&
          //                                 // _companyNameController.text.isEmpty &&
          //                                 _contactController.text.isEmpty &&
          //                                 _customerNumberController.text.isEmpty &&
          //                                 _telephoneController.text.isEmpty &&
          //                                 _postNumberController.text.isEmpty) {
          //                               _showSnackBar('Bitte füllen Sie alle Felder aus.');
          //                               return;
          //                             }

          //                             final x = CreateCustomerDM(
          //                               city: _cityController.text,
          //                               street: _streetController.text,
          //                               // companyName: _companyNameController.text,
          //                               contactMail: _emailController.text,
          //                               contactPhone: _telephoneController.text,
          //                               streetNr: _housenumberController.text,
          //                               zipcode: _postNumberController.text,
          //                               contactName: _nameController.text,
          //                               externalId: _customerNumberController.text,
          //                             );

          //                             try {
          //                               final success = await ref
          //                                   .read(customerProvider.notifier)
          //                                   .updateCustomer(x, _initialCustomer.customerID!);
          //                               if (success) {
          //                                 if (widget.onSave != null) {
          //                                   // Create updated CustomerOvervewDM
          //                                   final updatedCustomer = CustomerOvervewDM(
          //                                     customerID: _initialCustomer.customerID,
          //                                     customerCredentials: CustomerCredentialDM(
          //                                       contactName: _nameController.text,
          //                                       // companyName: _companyNameController.text,
          //                                       customerStreet: _streetController.text,
          //                                       customerStreetNr: _housenumberController.text,
          //                                       customerCity: _cityController.text,
          //                                       customerZipcode: _postNumberController.text,
          //                                       customerEmail: _emailController.text,
          //                                       customerNumber: _customerNumberController.text,
          //                                       customerPhone: _telephoneController.text,
          //                                     ),
          //                                     numOfProjects: _initialCustomer.numOfProjects,
          //                                     totalCostMaterial: _initialCustomer.totalCostMaterial,
          //                                     totalTimeTracked: _initialCustomer.totalTimeTracked,
          //                                     turnover: _initialCustomer.turnover,
          //                                   );

          //                                   widget.onSave!(updatedCustomer);
          //                                 }
          //                               } else {
          //                                 _showSnackBar('Speichern fehlgeschlagen');
          //                               }
          //                             } catch (e) {
          //                               _showSnackBar('Ein Fehler ist aufgetreten');
          //                               // log'Error: $e';
          //                             }
          //                           },
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //                 ),