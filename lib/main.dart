import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_dua_app/features/auth/presentation/pages/forgot_password.dart';
import 'package:my_dua_app/features/dua/ui/pages/dua_list_page.dart';
import 'package:my_dua_app/features/language/presentation/ui/language_selector_page.dart';

import 'firebase_options.dart';
import 'package:my_dua_app/injection/service_locator.dart' as di;
import 'package:my_dua_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:my_dua_app/features/auth/presentation/pages/login_page.dart';
import 'package:my_dua_app/features/auth/presentation/pages/register_page.dart';
import 'package:my_dua_app/features/home/presentation/pages/home_page.dart';
import 'package:my_dua_app/features/language/presentation/cubit/locale_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  bool _isDarkMode = false;
  bool _isLanguageChosen = false;
  String? _initialRoute;


  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
      _isLanguageChosen = true;
    });
  }

  void toggleTheme(bool value) {
    setState(() {
      _isDarkMode = value;
    });
  }

  void checkUserLoggedIn(){
    final user = FirebaseAuth.instance.currentUser;
    if (user != null){
      _isLanguageChosen = true;
      _initialRoute = '/home';
    }
    else{
      _initialRoute = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<AuthCubit>()),
        BlocProvider(create: (_) => di.sl<LocaleCubit>()),
      ],
      child: BlocBuilder<LocaleCubit, Locale>(
        builder: (context, state) {
          return MaterialApp(
            title: 'My Dua App',
            debugShowCheckedModeBanner: false,
            locale: state,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: _initialRoute == '/home'
            ? const HomePage() 
            : !_isLanguageChosen
                ? LanguageSelectorPage(onLocaleChange: setLocale)
                : LoginPage(
                    onLocaleChange: setLocale,
                    onThemeToggle: toggleTheme,
                  ),
            routes: {
              '/home': (_) => const HomePage(),
              '/dua': (_) =>  DuaListPage(),
            },
          );
        },
      ),
    );
  }
}
