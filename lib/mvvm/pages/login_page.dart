import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:task_todo/mvvm/pages/view_list.dart';

import '../auth_view_model.dart';
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();


class SignIn extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF21899C),
      body: SafeArea(
        child: Column(
          children: [
            //to give space from top
            const Expanded(
              flex: 1,
              child: Center(),
            ),

            //page content here
            Expanded(
              flex: 9,
              child: buildCard(size,authViewModel,context),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCard(Size size, authViewModel,BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40), topRight: Radius.circular(40)),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //header text
            const Text(
              'Login Account',
              style: TextStyle(
                fontSize: 24.0,
                color: Color(0xFF15224F),
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            const Text(
              'Discover your social & Try to Login',
              style: TextStyle(
                fontSize: 14.0,
                color: Color(0xFF969AA8),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: size.height * 0.04,
            ),

            //logo section
            logo(size.height / 8, size.height / 8),
            SizedBox(
              height: size.height * 0.03,
            ),
            richText(24),
            SizedBox(
              height: size.height * 0.05,
            ),

            //email & password section
            emailTextField(size),
            SizedBox(
              height: size.height * 0.02,
            ),
            passwordTextField(size),
            SizedBox(
              height: size.height * 0.03,
            ),

            //sign in button
        GestureDetector(
          onTap: () async{
            String email = emailController.text.trim();
            String password = passwordController.text.trim();

            if (await authViewModel.signIn(email, password)) {
              Navigator.pushReplacementNamed(context, '/dashboard');

              //   Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (context) => TaskListView()),);            } else {
            // // Show error message
            showDialog(
            context: context,
            builder: (context) {
            return AlertDialog(
            title: Text('Error'),
            content: Text('Sign up failed. Please try again.'),
            actions: [
            TextButton(
            onPressed: () {
            Navigator.pop(context);
            },
            child: Text('OK'),
            ),
            ],
            );
            },
            );
            }

          },
           child: signInButton(size/2)),
            SizedBox(
              height: size.height * 0.04,
            ),

            //footer section. sign up text here
           GestureDetector(onTap: (){
             Navigator.pushReplacementNamed(context, '/signup');
           }

           ,child:  footerText(),)
          ],
        ),
      ),
    );
  }

  Widget logo(double height_, double width_) {
    return SvgPicture.asset(
      'assets/logo.svg',
      height: height_,
      width: width_,
    );
  }

  Widget richText(double fontSize) {
    return Text.rich(
      TextSpan(
        style: TextStyle(
          fontSize: fontSize,
          color: const Color(0xFF21899C),
          letterSpacing: 2.000000061035156,
        ),
        children: const [
          TextSpan(
            text: 'LOGIN',
            style: TextStyle(
              fontWeight: FontWeight.w800,
            ),
          ),
          TextSpan(
            text: 'PAGE',
            style: TextStyle(
              color: Color(0xFFFE9879),
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget emailTextField(Size size) {
    return Container(
      alignment: Alignment.center,
      height: size.height / 11,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          width: 1.0,
          color: const Color(0xFFEFEFEF),
        ),
      ),
      child:  TextField(
        controller: emailController,
        style: TextStyle(
          fontSize: 16.0,
          color: Color(0xFF15224F),
        ),
        maxLines: 1,
        cursorColor: Color(0xFF15224F),
        decoration: InputDecoration(
            labelText: 'Email/ Phone number',
            labelStyle: TextStyle(
              fontSize: 12.0,
              color: Color(0xFF969AA8),
            ),
            border: InputBorder.none),
      ),
    );
  }

  Widget passwordTextField(Size size) {
    return Container(

      alignment: Alignment.center,
      height: size.height / 11,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          width: 1.0,
          color: const Color(0xFFEFEFEF),
        ),
      ),
      child:  TextField(
        controller: passwordController,
        style: TextStyle(
          fontSize: 16.0,
          color: Color(0xFF15224F),
        ),
        maxLines: 1,
        obscureText: true,
        keyboardType: TextInputType.visiblePassword,
        cursorColor: Color(0xFF15224F),
        decoration: InputDecoration(
            labelText: 'Password',
            labelStyle: TextStyle(
              fontSize: 12.0,
              color: Color(0xFF969AA8),
            ),
            border: InputBorder.none),
      ),
    );
  }

  Widget signInButton(Size size) {
    return Container(
      alignment: Alignment.center,
      height: size.height / 11,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        color: const Color(0xFF21899C),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4C2E84).withOpacity(0.2),
            offset: const Offset(0, 15.0),
            blurRadius: 60.0,
          ),
        ],
      ),
      child: const Text(
        'Sign in',
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.white,
          fontWeight: FontWeight.w600,
          height: 1.5,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget footerText() {
    return const Text.rich(
      TextSpan(
        style: TextStyle(
          fontSize: 12.0,
          color: Color(0xFF3B4C68),
        ),
        children: [
          TextSpan(
            text: 'Don’t have an account ?',
          ),
          TextSpan(
            text: ' ',
            style: TextStyle(
              color: Color(0xFFFF5844),
            ),
          ),
          TextSpan(
            text: 'Sign up',
            style: TextStyle(
              color: Color(0xFFFF5844),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}