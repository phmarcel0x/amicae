enum UserErrors {
  maxChangesExceeded(
      "The limit of changes permitted to change the parameter has been reached.");

  const UserErrors(this.message);

  final String message;
}
