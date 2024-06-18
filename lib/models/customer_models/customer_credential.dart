import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer_credential.freezed.dart';
part 'customer_credential.g.dart';

@freezed
class CustomerCredentialDM with _$CustomerCredentialDM {
  const factory CustomerCredentialDM({
    required String contactName,
    String? customerCity,
    String? customerEmail,
    String? customerNumber,
    String? customerPhone,
    String? customerStreet,
    String? customerStreetNr,
    String? customerZipcode,
  }) = _CustomerCredentialDM;

  factory CustomerCredentialDM.fromJson(Map<String, dynamic> json) =>
      _$CustomerCredentialDMFromJson(json);

  const CustomerCredentialDM._();
}
