import 'dart:convert';
import 'package:http/http.dart' as http;
import 'model.dart'; // Import your model classes

class ApiService {
  final String baseUrl = "https://jsonplaceholder.typicode.com/users";

  Future<List<UserModel>> fetchUsers() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      try {
        final List<dynamic> responseBody = jsonDecode(response.body);
        final List<UserModel> users =
            responseBody.map((json) => UserModel.fromJson(json)).toList();
        return users;
      } catch (e) {
        throw Exception('An Unknown Error Occurred');
      }
    } else {
      throw Exception('Failed to load data');
    }
  }
}
