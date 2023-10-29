import 'dart:convert';
import 'package:http/http.dart' as http;

//Servicio get
Future<String> fetchQuote() async {
  final response = await http.get(Uri.parse('https://zenquotes.io/api/random'));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse[0]['q'];
  } else {
    throw Exception('Failed to load quote');
  }
}
