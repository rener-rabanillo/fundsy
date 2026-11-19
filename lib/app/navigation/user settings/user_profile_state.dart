import 'dart:io';
import 'package:flutter/foundation.dart';

class UserProfileData {
  final String name;
  final String email;
  final File? image;

  const UserProfileData({
    required this.name,
    required this.email,
    this.image,
  });

  UserProfileData copyWith({
    String? name,
    String? email,
    File? image,
    bool clearImage = false,
  }) {
    return UserProfileData(
      name: name ?? this.name,
      email: email ?? this.email,
      image: clearImage ? null : (image ?? this.image),
    );
  }
}

class UserProfileState {
  static final ValueNotifier<UserProfileData> notifier = ValueNotifier(
    const UserProfileData(
      name: 'John Doe',
      email: 'john.doe@example.com',
    ),
  );
}