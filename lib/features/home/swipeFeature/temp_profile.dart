class Profile {
  // attributes
  late String _id;
  late String _firstName;
  late String _avatarUrl;
  late String _department;
  late String _educationStatus;
  late String _description;
  late String _lookingFor;
  late List<String> _coursesCodes;
  late List<String> _interests;

  // constructors
  Profile.d() {
    // default constructor
    _id = '';
    _firstName = 'User';
    _avatarUrl = "assets/blank_pfp.png";
    _department = 'Undecided';
    _educationStatus = 'Undergraduate';
    _description = '';
    _lookingFor = '';
    _coursesCodes = [];
    _interests = [];
  }

  Profile({
    required String id,
    required String firstName,
    String? avatarUrl,
    required String department,
    required String educationStatus,
    required String description,
    required String lookingFor,
    required List<String> coursesCodes,
    required List<String> interests,
  }) {
    _id = id;
    _firstName = firstName;
    _avatarUrl = avatarUrl ?? "assets/blank_pfp.png";
    _department = department;
    _educationStatus = educationStatus;
    _description = description;
    _lookingFor = lookingFor;
    _coursesCodes = coursesCodes;
    _interests = interests;
  }

  // Factory constructor from Firebase data
  factory Profile.fromFirebase(Map<String, dynamic> data) {
    return Profile(
      id: data['id'] as String,
      firstName: data['firstName'] as String,
      avatarUrl: data['avatarUrl'] as String?,
      department: data['department'] as String,
      educationStatus: data['educationStatus'] as String,
      description: data['description'] as String,
      lookingFor: data['lookingFor'] as String,
      coursesCodes: _convertToStringList(data['coursesCodes']),
      interests: _convertToStringList(data['interests']),
    );
  }

  // Helper method to convert dynamic lists to List<String>
  static List<String> _convertToStringList(dynamic list) {
    if (list == null) return [];
    if (list is List) {
      return list.map((item) => item.toString()).toList();
    }
    return [];
  }

  //getters
  String getId() => _id;
  String getName() => _firstName;
  String getAvatarSource() => _avatarUrl;
  String getDepartment() => _department;
  String getEducationStatus() => _educationStatus;
  String getBio() => _description;
  String getLookingFor() => _lookingFor;
  List<String> getCourses() => List<String>.from(_coursesCodes);
  List<String> getInterests() => List<String>.from(_interests);
}
