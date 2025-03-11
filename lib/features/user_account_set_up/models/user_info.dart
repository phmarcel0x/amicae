import '../models/user_interest.dart';
import '../models/user_edu_status.dart';
import '../models/user_department.dart';
import '../models/user_courses_code.dart';

class UserInfo {
  const UserInfo({
    required this.id,
    required this.firstName,
    required this.description,
    required this.lookingFor,
    required this.interest,
    required this.department,
    required this.coursesCode,
    required this.educationStatus
  });

  final String id;
  final String firstName;
  final String description;
  final String lookingFor;
  final UserInterest interest;
  final UserEducationStatus educationStatus;
  final UserDepartment department;
  final UserCoursesCode coursesCode;
}