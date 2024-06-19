import 'package:freezed_annotation/freezed_annotation.dart';
part 'customer_short_dm.freezed.dart';
part 'customer_short_dm.g.dart';

@freezed
class CustomerShortDM with _$CustomerShortDM {
  factory CustomerShortDM({
    required int id,
    required String companyName,
  }) = _CustomerShortDM;
  factory CustomerShortDM.fromJson(Map<String, dynamic> json) => _$CustomerShortDMFromJson(json);
}
