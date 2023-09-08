import 'package:flutter/material.dart';

import '../../../../common/constants/app_color.dart';

class Categories extends StatefulWidget {

  final bool isSelected;
  final void Function() onTap;

  const Categories({
    required this.isSelected,
    required this.onTap,
    super.key,
});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        GestureDetector(
          onTap: widget.onTap,
          child:  SizedBox(
            width: 84,
            height: 40,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                color: widget.isSelected ? Colors.transparent : Colors.white,
              ),
              child:  Center(
                child: Text(
                  "Explore",
                  style: TextStyle(
                    color: widget.isSelected ? AppColor.white : AppColor.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: widget.onTap,
          child:  SizedBox(
            width: 84,
            height: 40,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                color: widget.isSelected ? Colors.white : Colors.transparent,
              ),
              child: Center(
                child: Text(
                  "For you",
                  style: TextStyle(
                    color: widget.isSelected ? AppColor.black : AppColor.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
