import 'package:chatty/utils/helper/style_helper.dart';
import 'package:flutter/material.dart';

class ProfileImageWidget extends StatelessWidget {
  final String name;
  final int index;
  const ProfileImageWidget(this.name, this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    const colors = [
      Colors.blue,
      Colors.green,
      Colors.amber,
      Colors.red,
      Colors.teal,
      Colors.grey,
      Colors.purple,
      Colors.blueGrey
    ];

    return Container(
      decoration:
          BoxDecoration(color: colors[index], borderRadius: BorderRadius.circular(50)),
      width: 50,
      height: 50,
      child: Center(
        child: Text(
          name[0].toUpperCase(),
          style: text(context).titleLarge!.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
