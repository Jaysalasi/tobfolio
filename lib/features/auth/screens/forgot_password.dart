import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tobfolio/core/utils/components/app_button.dart';
import 'package:tobfolio/core/utils/components/app_text_field.dart';
import 'package:tobfolio/core/utils/toasts.dart';
import 'package:tobfolio/features/auth/bloc/forgot_password_bloc.dart';
import 'package:tobfolio/features/auth/bloc/forgot_password_event.dart';
import 'package:tobfolio/features/auth/bloc/forgot_password_state.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
     _emailController.dispose();
    super.dispose();
  }

  void forgotPassword() {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      context.read<ForgotPasswordBloc>().add(
        ForgotPasswordSubmitted(
          email: _emailController.text.trim(),
        ),
      );
    }
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
      body: BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
        listener: (context, state) {
          if (state.status == ForgotPasswordStatus.loading) {
            setState(() => _isLoading = true);
          } else {
            setState(() => _isLoading = false);

            if (state.status == ForgotPasswordStatus.failure &&
                state.errorMsg != null) {
              showError(state.errorMsg!);
            } else if (state.status == ForgotPasswordStatus.success) {
              showSuccess(state.forgotPasswordResponse!.message);
              Navigator.of(context).pushReplacementNamed('/login');
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
                    forgotPassword();
                    // Navigator.pushNamed(context, "/create-new-password");
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
