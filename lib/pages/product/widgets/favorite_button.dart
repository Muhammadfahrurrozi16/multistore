// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../utilis/images.dart';

class FavoriteButton extends StatelessWidget {
  final Color backgroundColor;
  final Color favColor;
  final bool isSelected;
  final int? productId;
  const FavoriteButton({
    Key? key,
    required this.backgroundColor,
    required this.favColor,
    required this.isSelected,
    this.productId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        elevation:2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        color: Theme.of(context).cardColor,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Image.asset(
            Images.wishlist,
            color: favColor,
            height: 16,
            width: 16,
          ),),
      ),
    );
  }
}
