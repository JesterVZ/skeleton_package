import 'package:flutter/material.dart';

class AwersomeSceleton extends StatefulWidget {
  ///Высота скелетона
  final double height;

  ///Длина скелетона
  final double width;

  ///Поле [borderRadius] определяет радиус закругления углов
  final double? borderRadius;

  ///Поле [shape] класса [SkeletonShape] определяет фигуру скелетона. Разные фигуры падходят под разные задачи. Например,
  ///[SkeletonShape.rectangle] идеально подходит для строк и полей ввода, в то время, как [SkeletonShape.circle] подходит
  ///для аватаров
  final SkeletonShape shape;

  ///Поле [animationDuration] определяет продолжительность анимации скелетона
  final Duration animationDuration;

  ///Цвет фона скелетона, по умолчанию серый
  final Color backgroundColor;

  ///Цвет линии градиента, по умолчанию белый
  final Color flashColor;

  ///создает скелетон
  const AwersomeSceleton(
      {super.key,
      required this.width,
      required this.height,
      this.borderRadius,
      this.shape = SkeletonShape.rectangle,
      this.animationDuration = const Duration(milliseconds: 1500),
      this.backgroundColor = Colors.black12,
      this.flashColor = Colors.black26});

  @override
  State<StatefulWidget> createState() => _AwersomeSceletonState();
}

class _AwersomeSceletonState extends State<AwersomeSceleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _gradientAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: widget.animationDuration, vsync: this);
    _gradientAnimation = Tween<double>(
      begin: -3,
      end: 10,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    )..addListener(() {
        setState(() {});
      });
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 0),
          shape: shapes[widget.shape]!,
          gradient: LinearGradient(
              begin: Alignment(_gradientAnimation.value, 0),
              end: const Alignment(-1, 0),
              colors: const [Colors.black12, Colors.black26, Colors.black12])),
    );
  }
}

enum SkeletonShape { circle, rectangle }

Map<SkeletonShape, BoxShape> shapes = {
  SkeletonShape.circle: BoxShape.circle,
  SkeletonShape.rectangle: BoxShape.rectangle
};
