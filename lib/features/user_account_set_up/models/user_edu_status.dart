import 'package:flutter/material.dart';

enum EducationStatus {
  InCollege,             // 🎓
  University,            // 🏫
  JustGraduated,         // 🎉
  GettingBackIntoEducation, // 🔄
  WorkingAndStudying,    // 💼📚
  PostgradDegree,        // 🎓
  GapYear,               // 🌍
}

class UserEducationStatus {
  const UserEducationStatus(this.title, this.emoji);

  final String title;
  final String emoji;
}