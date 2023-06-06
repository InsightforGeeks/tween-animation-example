import 'package:flutter/material.dart';

void main() {
  runApp(const TweenAnimationApp());
}

class TweenAnimationApp extends StatelessWidget {
  const TweenAnimationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tween Animation Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TweenAnimationScreen(),
    );
  }
}

class ColorTweenPlus extends Tween<Color> {
  ColorTweenPlus({required Color begin, required Color end})
      : super(begin: begin, end: end);

  @override
  Color lerp(double t) {
    return Color.lerp(begin, end, t)!;
  }
}

class TweenAnimationScreen extends StatefulWidget {
  const TweenAnimationScreen({super.key});

  @override
  _TweenAnimationScreenState createState() => _TweenAnimationScreenState();
}

class _TweenAnimationScreenState extends State<TweenAnimationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _sizeAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    final sizeTween = Tween<double>(begin: 100, end: 300);
    final colorTween = ColorTweenPlus(
      begin: const Color(0xff0e7ac7),
      end: const Color(0xff777777),
    );

    _sizeAnimation = sizeTween.animate(_animationController);
    _colorAnimation = colorTween.animate(_animationController);

    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tween Animation Example'),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Container(
              width: _sizeAnimation.value,
              height: _sizeAnimation.value,
              decoration: BoxDecoration(
                color: _colorAnimation.value ?? Colors.transparent,
                shape: BoxShape.circle,
              ),
            );
          },
        ),
      ),
    );
  }
}
