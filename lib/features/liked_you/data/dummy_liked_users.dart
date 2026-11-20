import 'package:flutter/material.dart';

import '../models/liked_user_model.dart';

const Color kBumbleYellow = Color.fromARGB(255, 236, 141, 225);
const Color kDarkText = Color(0xFF1E1E1E);

final List<LikedUserModel> dummyLikedUsers = [
  const LikedUserModel(
    id: 'usr_01',
    name: 'Laudy',
    age: 22,
    occupation: 'Graphic Designer',
    bio: 'Suka kopi susu, thrift shopping, dan nonton film indie di akhir pekan.',
    likedAgo: 'Baru saja',
    distanceKm: 3,
    isVerified: true,
  ),
  const LikedUserModel(
    id: 'usr_02',
    name: 'Apip',
    age: 24,
    occupation: 'Product Analyst',
    bio: 'Lari pagi setiap Sabtu, hobi masak pasta, dan cari teman ngobrol seru.',
    likedAgo: '1j lalu',
    distanceKm: 5,
    isVerified: true,
  ),
  const LikedUserModel(
    id: 'usr_03',
    name: 'Sekar',
    age: 21,
    occupation: 'Architecture Student',
    bio: 'Pecinta pameran seni, matcha latte, dan foto analog.',
    likedAgo: '2j lalu',
    distanceKm: 8,
    isVerified: false,
  ),
  const LikedUserModel(
    id: 'usr_04',
    name: 'Steven',
    age: 23,
    occupation: 'Frontend Developer',
    bio: 'Ngoding santai malam hari, suka kuliner kaki lima, dan jalan-jalan.',
    likedAgo: '4j lalu',
    distanceKm: 4,
    isVerified: true,
  ),
  const LikedUserModel(
    id: 'usr_05',
    name: 'Syafiqa',
    age: 22,
    occupation: 'Content Creator',
    bio: 'Selalu siap untuk brunch dadakan dan playlist akustik.',
    likedAgo: 'Kemarin',
    distanceKm: 12,
    isVerified: true,
  ),
  const LikedUserModel(
    id: 'usr_06',
    name: 'Bariq',
    age: 25,
    occupation: 'Photographer',
    bio: 'Berburu golden hour dan spot makan enak di sekitar kota.',
    likedAgo: 'Kemarin',
    distanceKm: 2,
    isVerified: false,
  ),
];
