import 'dart:async';

import 'package:flashcard_forge_app/models/UserModel.dart';
import 'package:flashcard_forge_app/services/contracts/contracts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository implements AuthRepositoryContract {
  @override
  Future<UserModel?> authenticate(String accessToken) async {
    try {
      await Future.delayed(const Duration(seconds: 3));

      final user = UserModel(
        id: 33223,
        email: "lucasviniciuss529@gmail.com",
        googleId: "313256374856968079545347",
        isActive: true,
        name: "Lucas Vinícius",
        picture: "https://lh3.googleusercontent.com/a/ACg8ocIdCdv7VDIv5YEseXtHKe3LMgBwwXHpaV3w5S7F-iYB8sozsWPXOw=s288-c-no"
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('id', user.id!);
      await prefs.setString('email', user.email!);
      await prefs.setString('googleId', user.googleId!);
      await prefs.setBool('isActive', user.isActive!);
      await prefs.setString('name', user.name!);
      await prefs.setString('picture', user.picture!);

      return user;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<UserModel?> getStoredUser() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt('user_id');
    final email = prefs.getString('user_email');
    final googleId = prefs.getString('user_googleId');
    final isActive = prefs.getBool('user_isActive');
    final name = prefs.getString('user_name');
    final picture = prefs.getString('user_picture');

    if (id != null && email != null && googleId != null && isActive != null && name != null && picture != null) {
      return UserModel(
        id: id,
        email: email,
        googleId: googleId,
        isActive: isActive,
        name: name,
        picture: picture,
      );
    }
    return null;
  }
}
