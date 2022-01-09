import 'package:flashare/views/screens/body.dart';
import 'package:flutter/material.dart';

class ItemDetail extends StatelessWidget {
  const ItemDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        shadowColor: Colors.transparent,
      ),
      body: TempBody(),
    );
  }
}

class TempBody extends StatefulWidget {
  const TempBody({
    Key? key,
  }) : super(key: key);

  @override
  State<TempBody> createState() => _TempBodyState();
}

class _TempBodyState extends State<TempBody> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<String> ListImg = [
      "https://upload.wikimedia.org/wikipedia/commons/9/9a/Reel_and_Brand_-_September_2021_-_Sarah_Stierch_05.jpg",
      "https://thucthan.com/media/2018/07/beefsteak/cach-lam-beefsteak.jpg",
      "https://cf.shopee.vn/file/5f32380ce6908b9c81a1404146e88a36",
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: SizedBox(
                  height: 240,
                  width: double.infinity,
                  child: PageView.builder(
                      onPageChanged: (value) {
                        setState(() {
                          currentIndex = value;
                        });
                      },
                      itemCount: ListImg.length,
                      itemBuilder: (context, index) {
                        return ShowImage(img_link: ListImg[index]);
                      }),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      ListImg.length, (index) => buildDot(index: index)))
            ],
          ),
        ),
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 70,
              ),
              const Center(
                child: Text(
                  "Beefsteak",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 28,
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              const Center(
                child: Text(
                  "31/12/2021",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffDB4437),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 55.0),
                child: Text(
                  "Upload by",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                      color: Colors.black),
                ),
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 55, top: 15),
                    width: 36,
                    height: 36,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 3),
                            blurRadius: 10,
                            color: Colors.grey,
                          )
                        ],
                        image: DecorationImage(
                            image: NetworkImage(
                              "https://scontent.fvca1-1.fna.fbcdn.net/v/t1.6435-9/71286345_2193084204317518_881016848903045120_n.jpg?_nc_cat=102&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=wdrPbAJTs4kAX9p6z3s&_nc_ht=scontent.fvca1-1.fna&oh=00_AT8cvEbewS_s-1WCcPYzsmZc6ziJh2eW_4bNUwljvL792w&oe=61E0F54F",
                            ),
                            fit: BoxFit.cover)),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    child: const Text(
                      "Van Do",
                      style: TextStyle(
                        fontSize: 14,
                        letterSpacing: 1,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 55.0),
                child: Text(
                  "Desciption",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                      color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 80,
                child: Padding(
                  padding: EdgeInsets.only(left: 55, right: 23),
                  child: Text(
                    "Delivered between monday aug and thursday 20 from 8pm to 10:30 pm",
                  ),
                ),
              ),
              Center(
                child: ElevatedButton(
                    onPressed: () {},
                    child: const SizedBox(
                        height: 60,
                        width: 240,
                        child: Center(
                            child: Text(
                          "Request",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        )))),
              ),
            ],
          ),
        )
      ],
    );
  }

  Container buildDot({required int index}) {
    return Container(
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: currentIndex == index ? 20 : 6,
      decoration: BoxDecoration(
          color: currentIndex == index ? const Color(0xff4285F4) : Colors.grey,
          borderRadius: BorderRadius.circular(3)),
    );
  }
}

class ShowImage extends StatelessWidget {
  const ShowImage({
    Key? key,
    required this.img_link,
  }) : super(key: key);

  final String img_link;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      height: 240,
      width: 240,
      decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 3),
              spreadRadius: 5,
              blurRadius: 10,
              color: Colors.grey,
            )
          ],
          image: DecorationImage(
              image: NetworkImage(
                img_link,
              ),
              fit: BoxFit.cover)),
    );
  }
}
