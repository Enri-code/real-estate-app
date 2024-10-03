import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_estate_app/src/styles/app_color.dart';

class NavigationTabIcon extends StatelessWidget {
  const NavigationTabIcon({
    super.key,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final bool selected;
  final void Function() onTap;
  final Duration duration = const Duration(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(25.r),
      splashColor: Colors.transparent,
      onTap: onTap,
      child: SizedBox(
        height: 50.r,
        width: 50.r,
        child: Stack(
          children: [
            // black background
            Container(
              height: 50.r,
              width: 50.r,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
              ),
            ),
            // white splash  and color
            Align(
              alignment: Alignment.center,
              child: AnimatedContainer(
                duration: duration,
                height: selected ? 50.r : 25.r,
                width: selected ? 50.r : 25.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selected ? AppColor.primary : Colors.transparent,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
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
