import 'package:json_annotation/json_annotation.dart';

class IdConverter implements JsonConverter<String?, dynamic> {
  const IdConverter();

  @override
  String? fromJson(dynamic json) {
    if (json == null) {
      return null;
    }
    return json.toString();
  }

  @override
  dynamic toJson(String? object) => object;
}
