import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tmdb_app/helpers/utils.dart';

class RestClient {
  static String baseURL = 'https://api.themoviedb.org/3';

  Future<dynamic> getAsync(String endpoint) async {
    try {
      final response = await http.get(
        Uri.parse('$baseURL/$endpoint?api_key=${Utils.TMDB_API_KEY}'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      }
    } catch (_) {}
  }
}
