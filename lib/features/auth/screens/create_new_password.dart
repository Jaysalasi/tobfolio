import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tob/core/utils/components/app_button.dart';
import 'package:tob/core/utils/components/app_text_field.dart'; 
import '../bloc/auth_bloc.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  State<CreateNewPasswordScreen> createState() => _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
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
      context.read<AuthBloc>().add(
        LoginRequested(
          email: _emailController.text.trim(),
          password: _passwordController.text,
          asRider: true,
        ),
      );
    }
  }

  void _showError(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 14.0,
    );
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
                  'Create New Password',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
                // const SizedBox(height: 8),
                Text(
                  'Create your new password',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                
                AppTextField(
                  label: "New Password",
                  controller: _passwordController,
                  hint: "Enter password",
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                AppTextField(
                  label: "Confirm Password",
                  controller: _passwordController,
                  hint: "Enter password",
                  obscureText: true,
                ),

                const SizedBox(height: 20),
                

                const SizedBox(height: 30),

                AppButton(
                  title: "Save",
                  isLoading: _isLoading,
                  isActive: true,
                  onPressed: () {
                    // _login();
                    Navigator.popUntil(context, ModalRoute.withName('/login'));
                    
                  },
                ),

                const SizedBox(height: 24),
                
                
                const SizedBox(height: 24),
                // Center(
                //   child: Text.rich(
                //     textAlign: TextAlign.center,
                //     TextSpan(
                //       children: [
                //         TextSpan(text: "By signing in, you agree to the "),
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
