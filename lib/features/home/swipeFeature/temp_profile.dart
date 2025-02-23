class Profile {
  // attributes
  late int _iD;
  late String _name;
  late String _avatarSource;
  late String _major;
  late List<String> _classes;
  late List<String> _skills;
  late String _bio;

  // constructors

  Profile.d() {
    // default constructor
    _iD = 0;
    _name = 'user';
    _avatarSource = "assets/logo/full_logo_light.png";
    _major = 'student';
    _classes = [];
    _skills = [];
    _bio = '';
  }

  Profile({
    // constructor taking every arguments
    required int iD,
    required String name,
    required String imgSource,
    required String major,
    required List<String> classes,
    required List<String> skills,
    required String bio,
  }) {
    _iD = iD;
    _name = name;
    _avatarSource = imgSource;
    _major = major;
    _classes = classes;
    _skills = skills;
    _bio = bio;
  }

  //getters

  int getId() {
    return _iD;
  }

  String getName() {
    return _name;
  }

  String getAvatarSource() {
    return _avatarSource;
  }

  String getMajor() {
    return _major;
  }

  List<String> getClasses() {
    return List<String>.from(_classes);
  }

  List<String> getSkills() {
    return List<String>.from(_skills);
  }

  String getBio() {
    return _bio;
  }
}
