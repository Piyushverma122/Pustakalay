import '../models/user.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  User? _currentUser;
  bool _isLoggedIn = false;

  User? get currentUser => _currentUser;
  bool get isLoggedIn => _isLoggedIn;

  Future<bool> login(String email, String password) async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Mock authentication - in real app, this would call your backend API
      if (email.isNotEmpty && password.length >= 6) {
        _currentUser = User(
          id: '1',
          name: 'John Doe',
          email: email,
          phone: '+1 234 567 8900',
          role: UserRole.member,
          createdAt: DateTime.now(),
          borrowedBookIds: ['1', '2'],
        );
        _isLoggedIn = true;
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> register(
    String name,
    String email,
    String password,
    String phone,
  ) async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Mock registration
      _currentUser = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        email: email,
        phone: phone,
        role: UserRole.member,
        createdAt: DateTime.now(),
      );
      _isLoggedIn = true;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> logout() async {
    _currentUser = null;
    _isLoggedIn = false;
  }

  Future<bool> resetPassword(String email) async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateProfile(User updatedUser) async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      _currentUser = updatedUser;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> changePassword(
    String currentPassword,
    String newPassword,
  ) async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      return true;
    } catch (e) {
      return false;
    }
  }
}
