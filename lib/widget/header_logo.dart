import 'package:flutter/material.dart';

class HeaderLogo extends StatelessWidget {
  const HeaderLogo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.all(40),
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                    image: AssetImage("assets/images/mlv_lab.png"),
                    fit: BoxFit.fitWidth),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(40),
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                    image: AssetImage("assets/images/ukm_logo.png"),
                    fit: BoxFit.fitWidth),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HeaderLogoHalal extends StatelessWidget {
  const HeaderLogoHalal({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 60,
      left: 100,
      child: Container(
        margin: EdgeInsets.all(15),
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.transparent,
          image: DecorationImage(
              image: AssetImage("assets/images/logo.png"),
              fit: BoxFit.fitWidth),
        ),
      ),
    );
  }
}
