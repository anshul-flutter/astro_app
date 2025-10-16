import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  static const String baseUrl = 'https://api.vastuguru.cloud/api/auth';

  // Register new user
  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String phone,
    required int day,
    required int month,
    required int year,
    required String password,
    required String role,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'phone': phone,
          'dob': {
            'day': day,
            'month': month,
            'year': year,
          },
          'password': password,
          'role': role,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        return {
          'success': true,
          'data': responseData,
          'message': 'Registration successful',
        };
      } else {
        final errorData = jsonDecode(response.body);
        return {
          'success': false,
          'message': errorData['message'] ?? 'Registration failed',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Network error: ${e.toString()}',
      };
    }
  }

  // Sign In user
  Future<Map<String, dynamic>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Extract the Set-Cookie header for JWT token
        final setCookie = response.headers['set-cookie'];

        return {
          'success': true,
          'data': responseData['data'],
          'message': responseData['message'] ?? 'Login successful',
          'token': setCookie, // JWT token from cookie
        };
      } else if (response.statusCode == 400) {
        // Invalid credentials
        return {
          'success': false,
          'message': responseData['message'] ?? 'Invalid email or password',
        };
      } else if (response.statusCode == 404) {
        // User not found
        return {
          'success': false,
          'message': responseData['message'] ?? 'User not found',
        };
      } else {
        // Server error or other errors
        return {
          'success': false,
          'message': responseData['message'] ?? 'Something went wrong',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Network error: ${e.toString()}',
      };
    }
  }
}