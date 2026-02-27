import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_dua_app/core/constants/app_colors.dart';
import 'package:my_dua_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:my_dua_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:my_dua_app/features/home/presentation/pages/home_page.dart';
import 'package:my_dua_app/features/language/presentation/widgets/language_selector_with_flags.dart';
import 'package:my_dua_app/l10n/app_localizations.dart';

class RegisterPage extends StatefulWidget {
  final void Function(Locale locale) onLocaleChange;
  final void Function(bool) onThemeToggle;
  const RegisterPage({super.key, 
  required this.onLocaleChange, 
  required this.onThemeToggle});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
    final _formkey = GlobalKey<FormState>();
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  



  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        actions: [
          Padding(padding: EdgeInsets.symmetric(horizontal: 10),
          child: LanguageSelectorWithFlags(onLocaleChanged: widget.onLocaleChange),),
          
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
                  AppLocalizations.of(context)!.register,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF223E7F),
                ),
                ),
                 const SizedBox(height: 32),
                 TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.email,
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)
                    )
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty){
                      return AppLocalizations.of(context)!.enterYourEmail;
                    }
                    else if(!emailRegex.hasMatch(value)){
                      return AppLocalizations.of(context)!.wrongEmail;
                    }
                    else{
                      return null;
                    }
                  },
                 ),
                 SizedBox(height: 10,),
                 TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.password,
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12), 
                    )
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty){
                      return AppLocalizations.of(context)!.enterYourPassword;
                    }
                    else if (value.length < 6){
                      return AppLocalizations.of(context)!.passwordTooShort;
                    }
                    else{
                      return null;
                    }
                  },
                 ),
                 SizedBox(height: 10,),

                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)),
                      );
                    }
                    if (state is AuthSuccess) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => HomePage(onLocaleChange: (Locale p1) {  }, onThemeToggle: (_) {  },)),
                      );
                    }
                  },
                  builder: (context, state) {
                    return Column(
                      children: [
                        const SizedBox(height: 20),
                        if (state is AuthLoading)
                          const CircularProgressIndicator()
                        else
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueGrey[300],
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              minimumSize: Size(200, 50),
                            ),
                            onPressed: () {
                              context.read<AuthCubit>().register(
                                    emailController.text.trim(),
                                    passwordController.text.trim(),
                                  );
                            },
                            child: Text(
                              AppLocalizations.of(context)!.register
                              ),
                          ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(AppLocalizations.of(context)!.alreadyRegisteredLogin),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
