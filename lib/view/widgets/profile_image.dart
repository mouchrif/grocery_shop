import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileImage extends StatelessWidget {
  final Size size;
  final Color? colorBg;
  final Color? colorIcon;
  const ProfileImage({Key? key, required this.size, this.colorBg, this.colorIcon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size.height * 0.1,
      backgroundColor: Colors.transparent,
      child: Hero(
        tag: "assets/images/profile.png",
        child: CircleAvatar(
          backgroundImage: const AssetImage("assets/images/profile.png"),
          radius: size.height * 0.1,
          backgroundColor: Colors.transparent,
          child: Align(
            alignment: Alignment.bottomRight,
            child: colorBg == null && colorIcon == null
            ? const SizedBox()
            : GestureDetector(
              onTap: () {},
              child: CircleAvatar(
                radius: size.height * 0.028,
                backgroundColor: colorBg,
                child: Align(
                  alignment: Alignment.center,
                  child: Icon(
                    FontAwesomeIcons.camera,
                    color: colorIcon,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
