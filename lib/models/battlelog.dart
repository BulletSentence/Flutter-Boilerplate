import 'package:flutter/foundation.dart';

class Battlelog {
  final String name;
  final String profileUrl;
  final String platform;
  final String kills;
  final String deaths;

  const Battlelog({
    required this.profileUrl,
    required this.deaths,
    required this.kills,
    required this.name,
    required this.platform,
  });

  factory Battlelog.fromJson(Map<String, dynamic> json) {
    return Battlelog(
      platform: json['data']['platformInfo']['platformSlug'],
      name: json['data']['platformInfo']['platformUserIdentifier'],
      kills: json['data']['segments'][0]['stats']['kills']['displayValue'],
      deaths: json['data']['segments'][0]['stats']['deaths']['displayValue'],
      profileUrl: json['data']['platformInfo']['avatarUrl'],
    );
  }
}