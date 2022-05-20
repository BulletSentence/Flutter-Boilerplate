import 'package:flutter/material.dart';

class HeaderScrollable extends StatefulWidget {
  final String image;
  final String textTop;
  final String textBottom;
  final double offset;
  const HeaderScrollable(
      {Key? key,
      required this.image,
      required this.textTop,
      required this.textBottom,
      required this.offset})
      : super(key: key);

  @override
  _HeaderScrollableState createState() => _HeaderScrollableState();
}

class _HeaderScrollableState extends State<HeaderScrollable> {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        padding: const EdgeInsets.only(left: 40, top: 50, right: 20),
        height: 310,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFF3383CD),
              Color(0xFF11249F),
            ],
          ),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/images/valorant.jpg"),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: (widget.offset < 0) ? 0 : widget.offset,
                    left: 80,
                    right: 80,
                    bottom: 80,
                    child: Image(
                      width: 80,
                      fit: BoxFit.scaleDown,
                      image: AssetImage(
                        widget.image,
                      ),
                      alignment: Alignment.center,
                    ),
                  ),
                  // Positioned(
                  //   top: 20 - widget.offset / 2,
                  //   left: 150,
                  //   child: Text(
                  //     "${widget.textTop} \n${widget.textBottom}",
                  //     style: kHeadingTextStyle.copyWith(
                  //       color: Colors.white,
                  //     ),
                  //   ),
                  // ),
                  Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
