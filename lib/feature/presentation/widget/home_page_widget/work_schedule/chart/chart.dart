import 'package:flutter/material.dart';
import 'package:suja_shoie_app/constant/utils/theme_styles.dart';

import '../../../../providers/theme_providers.dart';

class Chart extends StatefulWidget {
  const Chart({
    super.key,
    required this.themeState,
  });

  final ThemeProvider themeState;

  @override
  State<Chart> createState() => _Chart();
}

class _Chart extends State<Chart> {
  String selectedValue = 'One';
  Map<String, int> valueMap = {
    'One': 1,
    'Two': 2,
    'Three': 3,
  };

  @override
  Widget build(BuildContext context) {
    

    return Card(elevation: 5,
    shadowColor: Colors.black,
      child: Container(
        height: 248,
        decoration: BoxDecoration(
        
          borderRadius: BorderRadius.circular(5),
          color: widget.themeState.isDarkTheme
              ? const Color(0xFF424242)
              : Colors.white,
        ),child: const Padding(
          padding: EdgeInsets.all(defaultPadding/2),
          child: Column(mainAxisAlignment: MainAxisAlignment.end,
            children: [Text('Chart')],),
        ),
        // child: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: <Widget>[
        //     DropdownButton<String>(
        //       value: selectedValue,
        //       onChanged: (newValue) {
        //         setState(() {
        //           selectedValue = newValue!;
        //         });
        //       },
        //       items: valueMap.keys.map<DropdownMenuItem<String>>((String value) {
        //         return DropdownMenuItem<String>(
        //           value: value,
        //           child: Text(value),
        //         );
        //       }).toList(),
        //     ),
        //     SizedBox(height: 20),
        //     Text(
        //       'Selected Number: ${valueMap[selectedValue]}',
        //       style: TextStyle(fontSize: 18),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}






//  GridView.builder(
//       itemCount: 4,
//       shrinkWrap: true,
//       gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           childAspectRatio: 1,
//           mainAxisSpacing: defaultPadding / 2,
//           crossAxisSpacing: defaultPadding / 2,
//           mainAxisExtent: 120),
//       itemBuilder: (context, index) => Container(
        
//        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
//          color: themeState.isDarkTheme ? const Color(0xFF424242) : Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: themeState.isDarkTheme
//                 ? const Color(0xFF0d0d0d)
//                 : Colors.grey.shade400,
//             offset: const Offset(5.0, 5.0),
//             blurRadius: 15.0,
//             spreadRadius: 1.0,
//           ),]),
//       ),
//     );




