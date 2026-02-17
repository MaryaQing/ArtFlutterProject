import 'package:flutterdatabaseproject/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'registor_page.dart';
import 'package:flutterdatabaseproject/auth/pages.dart/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage ({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  //get auth servies 
  final authService = AuthService();
  //text controler
  final _emailcontroller = TextEditingController();
  final _passwordController = TextEditingController();
  //log in button pressed
void login() async{
  final email = _emailcontroller.text.trim();
    final password = _passwordController.text.trim();
//attempt login 
try{
await authService.signInWithEmailPassword(email, password);

   if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Homepage()),
        );
      }
}
//catch
catch (e){
  if(mounted) {
  ScaffoldMessenger.of(context)
  .showSnackBar(SnackBar(content:Text("Error:$e")));
}
}
}
// ui 
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
              color: const Color.fromARGB(255, 85, 57, 34),
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                 // color: Colors.black.withOpacity(0.5),
                  blurRadius: 25,
                  offset: const Offset(0, 15),
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                Text(
                  "Welcome Back",
                  style: TextStyle(
                    color: const Color(0xFFF5EDE6),
                    fontSize: isTablet ? 32 : 24,
                    fontWeight: FontWeight.w300, // خط رفيع
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
                    fillColor: const Color.fromARGB(255, 218, 189, 160),
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
                    fillColor: const Color.fromARGB(255, 218, 189, 160),
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

                /// LOGIN BUTTON
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: login,
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
                      "LOGIN",
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

               GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegistorPage()),
                  ),
                  child: const Text(
                    "Don't have an account? Sign up",
                    style: TextStyle(
                      color: Color(0xFFD7A86E),
                      fontWeight: FontWeight.w500,
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


