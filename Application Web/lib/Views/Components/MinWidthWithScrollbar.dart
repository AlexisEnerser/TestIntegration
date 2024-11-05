import 'package:flutter/Material.dart';

class MinWidthWithScrollbar extends StatelessWidget {
  final double minWidth;
  final Widget child;

  const MinWidthWithScrollbar({super.key, required this.minWidth, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Si el ancho disponible es menor que el mínimo, se muestra el scrollbar
        bool showScrollbar = constraints.maxWidth < minWidth;

        return SizedBox(
          width: minWidth,
          child: showScrollbar
              ? SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: minWidth),
                    child: child,
                  ),
                )
              : child,
        );
      },
    );
  }
}