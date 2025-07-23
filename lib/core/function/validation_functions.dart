String? validateName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your full name';
  }
  return null;
}

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your email';
  }
  final emailRegex = RegExp(r'^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
  if (!emailRegex.hasMatch(value)) {
    return 'Please enter a valid email';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a password';
  }
  if (value.length < 8) {
    return 'Password must be at least 8 characters';
  }
  return null;
}

String? validateDOB(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your date of birth';
  }
  return null;
}

String? validatePhone(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your phone number';
  }
  final pattern = RegExp(r'^(078|077|079)\d{7}$');
  if (!pattern.hasMatch(value)) {
    return 'Phone number must start with 078, 077, or 079 and be 10 digits';
  }
  return null;
}
