import 'dart:math';
import 'package:flutter/material.dart';

class AnimatedElectricalBackground extends StatefulWidget {
  final Widget child;
  final Color backgroundColor;

  const AnimatedElectricalBackground({
    super.key,
    required this.child,
    this.backgroundColor = const Color(0xFFF0F4F8), // A light, clean blue-grey
  });

  @override
  State<AnimatedElectricalBackground> createState() =>
      _AnimatedElectricalBackgroundState();
}

class _AnimatedElectricalBackgroundState
    extends State<AnimatedElectricalBackground> with TickerProviderStateMixin {
  late AnimationController _controller;
  List<_AnimatedIcon> animatedIcons = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration:
          const Duration(seconds: 40), // Slowed down for a more subtle effect
      vsync: this,
    )..repeat();

    generateAnimatedIcons();
  }

  void generateAnimatedIcons() {
    final random = Random();
    // A curated list of relevant EE icons
    final electricalIcons = [
      Icons.electrical_services,
      Icons.power,
      Icons.flash_on,
      Icons.settings_input_component,
      Icons.developer_board,
      Icons.router,
      Icons.cable,
      Icons.settings_ethernet,
      Icons.wifi,
      Icons.cell_tower,
      Icons.power_input,
      Icons.outlet,
      Icons.bolt,
      Icons.transform,
      Icons.electric_meter,
    ];

    for (int i = 0; i < 30; i++) {
      // A good number for performance
      animatedIcons.add(
        _AnimatedIcon(
          icon: electricalIcons[random.nextInt(electricalIcons.length)],
          initialX: random.nextDouble(),
          initialY: random.nextDouble(),
          size: 20.0 + random.nextDouble() * 25.0, // Range from 20 to 45
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor,
      child: Stack(
        children: [
          // The animated icons in the background
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Stack(
                children: animatedIcons.map((animIcon) {
                  // This calculation makes the icons loop from bottom to top
                  double progress =
                      (_controller.value + animIcon.initialY) % 1.0;
                  return Positioned(
                    left: MediaQuery.of(context).size.width * animIcon.initialX,
                    top: MediaQuery.of(context).size.height * progress -
                        animIcon.size,
                    child: Opacity(
                      opacity: 0.15, // Faint opacity
                      child: Icon(
                        animIcon.icon,
                        size: animIcon.size,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
          // The main content of the screen is placed on top
          widget.child,
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// Private helper class for the animated icons
class _AnimatedIcon {
  final IconData icon;
  final double initialX;
  final double initialY;
  final double size;

  _AnimatedIcon({
    required this.icon,
    required this.initialX,
    required this.initialY,
    required this.size,
  });
}
