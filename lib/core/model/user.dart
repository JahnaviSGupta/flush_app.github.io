import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';

class User with ChangeNotifier {
  String email;

  String firstName;

  String lastName;

  UserSettings settings;

  String phoneNumber;

  bool active;

  String favoriteBathroom;

  int lastOnlineTimestamp;

  String userID;

  String profilePictureURL;

  bool selected = false;

  String pushToken;

  String appIdentifier;

  User(
      {this.email = '',
      this.firstName = '',
      this.phoneNumber = '',
      this.lastName = '',
      this.favoriteBathroom ='',
      this.active = false,
      lastOnlineTimestamp,
      appIdentifier,
      settings,
      this.pushToken = '',
      this.userID = '',
      this.profilePictureURL = ''})
      : lastOnlineTimestamp = lastOnlineTimestamp is int
            ? lastOnlineTimestamp
            : Timestamp.now().seconds,
        settings = settings ?? UserSettings(),
        appIdentifier =
            appIdentifier ?? 'Instaflutter ${Platform.operatingSystem}';

  String fullName() {
    return '$firstName ';
  }

String myBathroom() {
    return '$lastName';
  }



  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return User(
        email: parsedJson['email'] ?? '',
        firstName: parsedJson['firstName'] ?? '',
        favoriteBathroom: parsedJson['favoriteBathroom'] ?? '',
        lastName: parsedJson['lastName'] ?? '',
        active: parsedJson['active'] ?? false,
        lastOnlineTimestamp: parsedJson['lastOnlineTimestamp'] is Timestamp
            ? (parsedJson['lastOnlineTimestamp'] as Timestamp).seconds
            : parsedJson['lastOnlineTimestamp'],
        settings: parsedJson.containsKey('settings')
            ? UserSettings.fromJson(parsedJson['settings'])
            : UserSettings(),
        phoneNumber: parsedJson['phoneNumber'] ?? '',
        pushToken: parsedJson['pushToken'] ?? '',
        userID: parsedJson['id'] ?? parsedJson['userID'] ?? '',
        profilePictureURL: parsedJson['profilePictureURL'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'settings': settings.toJson(),
      'phoneNumber': phoneNumber,
      'id': userID,
      'favoriteBathroom': favoriteBathroom,
      'userID': userID,
      'active': active,
      'lastOnlineTimestamp': lastOnlineTimestamp,
      'pushToken': pushToken,
      'profilePictureURL': profilePictureURL,
      'appIdentifier': appIdentifier
    };
  }
}

class UserSettings {
  bool allowPushNotifications;

  UserSettings({this.allowPushNotifications = true});

  factory UserSettings.fromJson(Map<dynamic, dynamic> parsedJson) {
    return UserSettings(
        allowPushNotifications: parsedJson['allowPushNotifications'] ?? true);
  }

  Map<String, dynamic> toJson() {
    return {'allowPushNotifications': allowPushNotifications};
  }
}
