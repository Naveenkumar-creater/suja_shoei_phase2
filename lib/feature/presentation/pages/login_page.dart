import 'package:flutter/material.dart';

import '../../../constant/utils/theme_styles.dart';
import '../../../constant/utils/responsive.dart';
import '../widget/login_page_widget/auth.dart';

class Loginpage extends StatelessWidget {
  const Loginpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/sujashoei.jpeg'),fit: BoxFit.cover)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // if (Responsive.isDesktop(context))
                  //   SizedBox(
                  //       width: 450,
                  //       child: Image.asset('assets/images/sujashoei.jpeg',
                  //       )),
                  const SizedBox(width: defaultPadding),
                  if (Responsive.isDesktop(context))
                    Container(
                      height: 400,
                      width: 500,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(193, 189, 189, 189),
                          borderRadius: BorderRadiusDirectional.circular(5)),
                      child: const SizedBox(
                        width: 450,
                        child: Auth(),
                      ),
                    ),
                ],
              ),
              // if (!Responsive.isDesktop(context))
              //   SizedBox(
              //       width: 450,
              //       child: Image.asset('assets/images/sujashoei.jpeg')),
              const SizedBox(height: defaultPadding),
               if (!Responsive.isDesktop(context))
                    Container(
                      height: 400,
                      width: 500,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(193, 189, 189, 189),
                          borderRadius: BorderRadiusDirectional.circular(5)),
                      child: const SizedBox(
                        width: 450,
                        child: Auth(),
                      ),
                    ),
            ]),
      ),
    );
  }
}