import '../model/user_model.dart';
import '../core/helper/shared_preferences_helper.dart';

class AuthController {
  final SharedPreferencesHelper prefs = SharedPreferencesHelper();

  Future<void> saveUser(UserModel user) async {
    await prefs.saveUserProfile(name: user.name, email: user.email);
    await prefs.saveUserData(email: user.email, password: user.password);
  }

  Future<UserModel> getUser() async {
    final email = await prefs.getEmail();
    final password = await prefs.getPassword();
    final name = await prefs.getName();

    return UserModel(name: name, email: email, password: password);
  }

  Future<bool> isRemembered() async {
    return await prefs.getRememberMe();
  }

  Future<void> setRememberMe(bool value) async {
    await prefs.saveRememberMe(rememberMe: value);
  }
}
