// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../bloc/product/product_bloc.dart';
import '../../utilis/color_resource.dart';
import '../../utilis/dimensions.dart';
// import '../Data/Models/Product_model_respon.dart';
import '../base_widget/custom_app_bar.dart';
import '../home/widgets/product_item.dart';

class CategoryProduct extends StatefulWidget {
  final int id;
  final String name;
  const CategoryProduct({
    Key? key,
    required this.id,
    required this.name,
  }) : super(key: key);

  @override
  State<CategoryProduct> createState() => _CategoryProductState();
}

class _CategoryProductState extends State<CategoryProduct> {
  @override
  void initState(){
    super.initState();
    context.read<ProductBloc>().add(
      ProductEvent.getByCategory(widget.id,
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.getIconBg(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomBarApp(title: widget.name),
          const SizedBox(height: Dimensions.paddingSizeSmall),

          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                },
                loaded: (model) {
                  return Expanded(
                    child: MasonryGridView.count(
                      crossAxisCount: 2,
                      padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeSmall
                      ),
                      physics: const BouncingScrollPhysics(),
                      itemCount: model.data!.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index){
                        return ProductItemWidget(product: model.data![index]);
                      },
                    ),
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}