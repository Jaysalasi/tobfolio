import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tob/core/utils/components/app_button.dart';
import 'package:tob/core/utils/components/app_text_field.dart';
import '../bloc/auth_bloc.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
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
                const SizedBox(height: 200),

                Text(
                  'Forgot Password',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
                // const SizedBox(height: 8),
                Text(
                  'Don’t worry, fill in your email and we’ll send you a link to reset your password',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                AppTextField(
                  label: "Email or Phone number",
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
                  
                const SizedBox(height: 50),

                AppButton(
                  title: "Next",
                  isLoading: _isLoading,
                  isActive: true,
                  onPressed: () {
                    Navigator.pushNamed(context, "/create-new-password");
                  },
                ),

                const SizedBox(height: 24),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Back to Login',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                // const SizedBox(height: 24),
                
                // const SizedBox(height: 24),
                
                // const SizedBox(height: 24),
                // Center(
                //   child: Text.rich(
                //     textAlign: TextAlign.center,
                //     TextSpan(
                //       children: [
                //         TextSpan(text: "By signing up, you agree to the "),
                //         TextSpan(
                //           onEnter: (event) {},
                //           text: "Terms of Service and Privacy Policy",
                //           style: Theme.of(context).textTheme.bodyMedium!
                //               .copyWith(fontWeight: FontWeight.bold),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
