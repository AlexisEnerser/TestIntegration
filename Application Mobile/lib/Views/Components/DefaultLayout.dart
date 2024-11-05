import 'package:flutter/material.dart';

/*class DefaultLayout extends StatelessWidget {
  final int? flex;
  final Widget? child;
  const DefaultLayout({
    super.key, this.child, this.flex,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex??1,
      child: Stack(
        children: [
          Container(
            color: const Color.fromARGB(255, 245, 251, 255),
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey,
                  width: 2
                )
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: child??Container(),
          )
        ]
      ),
    );
  }
}*/

class DefaultLayout2 extends StatelessWidget {
  final double width;
  final double height;
  final Widget? child;
  const DefaultLayout2({
    super.key, this.child, required this.width, required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(15),
      //margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 245, 251, 255),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey,
          width: 2
        )
      ),
      child: child??Container(),
    );
  }
}