import 'package:flashare/views/screens/item_request.dart';
import 'package:flashare/views/screens/other_profile.dart';
import 'package:flashare/views/widgets/avatar_circle.dart';
import 'package:flashare/views/widgets/image_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemRequestBox extends StatelessWidget {
  final String imgUrl;
  final String category;
  final String name;
  final String description;
  final String imgUser;
  final String nameUser;
  final String userId;
  final String itemId;
  final bool? isSent;

  const ItemRequestBox({
    Key? key,
    required this.imgUrl,
    required this.category,
    required this.description,
    required this.name,
    required this.imgUser,
    required this.nameUser,
    required this.userId,
    required this.itemId,
    this.isSent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isSent == null)
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ItemRequestScreen(
              itemUrl: imgUrl,
              category: category,
              itemName: name,
              itemId: itemId,
            );
          }));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Color.fromRGBO(239, 238, 238, 1),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                height: 140,
                width: double.infinity,
                padding: EdgeInsets.all(12),
                child: ImageBorder(image: Image.network(imgUrl)),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                padding: EdgeInsets.fromLTRB(4, 16, 8, 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      height: 8,
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
                    SizedBox(height: 24),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  OtherProfileScreen(userId: userId)),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          AvatarCircle(imgUrl: imgUser, radius: 12),
                          SizedBox(width: 8),
                          Text(
                            nameUser,
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(width: 24)
                        ],
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
