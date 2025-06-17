import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_dua_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:my_dua_app/features/auth/presentation/pages/login_page.dart';
import 'package:my_dua_app/features/home/presentation/pages/home_page.dart';
import 'package:my_dua_app/injection/service_locator.dart' as di;
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
await di.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: BlocProvider(create: (_) => di.sl<AuthCubit>(),
      child:  LoginPage(),
      ),
      routes: {
        "home": (context) => HomePage(),
      },
    );
  }
}
