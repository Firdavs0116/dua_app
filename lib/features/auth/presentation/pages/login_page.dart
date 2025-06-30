import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_dua_app/core/constants/app_colors.dart';
import 'package:my_dua_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:my_dua_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_dua_app/features/auth/presentation/pages/forgot_password.dart';
import 'package:my_dua_app/features/auth/presentation/pages/register_page.dart';
import 'package:my_dua_app/features/language/presentation/widgets/language_selector_with_flags.dart';

class LoginPage extends StatelessWidget {
  final void Function(Locale locale) onLocaleChange;
  final void Function(bool value) onThemeToggle;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  LoginPage({
    super.key,
    required this.onLocaleChange,
    required this.onThemeToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        // title: Text(AppLocalizations.of(context)!.login),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: LanguageSelectorWithFlags(onLocaleChanged: onLocaleChange),
          ),
        ],
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formkey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                Text(
                  AppLocalizations.of(context)!.welcomeBack,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF223E7F),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),

                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.email, // Email
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(
                        context,
                      )!.enterYourEmail; // Enter your email address
                    } else if (!emailRegex.hasMatch(value)) {
                      return AppLocalizations.of(
                        context,
                      )!.wrongEmailTryAgain; // Wrong Email address
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText:
                        AppLocalizations.of(context)!.password, // Password
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(
                        context,
                      )!.enterYourPassword; // Enter your password
                    } else if (value.length < 6) {
                      return AppLocalizations.of(
                        context,
                      )!.invalidPassword; // Wrong password
                    }
                    return null;
                  },
                ),
                SizedBox(height: 32),
                BlocConsumer<AuthCubit, AuthState>(
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return Center(child: CircularProgressIndicator());
                    }

                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey[300],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        minimumSize: Size(200, 50),
                      ),
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          context.read<AuthCubit>().login(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                          );
                        }
                      },
                      child: Text(
                        AppLocalizations.of(context)!.login, // Login
                      ),
                    );
                  },

                  listener: (context, state) {
                    if (state is AuthFailure) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.message)));
                    }
                    if (state is AuthSuccess) {
                      Navigator.pushReplacementNamed(context, "/home");
                    }
                  },
                ),
                // SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => RegisterPage(
                              onLocaleChange: onLocaleChange,
                              onThemeToggle: onThemeToggle,
                            ),
                      ),
                    );
                  },
                  child: Text(AppLocalizations.of(context)!.notregistered),
                ),

                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => ForgotPasswordPage()));
                  },
                  child: Text(AppLocalizations.of(context)!.forgotPassword),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
