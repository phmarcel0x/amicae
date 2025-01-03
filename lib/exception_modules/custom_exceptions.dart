// Creation of a custom class exception for the mumber of times the
// parameters cannot change 
class maxChangeExceeded implements Exception {
  String? exceptionMsg() => "The limit of changes permitted to change the parameter has been reached.";
}
