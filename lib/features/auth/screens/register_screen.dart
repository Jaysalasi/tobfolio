import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tob/core/utils/components/app_button.dart';
import 'package:tob/core/utils/components/app_text_field.dart';
import 'package:tob/core/utils/constants/assets/svg.dart';
import '../bloc/auth_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  bool rememberMe = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _register() {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      context.read<AuthBloc>().add(
        RegisterRequested(
          name: _nameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text,
          passwordConfirmation: _confirmPasswordController.text,
        ),
      );
    }
  }

  void _showError(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      // appBar: AppBar(
      //   title: const Text('Sign Up'),
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      // ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.loading) {
            setState(() => _isLoading = true);
          } else {
            setState(() => _isLoading = false);

            if (state.status == AuthStatus.error &&
                state.errorMessage != null) {
              _showError(state.errorMessage!);
            } else if (state.status == AuthStatus.authenticated) {
              Navigator.of(context).pushReplacementNamed('/dashboard');
            }
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 150),

                Text(
                  'Create Account',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
                // const SizedBox(height: 8),
                Text(
                  'Enter your details to create your account',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                AppTextField(
                  label: "Email",
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  hint: "Enter email",

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    ).hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                AppTextField(
                  label: "Password",
                  controller: _passwordController,
                  hint: "Enter password",
                  obscureText: true,
                ),

                const SizedBox(height: 50),

                AppButton(
                  title: "Next",
                  isLoading: _isLoading,
                  isActive: true,
                  onPressed: () {
                    _register();
                  },
                ),

                const SizedBox(height: 24),
                Text(
                  'Or sign up with',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: SvgPicture.asset(SvgAssets.google),
                    ),
                    SizedBox(width: 20),
                    GestureDetector(
                      onTap: () {},
                      child: SvgPicture.asset(SvgAssets.apple),
                    ),
                    SizedBox(width: 20),
                    GestureDetector(
                      onTap: () {},
                      child: SvgPicture.asset(SvgAssets.twitter),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account?',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/login');
                      },
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Center(
                  child: Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      children: [
                        TextSpan(text: "By signing up, you agree to the "),
                        TextSpan(
                          onEnter: (event) {},
                          text: "Terms of Service and Privacy Policy",
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
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
