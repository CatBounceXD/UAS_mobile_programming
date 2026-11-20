import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String name;
  final String gender;
  final DateTime dob; // Tanggal lahir
  final List<String> photos; // Minimal 4, maksimal 6
  final bool isVerified;
  
  final List<String> interests; // Max 5
  final String favInterest; // 1 dari 5 interest
  final List<String> causes; 
  final List<String> qualities; // Max 3
  
  // Tipe List of Map untuk menampung Prompt (Section, Question, Answer)
  final List<Map<String, String>> prompts; 
  
  final String bio;
  
  // Map untuk About You
  final Map<String, dynamic> aboutYou; 
  
  // Map untuk More About You
  final Map<String, dynamic> moreAboutYou;
  
  final List<String> languages;

  UserModel({
    required this.uid,
    required this.name,
    required this.gender,
    required this.dob,
    required this.photos,
    this.isVerified = false,
    this.interests = const [],
    this.favInterest = '',
    this.causes = const [],
    this.qualities = const [],
    this.prompts = const [],
    this.bio = '',
    this.aboutYou = const {},
    this.moreAboutYou = const {},
    this.languages = const [],
  });

  factory UserModel.fromJson(Map<String, dynamic> json, String id) {
    return UserModel(
      uid: id,
      name: json['name'],
      gender: json['gender'],
      dob: (json['dob'] as Timestamp?)?.toDate() ?? DateTime.now(),
      photos: List<String>.from(json['photos']),
      isVerified: json['isVerified'] ?? false,
      interests: List<String>.from(json['interests'] ?? []),
      favInterest: json['favInterest'] ?? '',
      causes: List<String>.from(json['causes'] ?? []),
      qualities: List<String>.from(json['qualities'] ?? []),
      prompts: (json['prompts'] as List<dynamic>?)?.map((p) => Map<String, String>.from(p)).toList() ?? [],
      bio: json['bio'] ?? '',
      aboutYou: Map<String, dynamic>.from(json['aboutYou'] ?? {}),
      moreAboutYou: Map<String, dynamic>.from(json['moreAboutYou'] ?? {}),
      languages: List<String>.from(json['languages'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'gender': gender,
      'dob': Timestamp.fromDate(dob),
      'photos': photos,
      'isVerified': isVerified,
      'interests': interests,
      'favInterest': favInterest,
      'causes': causes,
      'qualities': qualities,
      'prompts': prompts,
      'bio': bio,
      'aboutYou': aboutYou,
      'moreAboutYou': moreAboutYou,
      'languages': languages,
    };
  }
}