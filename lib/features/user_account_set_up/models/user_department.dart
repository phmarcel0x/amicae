// ignore_for_file: constant_identifier_names, unused_import

import 'package:flutter/material.dart';

// Define departments within the university
enum UserDepartment {
  FacultyOfArtsAndScience,       // 🎨📚
  JohnMolsonSchoolOfBusiness,    // 💼
  GinaCodySchoolOfEngineeringAndComputerScience, // 💻🔧
  FacultyOfFineArts,             // 🎭🎨
}

// Class representing department details
class UserDepartmentDetails {
  const UserDepartmentDetails(this.title, this.emoji);

  final String title;
  final String emoji;
}