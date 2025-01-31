import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenCubit extends Cubit<String?> {
  TokenCubit() : super(null);

  // Load token from SharedPreferences
  Future<void> loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    emit(token); // Emit the loaded token
  }

  // Save token to SharedPreferences
  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    loadToken(); // Reload the token after saving
  }

  // Clear token from SharedPreferences
  Future<void> clearToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    emit(null); // Emit null to indicate no token
  }
}