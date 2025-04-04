// ignore_for_file: constant_identifier_names, unused_import

import 'package:flutter/material.dart';

enum EducationStatus {
  University,            // 🏫
  
  InCollege,             // 🎓
  JustGraduated,         // 🎉
  // GettingBackIntoEducation, // 🔄
  WorkingAndStudying,    // 💼📚
  PostgradDegree,        // 🎓
  // GapYear,               // 🌍
}

class UserEducationStatus {
  const UserEducationStatus(this.title, this.emoji);

  final String title;
  final String emoji;
}