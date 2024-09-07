import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  String _password = '';
  String _confirmPassword = '';
  bool _obscureOldPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;
  bool _hasUppercase = false;
  bool _hasLowercase = false;
  bool _hasNumber = false;
  bool _hasMinLength = false;
  bool _hasSpecialCharacter = false;
  bool _passwordsMatch = false;

  void _toggleOldPasswordVisibility() {
    setState(() {
      _obscureOldPassword = !_obscureOldPassword;
    });
  }

  void _toggleNewPasswordVisibility() {
    setState(() {
      _obscureNewPassword = !_obscureNewPassword;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _obscureConfirmPassword = !_obscureConfirmPassword;
    });
  }


  void _checkPassword(String password) {
    setState(() {
      _password = password;
      _hasUppercase = password.contains(RegExp(r'[A-Z]'));
      _hasLowercase = password.contains(RegExp(r'[a-z]'));
      _hasNumber = password.contains(RegExp(r'[0-9]'));
      _hasMinLength = password.length >= 8;
      _hasSpecialCharacter =
          password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
      _checkPasswordsMatch(_confirmPassword);
    });
  }
  void _checkPasswordsMatch(String confirmPassword) {
    setState(() {
      _confirmPassword = confirmPassword;
      _passwordsMatch = _password == _confirmPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        backgroundColor: const Color(0xffffffff),
        leading: const Icon(Icons.arrow_back, size: 22.0),
        title: const Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Text(
            'Change Password',
            style: TextStyle(
              fontSize: 16.0,
              color: Color(0xff000000),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Change Password',
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Color(0xff000000),
                  ),
                ),
                TextFormField(
                  obscureText: _obscureOldPassword,
                  decoration: InputDecoration(
                    labelText: 'Old Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureOldPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed:
                          _toggleOldPasswordVisibility, // Toggle visibility
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Enter New Password',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Color(0xff000000),
                  ),
                ),
                TextFormField(
                  obscureText: _obscureNewPassword,
                  decoration: InputDecoration(
                    labelText: 'New Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureNewPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed:
                          _toggleNewPasswordVisibility, // Toggle visibility
                    ),
                  ),
                  onChanged: _checkPassword,
                ),
                const Text(
                  'Password Must:',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Color(0xff000000),
                  ),
                ),
                const SizedBox(height: 20.0),
                _buildPasswordCriteria(
                    'Include lowercase letter', _hasLowercase),
                _buildPasswordCriteria(
                    'Include uppercase letter', _hasUppercase),
                _buildPasswordCriteria(
                    'At least one special character', _hasSpecialCharacter),
                _buildPasswordCriteria('Include numeric character', _hasNumber),
                _buildPasswordCriteria(
                    'Minimum Password length 8 characters', _hasMinLength),
                const SizedBox(height: 20.0),
                TextFormField(
                  obscureText: _obscureConfirmPassword,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed:
                          _toggleConfirmPasswordVisibility, // Toggle visibility
                    ),
                  ),
                  onChanged: _checkPasswordsMatch,
                ),
                const SizedBox(height: 10.0),
                _buildPasswordCriteria('Passwords match', _passwordsMatch),
                const SizedBox(height: 20.0),
                Center(
                  child: ElevatedButton(
                    onPressed: _hasUppercase &&
                            _hasLowercase &&
                            _hasNumber &&
                            _hasMinLength &&
                            _hasSpecialCharacter &&
                            _passwordsMatch
                        ? () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Close'))
                                      ],
                                      title: const Text('Success'),
                                      contentPadding:
                                          const EdgeInsets.all(20.0),
                                      content: const Text(
                                          'password is strong and matches!'),
                                    ));
                            // ScaffoldMessenger.of(context)
                            //     .showSnackBar(const SnackBar(
                            //   content: Text('Password is strong and matches!',style: TextStyle(color: Colors.black),),
                            // ));
                          }
                        : null,
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildPasswordCriteria(String label, bool isValid) {
  return Row(
    children: [
      Icon(isValid ? Icons.check_circle : Icons.check_circle_outline,
          color: isValid ? Colors.green : Colors.red),
      const SizedBox(width: 10),
      Text(label),
    ],
  );
}
