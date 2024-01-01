// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../utilis/color_resource.dart';
import 'package:shimmer/shimmer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/Banners/banners_bloc.dart';
import '../../../utilis/images.dart';

class Bannerwidget extends StatefulWidget {
  const Bannerwidget({super.key});

  @override
  State<Bannerwidget> createState() => _BannerwidgetState();
}

class _BannerwidgetState extends State<Bannerwidget> {
  int IndexIndicator = 0;

  @override
  void initState() {
    context.read<BannersBloc>().add(const BannersEvent.getAll());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(
          width: width,
          height: width * 0.4,
          child: BlocBuilder<BannersBloc, BannersState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: (){
                 return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                enabled: true,
                child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorResources.white,
                    )),
              );
              },
              loaded: (data) {
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    CarouselSlider.builder(
                      options: CarouselOptions(
                        viewportFraction: 1,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        disableCenter: true,
                        onPageChanged: (index, reason) {
                          setState(() {
                            IndexIndicator = index;
                          });
                        },
                      ),
                      itemCount: data.data.length,
                      itemBuilder: (context,index, _){
                        final banner = data.data[index];
                        return InkWell(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: FadeInImage.assetNetwork(
                                placeholder: Images.placeholder,
                                fit: BoxFit.cover,
                                image: banner.bannerUrl,
                                imageErrorBuilder: (context, error, stackTrace) => Image.asset(
                                  Images.placeholder,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        );
                      }, 
                    ),
                    Positioned(
                      bottom: 5,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ...data.data.asMap().entries.map((e) {
                            return TabPageSelectorIndicator(
                              backgroundColor: IndexIndicator == e.key
                                ? Theme.of(context).primaryColor
                                : Colors.grey,
                              borderColor: IndexIndicator == e.key
                                ? Theme.of(context).primaryColor
                                : Colors.grey,
                              size: 10,
                            );
                          }).toList()
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          },
          ),
        ),
        const SizedBox(
          height: 5,
        )
      ],
    );
  }
}
