import 'package:flutter/material.dart';
import 'package:real_estate_app/src/data/app_images.dart';
import 'package:real_estate_app/src/styles/app_color.dart';
import 'package:real_estate_app/src/utils/constants.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({
    super.key,
    required this.currentIndex,
    required this.changeTab,
  });

  final int currentIndex;
  final void Function(int) changeTab;

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  late Animation selectAnim, deselectAnim;
  int? lastIndex;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: kDuration300Mil,
    )..forward();
    final colorAnim = TweenSequence([
      TweenSequenceItem(
        tween: ColorTween(begin: AppColor.primary, end: AppColor.brown),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: ColorTween(begin: AppColor.brown, end: AppColor.black),
        weight: 1,
      ),
    ]);

    deselectAnim = colorAnim.animate(controller!);
    selectAnim = colorAnim.animate(ReverseAnimation(controller!));
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CustomNavBar oldWidget) {
    lastIndex = oldWidget.currentIndex;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller!,
      builder: (context, _) {
        return Row(
          children: [
            NavigationTabIcon(
              icon: AppImages.mapPin,
              selected: 0 == widget.currentIndex,
              onTap: () => _onSelectTab(0),
              color: getColor(0),
            ),
            NavigationTabIcon(
              icon: AppImages.message,
              selected: 1 == widget.currentIndex,
              onTap: () => _onSelectTab(1),
              color: getColor(1),
            ),
            NavigationTabIcon(
              icon: AppImages.home,
              selected: 2 == widget.currentIndex,
              size: 28,
              onTap: () => _onSelectTab(2),
              color: getColor(2),
            ),
            NavigationTabIcon(
              icon: AppImages.heart,
              selected: 3 == widget.currentIndex,
              onTap: () => _onSelectTab(3),
              color: getColor(3),
            ),
            NavigationTabIcon(
              icon: AppImages.person,
              selected: 4 == widget.currentIndex,
              onTap: () => _onSelectTab(4),
              color: getColor(4),
            ),
          ],
        );
      },
    );
  }

  void _onSelectTab(int index) {
    widget.changeTab(index);
    controller?.forward(from: 0);
  }

  Color getColor(int index) {
    if (widget.currentIndex == index) {
      return selectAnim.value;
    }
    if (index == lastIndex) {
      return deselectAnim.value;
    }
    return Colors.black;
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

  final String icon;
  final double? size;
  final Color color;
  final bool selected;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 54,
        height: 54,
        child: Stack(
          alignment: Alignment.center,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(shape: BoxShape.circle, color: color),
              child: AnimatedSize(
                duration: kDuration500Mil,
                clipBehavior: Clip.none,
                child: SizedBox.square(dimension: selected ? 54 : 38),
              ),
            ),
            Image.asset(
              icon,
              color: Colors.white,
              width: 24,
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}
