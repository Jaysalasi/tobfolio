import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tobfolio/core/utils/components/app_button.dart';
import 'package:tobfolio/core/utils/components/app_check_box.dart';
import 'package:tobfolio/core/utils/components/app_text_field.dart';
import 'package:tobfolio/core/utils/constants/assets/svg.dart';
import 'package:tobfolio/core/utils/toasts.dart';
import '../bloc/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  // bool _obscurePassword = true;
  bool _isLoading = false;
  bool rememberMe = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      context.read<LoginBloc>().add(
        LoginSubmitted(
          email: _emailController.text.toLowerCase().trim(),
          password: _passwordController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      // appBar: AppBar(
      //   title: const Text('Login'),
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      // ),
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.status == LoginStatus.loading) {
            setState(() => _isLoading = true);
          } else {
            setState(() => _isLoading = false);

            if (state.status == LoginStatus.failure &&
                state.errorMessage != null) {
              showError(state.errorMessage!);
            } else if (state.status == LoginStatus.success) {
              showSuccess('Login successful!');
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
                const SizedBox(height: 100),

                Text(
                  'Welcome Back!',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
                // const SizedBox(height: 8),
                Text(
                  'Sign in to continue to your account',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                AppTextField(
                  label: "Email",
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  hint: "divine@tobfolio.com",

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
                const SizedBox(height: 30),
                AppTextField(
                  label: "Password",
                  controller: _passwordController,
                  hint: "Enter password",
                  obscureText: true,
                ),

                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        AppCheckbox(
                          value: rememberMe,
                          onChanged: (val) {
                            setState(() {
                              rememberMe = val!;
                            });
                          },
                        ),

                        Text("Remember me"),
                      ],
                    ),
                    Spacer(),

                    GestureDetector(
                      onTap: () {
                         Navigator.of(context).pushNamed('/forgot-password');
                      },
                      child: Text("Forgot password?"),
                    ),
                  ],
                ),

                const SizedBox(height: 50),

                AppButton(
                  title: "Next",
                  isLoading: _isLoading,
                  isActive: true,
                  onPressed: () {
                    // Navigator.popAndPushNamed(context, "/dashboard");
                    _login();
                  },
                ),

                const SizedBox(height: 24),
                Text(
                  'Or sign in with',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.read<LoginBloc>().add(const GoogleSignInSubmitted());
                      },
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
                        Navigator.of(context).pushReplacementNamed('/register');
                      },
                      child: Text(
                        'Sign Up',
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
                        TextSpan(text: "By signing in, you agree to the "),
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
