import 'package:freezed_annotation/freezed_annotation.dart';

import '../../customer_models/customer_credential.dart';
part 'customer_overvew_dm.freezed.dart';
part 'customer_overvew_dm.g.dart';

@freezed
class CustomerOvervewDM with _$CustomerOvervewDM {
  factory CustomerOvervewDM({
    required CustomerCredentialDM customerCredentials,
    int? customerID,
    @Default(0) int numOfProjects,
    @Default(0) int totalTimeTracked,
    double? totalCostMaterial,
    double? turnover,
  }) = _CustomerOvervewDM;

  factory CustomerOvervewDM.fromJson(json) => _$CustomerOvervewDMFromJson(json);
  const CustomerOvervewDM._();
  String get fullAdressFormated =>
      '${customerCredentials.customerStreet},${customerCredentials.customerStreetNr}\n${customerCredentials.customerZipcode}, ${customerCredentials.customerCity}';
}
