// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../utilis/color_resource.dart';
import '../../../utilis/custom_theme.dart';
import '../../../utilis/dimensions.dart';
import '../../../utilis/images.dart';
import '../../Data/Models/Category_model_respon.dart';

class CategoryItemWidget extends StatelessWidget {
  final Category category;
  const CategoryItemWidget({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.width/ 5,
          width: MediaQuery.of(context).size.width/5,
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.2)),
            borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
            color: Theme.of(context).highlightColor,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
            child: FadeInImage.assetNetwork(
              placeholder: Images.placeholder,
              image: 'https://picsum.photo/20${category.id}',
              imageErrorBuilder: (c, o, s) => Image.asset(
                Images.placeholder,
                fit: BoxFit.cover,
              ),
            )
          ),
        ),
        const SizedBox(height: Dimensions.paddingSizeExtraSmall),
        Center(
          child: Text(
            category.name ?? '-',
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: titilliumRegular.copyWith(
              fontSize: Dimensions.fontSizeSmall,
              color: ColorResources.getPrimary(context)
            ),
          ),
        ),
      ],
    );
  }
}
