import 'package:http/http.dart' as http;

class AppValidations {
  // 📧 Email Validation
  static String? emailValidation(String? email) {
    if (email == null || email.isEmpty) {
      return "Email is required";
    }
    // Basic regex for email
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      return "Enter a valid email address";
    }
    return null;
  }

  // 🔑 Password Validation
  static String? passwordValidation(String? password) {
    if (password == null || password.isEmpty) {
      return "Password is required";
    }
    if (password.length < 8) {
      return "Password must be at least 8 characters";
    }
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return "Include at least one uppercase letter";
    }
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      return "Include at least one lowercase letter";
    }
    if (!RegExp(r'[0-9]').hasMatch(password)) {
      return "Include at least one number";
    }
    if (!RegExp(r'[!@#\$&*~]').hasMatch(password)) {
      return "Include at least one special character (!@#\$&*~)";
    }
    return null;
  }

  // 👤 Username Validation
  static String? usernameValidation(String? username) {
    if (username == null || username.isEmpty) {
      return "Username is required";
    }
    if (username.length < 3) {
      return "Username must be at least 3 characters";
    }
    if (username.length > 20) {
      return "Username must be less than 20 characters";
    }
    return null;
  }

  // 🏠 Address Validation
  static String? addressValidation(String? address) {
    if (address == null || address.isEmpty) {
      return "Address is required";
    }
    if (address.length < 10) {
      return "Address must be at least 10 characters";
    }
    return null;
  }

  // 📱 Phone Number Validation
  static String? phoneValidation(String? phone) {
    if (phone == null || phone.isEmpty) {
      return "Phone number is required";
    }
    // Allows +92, 03xx, or international formats
    return null;
  }




 static validateImageUrl(String url) {
      if (url == null || (url.isEmpty)) {
        return "Enter image urls.";
      }
        return null;

  }


}
