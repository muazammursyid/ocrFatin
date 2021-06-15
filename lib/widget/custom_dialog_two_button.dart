import 'package:flutter/material.dart';

class Constants {
  Constants._();
  static const double padding = 20;
  static const double avatarRadius = 45;
}

class CustomTwoDialog extends StatefulWidget {
  final String title, descriptions, textOk, textCancel;
  final String img;
  final Function functionOk, functionCancel;

  const CustomTwoDialog(
      {Key key,
      this.title,
      this.descriptions,
      this.textOk,
      this.textCancel,
      this.img,
      this.functionOk,
      this.functionCancel})
      : super(key: key);

  @override
  _CustomTwoDialogState createState() => _CustomTwoDialogState();
}

class _CustomTwoDialogState extends State<CustomTwoDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
              left: Constants.padding,
              top: Constants.avatarRadius + Constants.padding,
              right: Constants.padding,
              bottom: Constants.padding),
          margin: EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                widget.title,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                widget.descriptions,
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 22,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.bottomRight,
                    child: FlatButton(
                        onPressed: widget.functionCancel,
                        child: Text(
                          widget.textCancel,
                          style: TextStyle(fontSize: 18),
                        )),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: FlatButton(
                        color: Colors.red,
                        onPressed: widget.functionOk,
                        child: Text(
                          widget.textOk,
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          left: Constants.padding,
          right: Constants.padding,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: Constants.avatarRadius,
            child: ClipRRect(
              borderRadius:
                  BorderRadius.all(Radius.circular(Constants.avatarRadius)),
              child: Image.asset("assets/images/warning.jpeg"),
            ),
          ),
        ),
      ],
    );
  }
}
