class Validator {
  static String? validateField(
      String? value,
      String fieldType, {
        String? password,
      }) {
    if (value == null || value.trim().isEmpty) {
      return _getEmptyMessage(fieldType);
    }

    switch (fieldType) {
      case 'name':
        if (value.length < 3) {
          return 'Name must be at least 3 characters';
        }
        if (!RegExp(r'^[a-zA-Z0-9\u0600-\u06FF\s]+$').hasMatch(value)) {
          return 'Name can contain only Arabic or English letters and numbers';
        }
        break;

      case 'email':
        if (!RegExp(
          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
        ).hasMatch(value)) {
          return 'Enter a valid email address';
        }
        break;

      case 'password':
      case 'new password':
        if (value.length < 8) {
          return 'Password must be at least 8 characters long';
        }

        if (!RegExp(r'[A-Z]').hasMatch(value)) {
          return 'Password must contain at least one uppercase letter';
        }

        if (!RegExp(r'[a-z]').hasMatch(value)) {
          return 'Password must contain at least one lowercase letter';
        }

        if (!RegExp(r'\d').hasMatch(value)) {
          return 'Password must contain at least one number';
        }

        break;

      case 'old password':
        if (password == null || value != password) {
          return 'Old password is incorrect';
        }
        break;

      case 'confirmPassword':
        if (password == null) {
          return 'Password is missing';
        }
        if (value != password) {
          return 'Passwords do not match';
        }
        break;

      case 'phone':
        if (!RegExp(r'^01\d{9}$').hasMatch(value)) {
          return 'Phone number must start with 01 and be 11 digits';
        }
        break;

      case 'address':
        if (value.length < 5) {
          return 'Address must be at least 5 characters long';
        }
        break;

      case 'bio':
        if (value.length > 150) {
          return 'Bio must not exceed 150 characters';
        }
        break;

      case 'login email':
      case 'login password':
        break;
    }

    return null;
  }

  static String _getEmptyMessage(String fieldType) {
    return 'Please enter your $fieldType';
  }
}