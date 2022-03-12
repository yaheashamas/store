import 'package:carousel_slider/carousel_slider.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../models/home_model.dart';
import '../../shared/components/components.dart';
import '../../shared/style/colors.dart';

class Product extends StatelessWidget {
  const Product({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {
        if (state is ShopFavoriteSuccessState) {
          if (state.favoriteModel!.status) {
            defaultToast(
              message: state.favoriteModel!.message,
              colorsToaster: colorsToast.SUCCESS,
            );
          }
        }
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Conditional.single(
          context: context,
          conditionBuilder: (context) => cubit.homeModel != null,
          widgetBuilder: (context) => main(cubit: cubit),
          fallbackBuilder: (context) => defaultLoading(),
        );
      },
    );
  }

  Widget main({
    ShopCubit? cubit,
  }) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 250.0,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
              viewportFraction: 1,
            ),
            items: cubit!.homeModel!.data!.banners.map((e) {
              return ExtendedImage.network(
                e.image.toString(),
                width: double.infinity,
                height: 300.0,
                fit: BoxFit.cover,
                cache: true,
                alignment: Alignment.center,
              );
            }).toList(),
          ),
          SizedBox(
            height: 5.0,
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 1.0,
              mainAxisSpacing: 1.0,
              childAspectRatio: 1 / 1.45,
              children: List.generate(
                cubit.homeModel!.data!.products.length,
                (index) => BuildGridProduct(
                  model: cubit.homeModel!.data!.products[index],
                  cubit: cubit,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget BuildGridProduct({
    ProductModel? model,
    ShopCubit? cubit,
  }) =>
      Container(
        color: Colors.white,
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                ExtendedImage.network(
                  model!.image.toString(),
                  width: double.infinity,
                  height: 200.0,
                  cache: true,
                  shape: BoxShape.rectangle,
                ),
                if (model.discount != 0) ...{
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    color: Colors.red,
                    child: Text(
                      "DISCOUNT",
                      style: TextStyle(color: Colors.white, fontSize: 14.0),
                    ),
                  )
                }
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "${model.price.round().toString()}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: defaultColor,
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      if (model.discount != 0) ...{
                        Text(
                          "${model.old_price.round().toString()}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      },
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          cubit!.AddFavoriteProduct(
                            idProduct: model.id.toInt(),
                          );
                        },
                        icon: cubit!.mapIsFavorite[model.id] == true
                            ? Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                            : Icon(Icons.favorite_border),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
