import 'package:flutter/material.dart';
import 'package:flutterdatabaseproject/auth/auth_service.dart' show AuthService;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutterdatabaseproject/auth/pages.dart/HomePage.dart';

class Registorpage extends StatefulWidget {
  const Registorpage({super.key});
  @override
  State<Registorpage> createState() => _RegistorpageState();
  }

  class _RegistorpageState extends State<Registorpage>{
      //get auth servies 
  final authService = AuthService();
  //text controler
  final _emailcontroller = TextEditingController();
  final _passwordController = TextEditingController();
    final _confirmPasswordController = TextEditingController();
    //sigm up button pressed 
    void signUp() async{
      //prepare data 
      final email = _emailcontroller.text.trim();
final password =_passwordController.text.trim();
final confirmPassword = _confirmPasswordController.text;
  //check the password match 
  if(password != confirmPassword){
    ScaffoldMessenger.of(context)
    .showSnackBar(const SnackBar(content:Text("password dont match")));
  return;
  }  
    try
    {
await authService.signUpWithEmailPassword(email, password);

if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Homepage()),
        );
      }
    }
    catch (e){
      if(mounted){
            ScaffoldMessenger.of(context)
    .showSnackBar( SnackBar(content:Text("error: $e")));
      }
    }
    
    }

    //ui
@override
Widget build(BuildContext context) {

  final size = MediaQuery.of(context).size;
  final isTablet = size.width > 600;

  return Scaffold(
    backgroundColor: const Color(0xFF2B1A0F),
    body: Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? size.width * 0.25 : 25,
          ),
          child: Container(
            padding: EdgeInsets.all(isTablet ? 40 : 28),
            decoration: BoxDecoration(
              color: const Color(0xFF372414),
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 25,
                  offset: const Offset(0, 15),
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                Text(
                  "Create Account",
                  style: TextStyle(
                    color: const Color(0xFFF5EDE6),
                    fontSize: isTablet ? 32 : 24,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 2,
                  ),
                ),

                SizedBox(height: isTablet ? 40 : 30),

                /// EMAIL
                TextField(
                  controller: _emailcontroller,
                  style: const TextStyle(
                    color: Color(0xFF2B1A0F),
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    hintText: "Email",
                    hintStyle: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w300,
                    ),
                    filled: true,
                    fillColor: const Color(0xFFA08264),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: isTablet ? 22 : 18,
                      horizontal: 20,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// PASSWORD
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  style: const TextStyle(
                    color: Color(0xFF2B1A0F),
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w300,
                    ),
                    filled: true,
                    fillColor: const Color(0xFFA08264),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: isTablet ? 22 : 18,
                      horizontal: 20,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// CONFIRM PASSWORD
                TextField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  style: const TextStyle(
                    color: Color(0xFF2B1A0F),
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    hintText: "Confirm Password",
                    hintStyle: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w300,
                    ),
                    filled: true,
                    fillColor: const Color(0xFFA08264),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: isTablet ? 22 : 18,
                      horizontal: 20,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                SizedBox(height: isTablet ? 40 : 30),

                /// SIGN UP BUTTON
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: signUp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 218, 189, 160),
                      padding: EdgeInsets.symmetric(
                        vertical: isTablet ? 22 : 18,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      elevation: 10,
                    ),
                    child: Text(
                      "SIGN UP",
                      style: TextStyle(
                        color: const Color(0xFF2B1A0F),
                        fontSize: isTablet ? 18 : 16,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 3,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// BACK TO LOGIN
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Text(
                    "Already have an account? Login",
                    style: TextStyle(
                      color: Color(0xFFA08264),
                      fontWeight: FontWeight.w300,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

  }
  