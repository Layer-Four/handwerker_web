import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_customer_model.freezed.dart';
part 'create_customer_model.g.dart';

@freezed
class CreateCustomerDM with _$CreateCustomerDM {
  const factory CreateCustomerDM({
    String? id,
    String? externalId,
    String? companyName,
    String? contactName,
    String? contactPhone,
    String? contactMail,
    String? street,
    String? streetNr,
    String? zipcode,
    String? city,
    @Default('Deutschland') String country,
  }) = _CreateCustomerDM;

  factory CreateCustomerDM.fromJson(Map<String, dynamic> json) => _$CreateCustomerDMFromJson(json);

  const CreateCustomerDM._();
  String get fullAdressFormated => '$street, $streetNr\n$zipcode, $city\n$country';
  String get fullAdress => '$street, $streetNr, $zipcode, $city, $country';
}
