import 'package:flutter/material.dart';

class UserProfile {
  String name;
  String email;
  String bloodType;
  double weight;
  String city;
  bool isMale;
  DateTime lastDonationDate;
  int totalDonations;

  UserProfile({
    required this.name,
    required this.email,
    required this.bloodType,
    required this.weight,
    required this.city,
    required this.isMale,
    required this.lastDonationDate,
    this.totalDonations = 3,
  });

  DateTime get nextDonationDate =>
      lastDonationDate.add(Duration(days: isMale ? 60 : 90));

  int get daysUntilNextDonation {
    final now = DateTime.now();
    final diff = nextDonationDate.difference(now).inDays;
    return diff > 0 ? diff : 0;
  }

  int get donationIntervalDays => isMale ? 60 : 90;

  UserProfile copyWith({
    String? name,
    String? email,
    String? bloodType,
    double? weight,
    String? city,
    bool? isMale,
    DateTime? lastDonationDate,
    int? totalDonations,
  }) {
    return UserProfile(
      name: name ?? this.name,
      email: email ?? this.email,
      bloodType: bloodType ?? this.bloodType,
      weight: weight ?? this.weight,
      city: city ?? this.city,
      isMale: isMale ?? this.isMale,
      lastDonationDate: lastDonationDate ?? this.lastDonationDate,
      totalDonations: totalDonations ?? this.totalDonations,
    );
  }
}

class UserSession extends ChangeNotifier {
  static final UserSession instance = UserSession._();
  UserSession._();

  UserProfile profile = UserProfile(
    name: 'Letícia',
    email: 'leticia@email.com',
    bloodType: 'O+',
    weight: 62.0,
    city: 'João Pessoa',
    isMale: false,
    lastDonationDate: DateTime.now().subtract(const Duration(days: 77)),
    totalDonations: 3,
  );

  void updateProfile({
    String? name,
    String? email,
    String? bloodType,
    double? weight,
    String? city,
    bool? isMale,
  }) {
    profile = profile.copyWith(
      name: name,
      email: email,
      bloodType: bloodType,
      weight: weight,
      city: city,
      isMale: isMale,
    );
    notifyListeners();
  }

  void registerDonation() {
    profile = profile.copyWith(
      lastDonationDate: DateTime.now(),
      totalDonations: profile.totalDonations + 1,
    );
    notifyListeners();
  }
}
