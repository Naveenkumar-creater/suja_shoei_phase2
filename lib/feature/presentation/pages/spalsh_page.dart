import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:suja_shoie_app/feature/presentation/pages/login_page.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
    );
    super.initState();

    // Delay for 2 seconds and then navigate to the login page
    Future.delayed(const Duration(milliseconds: 1500), () {
      Navigator.push(
        context,
        PageTransition(
          child: const Loginpage(),
          type: PageTransitionType.fade,
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Replace this Image.asset with your desired image
            Image.asset(
              'assets/images/sujashoeilogo.png',
              width: 200, // Adjust the width as needed
              height: 200, // Adjust the height as needed
              // You can also add other properties like fit, alignment, etc.
            ),
            
          ],
        ),
      ),
    );
  }
}