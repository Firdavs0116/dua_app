import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_dua_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:my_dua_app/features/auth/presentation/cubit/auth_state.dart';

class LoginPage extends StatelessWidget{

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  LoginPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(padding: EdgeInsets.all(16),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state){
          if(state is AuthFailure){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
          if (state is AuthSuccess){
            Navigator.pushReplacement(context, "/home" as Route<Object?>);
          }

        }, 
        builder: (BuildContext context, AuthState state) {
          return Column(
            children: [

              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: "Email"),
              ),

              TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true,
              ),

              const SizedBox(height: 20,),
              if(state is AuthLoading)
              const CircularProgressIndicator()

              else
              Column(
                children: [
                  ElevatedButton(onPressed: (){
                    context.read<AuthCubit>().login(emailController.text, passwordController.text);
                  }, child: const Text("Login")),
                  TextButton(onPressed: (){
                    context.read<AuthCubit>().register(emailController.text, passwordController.text);

                  }, child: const Text("Register")),
                ],
              )
            ],
          );
          },
      ),),
      
    );
  }
}