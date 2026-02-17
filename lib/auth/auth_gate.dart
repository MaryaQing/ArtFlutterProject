//auth state changes
// unathenticated -> log in page 
// authenticated -> profile page
import 'package:flutterdatabaseproject/auth/pages.dart/HomePage.dart';
import 'package:flutterdatabaseproject/auth/pages.dart/loginpage.dart';

import 'package:flutterdatabaseproject/auth/pages.dart/Profilepage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';
class AuthGate extends StatelessWidget{
const AuthGate({super.key});

@override
    Widget build(BuildContext context){
      return StreamBuilder(
        stream: Supabase.instance.client.auth.onAuthStateChange,
        //build approopiaite page based on auth state

        builder: (context,snapshot){
//loading

if (snapshot.connectionState == ConnectionState.waiting){
  return const Scaffold(
    body: Center(child: CircularProgressIndicator(),)
  );
}
// check if there is a sesion
final session = snapshot.hasData ? snapshot.data!.session:null;
if(session != null){
  return const Homepage();
}
  else{
    return const Loginpage();
  }
      },
        
        );
  }
}


