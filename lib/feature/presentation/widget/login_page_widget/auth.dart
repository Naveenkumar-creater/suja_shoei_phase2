import 'package:flutter/material.dart';
import 'package:suja_shoie_app/feature/presentation/api_services/login_api%20.dart';

class Auth extends StatefulWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final GlobalKey<FormState> signinFormKey = GlobalKey<FormState>();
  final LoginApiService loginScreen = LoginApiService();
  final FocusNode firstTextFieldFocus = FocusNode();
  final FocusNode secondTextFieldFocus = FocusNode();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool isButttonVisible = true;
  bool isLoading = false;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void logInUser() async {
    setState(() {
      isLoading = true;
      isButttonVisible = false;
    });

    try {
      await loginScreen.login(
        context: context,
        loginId: emailController.text,
        password: passwordController.text,
      );
    } catch (error) {
      print('Error: $error'); // Print the error for debugging purposes
      setState(() {
        isLoading = false;
        isButttonVisible = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: signinFormKey,
      child: Padding(
        padding: const EdgeInsets.only(top: 78, left: 25, right: 25),
        child: Column(
          children: [
            TextFormField(
              focusNode: firstTextFieldFocus,
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(secondTextFieldFocus);
              },
              controller: emailController,
              style: const TextStyle(color: Colors.black),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter EmployeId';
                }
                if (value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                  return 'Email/Phone cannot contain special symbols';
                }
                if (value.contains(' ')) {
                  return 'Email/Phone cannot contain spaces';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: 'Enter Employee Id',
                hintStyle: const TextStyle(color: Colors.black45),
                filled: true,
                fillColor: Colors.white,
                labelStyle: const TextStyle(fontSize: 12),
                contentPadding: const EdgeInsets.only(left: 30),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey.shade50),
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey.shade50),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            const SizedBox(height: 30),
            TextFormField(
              focusNode: secondTextFieldFocus,
              onFieldSubmitted: (value) {
                if (signinFormKey.currentState?.validate() == true) {
                  logInUser();
                }
              },
              controller: passwordController,
              style: const TextStyle(color: Colors.black),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter password';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: 'Password',
                hintStyle: const TextStyle(color: Colors.black45),
                counterText: 'Forgot password?',
                counterStyle:
                    const TextStyle(color: Color(0xFF25476A), fontSize: 13),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                  child: Icon(
                    _obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons
                            .visibility_outlined, // Toggle the visibility icon
                    color: const Color(0xFF25476A),
                  ),
                ),
                filled: true,
                fillColor: Colors.white,
                labelStyle: const TextStyle(fontSize: 12),
                contentPadding: const EdgeInsets.only(left: 30),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey.shade50),
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
              obscureText: _obscurePassword, // Toggle password visibility
            ),
            const SizedBox(height: 40),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    if (signinFormKey.currentState?.validate() == true) {
                      setState(() {
                        isButttonVisible = false;
                        isLoading = true;
                      });
                      logInUser();
                    }
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: const Color(0xFF25476A),
                        borderRadius: BorderRadiusDirectional.circular(5)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (isButttonVisible)
                          const Text(
                            'Sign In',
                            style: TextStyle(color: Colors.white),
                          ),
                        if (isLoading) const CircularProgressIndicator()
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
