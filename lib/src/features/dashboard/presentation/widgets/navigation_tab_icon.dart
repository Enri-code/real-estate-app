import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_estate_app/src/styles/app_color.dart';
import 'package:real_estate_app/src/utils/constants.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({
    super.key,
    required this.tabIndex,
    required this.changeTab,
  });

  final int tabIndex;
  final void Function(int) changeTab;

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  int? lastIndex;

  final colorAnim = TweenSequence([
    TweenSequenceItem(
      tween: ColorTween(begin: AppColor.primary, end: AppColor.brown),
      weight: 1,
    ),
    TweenSequenceItem(
      tween: ColorTween(begin: AppColor.brown, end: Colors.black),
      weight: 1,
    ),
  ]);

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: kDuration300Mil)
      ..forward();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CustomNavBar oldWidget) {
    lastIndex = oldWidget.tabIndex;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller!,
      builder: (context, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            NavigationTabIcon(
              icon: Icons.maps_ugc,
              selected: isSelected(0),
              onTap: () {
                widget.changeTab(0);
                controller?.forward(from: 0);
              },
              color: getColor(0),
            ),
            NavigationTabIcon(
              icon: Icons.message_rounded,
              selected: isSelected(1),
              onTap: () {
                widget.changeTab(1);
                controller?.forward(from: 0);
              },
              color: getColor(1),
            ),
            NavigationTabIcon(
              icon: Icons.home,
              selected: isSelected(2),
              size: 28,
              onTap: () {
                widget.changeTab(2);
                controller?.forward(from: 0);
              },
              color: getColor(2),
            ),
            NavigationTabIcon(
              icon: Icons.favorite,
              selected: isSelected(3),
              onTap: () {
                widget.changeTab(3);
                controller?.forward(from: 0);
              },
              color: getColor(3),
            ),
            NavigationTabIcon(
              icon: Icons.person,
              selected: isSelected(4),
              onTap: () {
                widget.changeTab(4);
                controller?.forward(from: 0);
              },
              color: getColor(4),
            ),
          ],
        );
      },
    );
  }

  bool isSelected(int index) => index == widget.tabIndex;
  Color getColor(int index) {
    if (widget.tabIndex == index) {
      return colorAnim.transform(1 - controller!.value)!;
    }
    if (widget.tabIndex == lastIndex) {
      return colorAnim.transform(controller!.value)!;
    }
    return colorAnim.transform(1)!;
  }
}

class NavigationTabIcon extends StatelessWidget {
  const NavigationTabIcon({
    super.key,
    required this.icon,
    required this.selected,
    required this.color,
    required this.onTap,
    this.size,
  });

  final IconData icon;
  final double? size;
  final Color color;
  final bool selected;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 50.r,
        width: 50.r,
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedContainer(
              duration: kDuration300Mil,
              height: selected ? 50.r : 40.r,
              width: selected ? 50.r : 40.r,
              decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            ),
            Icon(icon, color: Colors.white, size: size),
          ],
        ),
      ),
    );
  }
}





// class NavigationTabIcon extends StatefulWidget {
//   const NavigationTabIcon({
//     super.key,
//     required this.icon,
//     required this.selected,
//     required this.onTap,
//   });

//   final IconData icon;
//   final bool selected;
//   final void Function() onTap;

//   @override
//   State<NavigationTabIcon> createState() => _NavigationTabIconState();
// }

// class _NavigationTabIconState extends State<NavigationTabIcon>
//     with SingleTickerProviderStateMixin {
//   late AnimationController controller;
//   final Duration duration = const Duration(milliseconds: 1200);

//   /// animation variables
//   ///
//   late bool selected;

//   //// animation values
//   late Animation<double> colorAnimaton;
//   late Animation<double> colorSizeAnimation;
//   late Animation<double> borderSplashAnimation;

//   @override
//   void initState() {
//     super.initState();
//     controller = AnimationController(
//       vsync: this,
//       duration: duration,
//     );
//     selected = widget.selected;

//     initializeAnimation();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       borderRadius: BorderRadius.circular(25.r),
//       splashColor: Colors.transparent,
//       onTap: () {
//         controller.reset();
//         controller.forward();
//         widget.onTap();
//       },
//       child: SizedBox(
//         height: 50.r,
//         width: 50.r,
//         child: Stack(
//           children: [
//             // black background
//             Container(
//               height: 50.r,
//               width: 50.r,
//               decoration: const BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Colors.black,
//               ),
//             ),
//             // white splash  and color
//             AnimatedBuilder(
//               animation: controller,
//               builder: (context, child) {
//                 return Align(
//                   alignment: Alignment.center,
//                   child: Container(
//                     height: 50.r * colorSizeAnimation.value,
//                     width: 50.r * colorSizeAnimation.value,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border: Border.all(
//                         width: borderSplashAnimation.value,
//                         color: Colors.white,
//                       ),
//                       color: AppColor.primary.withOpacity(
//                         colorAnimaton.value,
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//             Align(
//               alignment: Alignment.center,
//               child: Icon(
//                 widget.icon,
//                 color: Colors.white,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void initializeAnimation() {
//     if (widget.selected) {
//       /// setup for color animation
//       colorAnimaton = TweenSequence(
//         [
//           TweenSequenceItem(
//             tween: Tween(
//               begin: 0.0,
//               end: 0.0,
//             ),
//             weight: 50,
//           ),
//           TweenSequenceItem(
//             tween: Tween(
//               begin: 0.0,
//               end: 1.0,
//             ),
//             weight: 50,
//           ),
//         ],
//       ).animate(controller);

//       /// setup for color size animation
//       colorSizeAnimation = TweenSequence(
//         [
//           TweenSequenceItem(
//             tween: Tween(
//               begin: 1.0,
//               end: 0.4,
//             ),
//             weight: 50,
//           ),
//           TweenSequenceItem(
//             tween: Tween(
//               begin: 0.4,
//               end: 1.0,
//             ),
//             weight: 50,
//           ),
//         ],
//       ).animate(controller);

//       borderSplashAnimation = TweenSequence(
//         [
//           TweenSequenceItem(
//             tween: Tween(
//               begin: 1.0,
//               end: 2.0,
//             ),
//             weight: 50,
//           ),
//           TweenSequenceItem(
//             tween: Tween(
//               begin: 2.0,
//               end: 0.0,
//             ),
//             weight: 50,
//           ),
//         ],
//       ).animate(controller);
//     }
//   }
// }
