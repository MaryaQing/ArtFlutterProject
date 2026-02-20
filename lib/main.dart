import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutterdatabaseproject/auth/auth_gate.dart';
void main() async{
   WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "https://qqztjcltzrqlmcrugtkb.supabase.co",
     // change to your own url   
    anonKey: "sb_publishable_zKVdzDdYX1qFntH0m0j2pw_3VHPJj9Y", // change to your own key
  );

  runApp(const MainApp());

}

class MainApp extends StatelessWidget {
  const MainApp({super.key});


  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Artist World',
      home: AuthGate(),
    );
  }
}