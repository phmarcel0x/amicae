import '../models/user_edu_status.dart';

const educationStatusMap = {
  EducationStatus.University: UserEducationStatus('University', '🏫'),
  EducationStatus.InCollege: UserEducationStatus('In College', '🎓'),
  EducationStatus.JustGraduated: UserEducationStatus('Just Graduated', '🎉'),
  // EducationStatus.GettingBackIntoEducation: UserEducationStatus('Getting Back Into Education', '🔄'),
  EducationStatus.WorkingAndStudying: UserEducationStatus('Working And Studying', '💼📚'),
  EducationStatus.PostgradDegree: UserEducationStatus('Postgrad Degree', '🎓'),
  // EducationStatus.GapYear: UserEducationStatus('Gap Year', '🌍'),
};