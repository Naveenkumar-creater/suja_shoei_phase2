// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suja_shoie_app/feature/presentation/api_services/login_api%20.dart';
import 'package:suja_shoie_app/feature/presentation/providers/theme_providers.dart';

import '../../providers/loginprovider.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({super.key});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final themeState = Provider.of<ThemeProvider>(context);
    final LoginApiService authservice = LoginApiService();
    final personDetails=Provider.of<LoginProvider>(context).user;

    void signOut() {
      authservice.logOutUSer(context);
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'signOut') {
              signOut();
            } else if (value == 'Theme') {
              setState(() {
                themeProvider.setDarkTheme(!themeProvider.isDarkTheme);
              });
            }
          },
          child: const CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            child: Icon(
              size: 30,
              Icons.person,
              color: Colors.grey,
            ),
          ),
          offset: const Offset(12, 70),
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          itemBuilder: (BuildContext context) {
            return <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'account',
                child: Column(
                  children: [
                    const Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(
                              'assets/images/Suji shoie1.jpg'), // Replace with your image asset
                          radius: 50,
                        ),
                        CircleAvatar(
                          radius: 14,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.camera_alt,
                            size: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                   Text("${personDetails?.loginId}"),
                    const SizedBox(height: 8.0),
                    Container(
                      height: 2,
                      width: double.infinity,
                      color: themeState.isDarkTheme
                          ? const Color(0xFF0d0d0d)
                          : Colors.grey.shade400,
                    ),
                  ],
                ),
              ),
              // PopupMenuItem<String>(
              //   child: Container(
       
              //     child: Center(child: Text( "${personDetails?.personFname}")),
              //   ),
              // ),
              PopupMenuItem<String>(
                value: 'Theme',
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              themeProvider
                                  .setDarkTheme(!themeProvider.isDarkTheme);
                            });
                          },
                          child: const Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                             Center(child: Text('Theme')),
                              SizedBox(
                                width: 8,
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'signOut',
                child: GestureDetector(
                  onTap: () {
                    signOut();
                  },
                  child: const Center(child: Text('Sign Out')),
                ),
              ),
              PopupMenuItem<String>(
                enabled: true,
                value: 'account',
                child: Container(
                  alignment: Alignment.center,
                  width: 200,
                  height: 150,
                ),
              ),
            ];
          },
        ),
        const SizedBox(
          height: 2,
        ),
    Text("${personDetails!.loginId}", style: const TextStyle(fontSize: 12, color: Colors.white)),
      ],
    );
  }
}