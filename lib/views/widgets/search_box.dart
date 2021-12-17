//import 'package:flutter/material.dart';
//import 'package:flutter_typeahead/flutter_typeahead.dart';
//
//class SearchBox extends StatefulWidget {
//  SearchBox({Key? key}) : super(key: key);
//
//  @override
//  _SearchBoxState createState() => _SearchBoxState();
//}
//
//class _SearchBoxState extends State<SearchBox> {
//  @override
//  Widget build(BuildContext context) {
//    return Material(
//      color: Colors.transparent,
//      child: Container(
//        padding: const EdgeInsets.all(30),
//        child: TypeAheadField(
//          textFieldConfiguration: TextFieldConfiguration(
//            decoration: InputDecoration(
//              filled: true,
//              fillColor: Colors.white,
//              hintText: "Search",
//              focusedBorder: OutlineInputBorder(
//                borderSide: const BorderSide(color: Colors.white),
//                borderRadius: BorderRadius.circular(25.7),
//              ),
//              enabledBorder: UnderlineInputBorder(
//                borderRadius: BorderRadius.circular(25.7),
//                borderSide: const BorderSide(color: Colors.white),
//              ),
//            )
//          ),
//          noItemsFoundBuilder: (context) => const SizedBox.shrink(),
//          suggestionsCallback: (pattern) {
//            return List<String>();
//          },
//        )
//      ),
//    )
//  }
//}