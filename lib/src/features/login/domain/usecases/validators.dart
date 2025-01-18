class AuthHelpers {
  String? validatePassword(String password) {
    if (password.isEmpty) {
      return "Password cannot be empty";
    }

    if (password.length < 6) {
      return "Password length must be atleast 6 characters";
    }

    if (!password.contains(RegExp(r'[A-Z]'))) {
      return "Uppercase letter missing";
    }

    if (!password.contains(RegExp(r'[a-z]'))) {
      return "Lowercase letter missing";
    }

    return null;
  }

  isUsernameValid(String username) {
    if (username.isEmpty) {
      return "Username cannot be empty";
    }
    if (username.length < 5) {
      return "Username length must be atleast 4 characters";
    }

    return null;
  }
}
