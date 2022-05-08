import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Souvenir {
  // ignore: non_constant_identifier_names
  List<int> Date = [0, 0, 0];
  List<String> souvenirs = [];

  Souvenir(List<int> d, List<String> s) {
    Date = d;
    souvenirs = s;
  }
}

class Memoir {
  Memoir({required this.memo});
  final List<dynamic> memo;

  factory Memoir.fromJson(Map<String, dynamic> data) {
    final memo = data['Memory'] as List<dynamic>;
    return Memoir(memo: memo);
  }
}
