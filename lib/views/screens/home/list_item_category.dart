import 'dart:async';

import 'package:flashare/models/api.dart';
import 'package:flashare/providers/fetch_item_by_category.dart';
import 'package:flashare/views/screens/main_layout.dart';
import 'package:flashare/views/widgets/item_posted_box.dart';
import 'package:flutter/material.dart';

class ListItemByCategory extends StatefulWidget {
  ListItemByCategory({Key? key, this.category}) : super(key: key);

  final category;

  @override
  _ListItemByCategoryState createState() => _ListItemByCategoryState();
}

class _ListItemByCategoryState extends State<ListItemByCategory> {
  Future<ApiResponse>? list_item_;
  Timer? timer;

  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (mounted) {
        setState(() {
          list_item_ = FetchItemByCategory(widget.category);
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: const Icon(Icons.arrow_back_ios_new, color: Colors.black,),
      ),
      backgroundColor: const Color(0xfffaf7f7),
      body: FutureBuilder(
        future: list_item_,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            ApiResponse temp = snapshot.data as ApiResponse;
            if (temp.Sucess == false) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            timer!.cancel();
            return ListView.builder(
              itemCount: temp.Data.length,
              itemBuilder: (context, index) {
            String imgUrl =
                "https://img.wattpad.com/0109d605e0e684e00850b928fb9b10ba3c1ce237/68747470733a2f2f73332e616d617a6f6e6177732e636f6d2f776174747061642d6d656469612d736572766963652f53746f7279496d6167652f3954474d49644355582d357056673d3d2d3333383437393932332e3134386139376437633334333464336232353733393032303735312e6a7067?s=fit&w=720&h=720";
            if (temp.Data[index]["photos_link"].length > 0) {
              imgUrl = temp.Data[index]["photos_link"][0];
            }
            return ItemCard(
              imgUrl: imgUrl,
              title: temp.Data[index]["title"],
              category: temp.Data[index]["category"].toUpperCase(),
              description: temp.Data[index]["description"],
            );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  const ItemCard({
    Key? key, this.imgUrl, this.category, this.title, this.description,
  }) : super(key: key);

  final imgUrl;
  final category;
  final title;
  final description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 150,
          width: double.infinity,
          color: Colors.white,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 20,),
              Container(
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image(
                  image: NetworkImage(imgUrl),
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 30, 10, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          "[$category] $title",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Text(
                        description,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 5,)
      ],
    );
  }
}
