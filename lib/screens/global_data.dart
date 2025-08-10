import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

List<Map<String, dynamic>> punishmentHistory = [];

Future<void> savePunishmentData() async {
  final prefs = await SharedPreferences.getInstance();
  final jsonData = jsonEncode(punishmentHistory);
  await prefs.setString('punishment_data', jsonData);
}

Future<void> loadPunishmentData() async {
  final prefs = await SharedPreferences.getInstance();
  final jsonString = prefs.getString('punishment_data');
  if (jsonString != null) {
    final List decoded = jsonDecode(jsonString);
    punishmentHistory = decoded.map((e) {
      return {
        'date': DateTime.parse(e['date']),
        'data': List<Map<String, dynamic>>.from(e['data']),
      };
    }).toList();
  }
}

Future<void> deletePunishmentCard(int index) async {
  punishmentHistory.removeAt(index);
  await savePunishmentData();
}
