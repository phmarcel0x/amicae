class Profile {
  const Profile({
    required this.id,
    required this.firstName,
    required this.department,
    required this.description,
    required this.educationStatus,
    required this.coursesCodes,
    required this.interests,
    required this.createdAt,
    required this.lastUpdated,
  });

  final String id;
  final String firstName;
  final String department;
  final String description;
  final String educationStatus;
  final List<String> coursesCodes;
  final List<String> interests;
  final int createdAt;
  final int lastUpdated;

  Profile copyWith({
    String? id,
    String? firstName,
    String? department,
    String? description,
    String? educationStatus,
    List<String>? coursesCodes,
    List<String>? interests,
    int? createdAt,
    int? lastUpdated,
  }) {
    return Profile(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      department: department ?? this.department,
      description: description ?? this.description,
      educationStatus: educationStatus ?? this.educationStatus,
      coursesCodes: coursesCodes ?? this.coursesCodes,
      interests: interests ?? this.interests,
      createdAt: createdAt ?? this.createdAt,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      department: json['department'] as String,
      description: json['description'] as String,
      educationStatus: json['educationStatus'] as String,
      coursesCodes: List<String>.from(json['coursesCodes'] as List),
      interests: List<String>.from(json['interests'] as List),
      createdAt: json['createdAt'] as int,
      lastUpdated: json['lastUpdated'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'department': department,
      'description': description,
      'educationStatus': educationStatus,
      'coursesCodes': coursesCodes,
      'interests': interests,
      'createdAt': createdAt,
      'lastUpdated': lastUpdated,
    };
  }
}
