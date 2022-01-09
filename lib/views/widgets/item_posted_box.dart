import 'package:flashare/views/screens/item_request.dart';
import 'package:flashare/views/widgets/image_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemPostedBox extends StatelessWidget {
  final String imgUrl;
  final String category;
  final String name;
  final String description;
  final int dueDate;

  const ItemPostedBox({
    Key? key,
    required this.imgUrl,
    required this.category,
    required this.description,
    required this.name,
    required this.dueDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) { 
          return ItemRequestScreen(
            itemUrl: imgUrl, category: category, itemName: name,
          ); 
        }));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Color.fromRGBO(239, 238, 238, 1),
          // boxShadow: [
          //   BoxShadow()
          // ]
        ),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.all(16),
                child: ImageBorder(image: Image.network(imgUrl)),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                padding: EdgeInsets.fromLTRB(4, 16, 8, 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '[$category] $name',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                          fontFamily: GoogleFonts.roboto().fontFamily,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.black,
                        fontFamily: GoogleFonts.roboto().fontFamily,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '$dueDate days left',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.red,
                        fontFamily: GoogleFonts.roboto().fontFamily,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}