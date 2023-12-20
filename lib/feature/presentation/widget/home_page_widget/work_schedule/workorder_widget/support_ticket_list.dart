 import 'package:flutter/material.dart';
import 'package:suja_shoie_app/constant/skeleton.dart';
import 'package:suja_shoie_app/constant/utils/theme_styles.dart';

import '../../../../pages/support_ticket.dart';

class SupportTicketList extends StatefulWidget {
  const SupportTicketList(
    BuildContext context, {
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SupportTicketListState createState() => _SupportTicketListState();
}

class _SupportTicketListState extends State<SupportTicketList> {
  late bool isLoading; // Added isLoading flag

  @override
  void initState() {
    super.initState();
    // Fetch data when the widget is created
    loadList();
  }

  void loadList() {
    isLoading = true;
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return isLoading
            ? Padding(
                padding: const EdgeInsets.only(top: 50, left: 50, right: 50),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Skeleton(
                              width: 150,
                              height: 60,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Skeleton(
                              width: 150,
                              height: 60,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Skeleton(
                              width: 316,
                              height: 40,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Skeleton(
                              width: 316,
                              height: 40,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Skeleton(
                              width: 316,
                              height: 40,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        )
                      ],
                    );
                  },
                ),
              )
            : Column(
                children: [
                  const SizedBox(
                      width: 250,
                      child: Image(
                        image: AssetImage('assets/images/empty-box.png'),
                      )),
                  const Text(
                    "You're all set.",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(
                    height: defaultPadding / 2,
                  ),
                  const Text(
                    'There are no open support tickets for you.',
                    style: TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 100),
                    child: Container(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return const SupportTicketForm();
                              },
                            ));
                          },
                          child: const Text('Create Support Ticket')),
                    ),
                  )
                ],
              );
      },
    );
  }
}
