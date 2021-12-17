import 'package:flashare/views/widgets/rounded_input_field.dart';
import 'package:flutter/material.dart';

class UploadTab extends StatefulWidget {
  const UploadTab({ Key? key }) : super(key: key);

  @override
  _UploadTabState createState() => _UploadTabState();
}

class _UploadTabState extends State<UploadTab> {
  TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  String searchQuery = "Search_query";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 50),
          _searchBar(),
          const SizedBox(height: 24),
          _renderItem(),
        ],
      ),
    );
  }

  Widget _searchBar() {
    return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RoundedInputField(
                    hintText: "Search",
                    icon: Icons.search,
                    onChanged: (value) {}),
              ],
            );
  }

  Widget _renderItem() {
    return Container();
  }
  
}