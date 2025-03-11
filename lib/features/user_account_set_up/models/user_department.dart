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