import 'package:flutter/material.dart';

class CardModelInformation extends StatelessWidget {
  const CardModelInformation({
    super.key,
    required this.title,
    required this.children,
  });
  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            const SizedBox(height: 12),
            _CustomDecoratedBox(
              radius: 10,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 25, bottom: 20, left: 20, right: 20),
                child: SizedBox(
                    width: double.infinity,
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.end,
                      alignment: WrapAlignment.start,
                      runSpacing: 10,
                      spacing: 20,
                      children: children,
                    )),
              ),
            ),
          ],
        ),
        Positioned(
          left: 30,
          child: _CustomDecoratedBox(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                title,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CustomDecoratedBox extends StatelessWidget {
  const _CustomDecoratedBox(
      {required this.child, this.border, this.color, this.radius = 20});
  final Widget child;
  final BoxBorder? border;
  final Color? color;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          border: border ?? Border.all(color: colors.outline, width: 2),
          color: color ?? colors.surface),
      child: child,
    );
  }
}
