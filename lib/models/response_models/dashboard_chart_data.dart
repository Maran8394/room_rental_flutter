// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DashboardChartData {
  double rent;
  double electricity;
  double water;
  double service;
  DashboardChartData({
    required this.rent,
    required this.electricity,
    required this.water,
    required this.service,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'rent': rent,
      'electricity': electricity,
      'water': water,
      'service': service,
    };
  }

  factory DashboardChartData.fromMap(Map<String, dynamic> map) {
    return DashboardChartData(
      rent: map['rent'] as double,
      electricity: map['electricity'] as double,
      water: map['water'] as double,
      service: map['service'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory DashboardChartData.fromJson(String source) =>
      DashboardChartData.fromMap(json.decode(source) as Map<String, dynamic>);
}
