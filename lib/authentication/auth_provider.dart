import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  String? _errorMessage;
  Map<String, dynamic>? _userData;
  String? _jwtToken;
  bool _isAuthenticated = false;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  Map<String, dynamic>? get userData => _userData;
  String? get jwtToken => _jwtToken;
  bool get isAuthenticated => _isAuthenticated;

  // Initialize and check if user is already logged in
  Future<void> initializeAuth() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isLoggedIn = prefs.getBool('is_logged_in') ?? false;

      if (isLoggedIn) {
        _userData = {
          '_id': prefs.getString('user_id'),
          'name': prefs.getString('user_name'),
          'email': prefs.getString('user_email'),
          'role': prefs.getString('user_role'),
        };
        _jwtToken = prefs.getString('jwt_token');
        _isAuthenticated = true;
        notifyListeners();
      }
    } catch (e) {
      print('Error initializing auth: $e');
    }
  }

  // Sign In method using AuthService
  Future<bool> signIn(String email, String password, {bool staySignedIn = true}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _authService.signIn(
        email: email,
        password: password,
      );

      if (result['success']) {
        _userData = result['data'];
        _jwtToken = result['token'];
        _isAuthenticated = true;

        // Save user data if staySignedIn is true
        if (staySignedIn) {
          await _saveUserData(result['data'], result['token'] ?? '');
        }

        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = result['message'] ?? 'Login failed';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Network error: ${e.toString()}';
      notifyListeners();
      return false;
    }
  }

  // Register method using AuthService
  Future<bool> register({
    required String name,
    required String email,
    required String phone,
    required int day,
    required int month,
    required int year,
    required String password,
    required String role,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _authService.register(
        name: name,
        email: email,
        phone: phone,
        day: day,
        month: month,
        year: year,
        password: password,
        role: role,
      );

      if (result['success']) {
        _userData = result['data'];
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = result['message'] ?? 'Registration failed';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Network error: ${e.toString()}';
      notifyListeners();
      return false;
    }
  }

  // Save user data to SharedPreferences
  Future<void> _saveUserData(Map<String, dynamic> userData, String token) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_id', userData['_id'] ?? '');
      await prefs.setString('user_name', userData['name'] ?? '');
      await prefs.setString('user_email', userData['email'] ?? '');
      await prefs.setString('user_role', userData['role'] ?? '');
      await prefs.setString('jwt_token', token);
      await prefs.setBool('is_logged_in', true);
    } catch (e) {
      print('Error saving user data: $e');
    }
  }

  // Sign out method
  Future<void> signOut() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      _userData = null;
      _jwtToken = null;
      _isAuthenticated = false;
      _errorMessage = null;

      notifyListeners();
    } catch (e) {
      _errorMessage = 'Error signing out: ${e.toString()}';
      notifyListeners();
    }
  }

  // Get user name
  String? getUserName() {
    return _userData?['name'];
  }

  // Get user email
  String? getUserEmail() {
    return _userData?['email'];
  }

  // Get user role
  String? getUserRole() {
    return _userData?['role'];
  }

  // Get user ID
  String? getUserId() {
    return _userData?['_id'];
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void clearUserData() {
    _userData = null;
    _jwtToken = null;
    _isAuthenticated = false;
    notifyListeners();
  }
}