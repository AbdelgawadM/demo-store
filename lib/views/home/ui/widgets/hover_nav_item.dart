import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:our_store/core/app_colors.dart';

class HoverNavItem extends StatefulWidget {
  final String title;
  final String imageUrl;

  const HoverNavItem({super.key, required this.title, required this.imageUrl});

  @override
  State<HoverNavItem> createState() => _HoverNavItemState();
}

class _HoverNavItemState extends State<HoverNavItem> {
  RxBool isHovered = false.obs;
  Rx<Color> color = AppColors.kWhiteColor.obs;
  Rx<Color> textColor = AppColors.kBlackColor.obs;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        isHovered.value = true;
        color.value = AppColors.kPrimaryColor;
        textColor.value = AppColors.kWhiteColor;
      },
      onExit: (_) {
        isHovered.value = false;
        color.value = AppColors.kWhiteColor;
        textColor.value = AppColors.kBlackColor;
      },
      child: Obx(
        () => Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.kBordersideColor),
            color: color.value,
            borderRadius: const BorderRadius.all(Radius.circular(60)),
          ),
          child: Obx(
            () => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isHovered.value)
                  Container(
                    width: 50,
                    height: 50,
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Image.network(
                      widget.imageUrl,
                      height: 40,
                      width: 40,
                      fit: BoxFit.contain,
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 20),
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      color: textColor.value,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
