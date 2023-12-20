// import 'package:flutter/material.dart';


// class CustomSearchField<T> extends StatefulWidget {
//   final String? labelText;
//   final String? hintText;
//   final List<T> Function() getSuggestions;
//   final void Function(T selectedValue)? onSuggestionSelected;

//   CustomSearchField({
//     Key? key,
//     required this.labelText,
//     required this.hintText,
//     required this.getSuggestions,
//     this.onSuggestionSelected,
//   }) : super(key: key);
//   @override
//   State<CustomSearchField> createState() => _CustomSearchFieldState();
// }

// class _CustomSearchFieldState extends State<CustomSearchField> {
//   final FocusNode focus = FocusNode();

//   @override
//   Widget build(BuildContext context) {
//     final List suggestions = widget.getSuggestions();

//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             alignment: Alignment.center,
//             width: 600,
//             height: 120,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(widget.labelText ?? 'Search'),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: const BorderRadius.all(Radius.circular(5)),
//                   ),
//                   child: SearchField(
//                     maxSuggestionsInViewPort: 5,
//                     key: const Key('searchfield'),
//                     hint: 'Search by ${widget.hintText ?? "wish"}',
//                     itemHeight: 50,
//                     focusNode: focus,
//                     suggestionState: Suggestion.expand,
//                    onSuggestionTap: (SearchFieldListItem<dynamic> x) {
//   focus.unfocus();
  
// },
//  onSearchTextChanged: (query) {
//                       final filter = suggestions
//                           .where((element) {
//                             if (element is String) {
//                               return element.contains(query);
//                             } else if (element is int) {
//                               return element.toString().contains(query);
//                             }
//                             return false;
//                           })
//                           .toList();

//                       return filter
//                           .map((e) => SearchFieldListItem<dynamic>(e.toString(),
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     vertical: 4.0),
//                                 child: Text(e.toString(),
//                                     style: const TextStyle(
//                                         fontSize: 16, color: Colors.black45)),
//                               )))
//                           .toList();
//                     },
//                     scrollbarDecoration: ScrollbarDecoration(
//                       radius: const Radius.elliptical(5, 5),
//                       thumbVisibility: true,
//                       thumbColor: Colors.blue,
//                       fadeDuration: const Duration(milliseconds: 2000),
//                       trackColor: Colors.blue,
//                       trackRadius: const Radius.circular(10),
//                     ),
//                     searchInputDecoration: InputDecoration(
//                       enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(5),
//                           borderSide: BorderSide(
//                               width: 1, color: Colors.blueGrey.shade200)),
//                       focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(5),
//                           borderSide: BorderSide(
//                               width: 2, color: Colors.blue.withOpacity(0.5))),
//                       hintStyle: const TextStyle(color: Colors.black54, fontSize: 12),
//                     ),
//                     suggestionsDecoration: SuggestionDecoration(
//                         padding: const EdgeInsets.only(left: 16),
//                         borderRadius: const BorderRadius.all(Radius.circular(10))),
//                     suggestions: suggestions!
//                         .map((e) => SearchFieldListItem<dynamic>(e.toString(),
//                             child: Padding(
//                               padding: const EdgeInsets.symmetric(vertical: 4.0),
//                               child: Text(e.toString(),
//                                   style: const TextStyle(
//                                       fontSize: 16, color: Colors.black)),
//                             )))
//                         .toList(),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
