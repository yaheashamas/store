import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import '../../../shared/components/components.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/components.dart';
import '../../shared/style/colors.dart';

class Favorite extends StatelessWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {
        if (state is ShopStateFavoriteState) {
          defaultLoading();
        }
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);

        return Conditional.single(
          context: context,
          conditionBuilder: (context) => cubit.favoritesModel != null,
          widgetBuilder: (context) => buildFavorites(
            cubit: cubit,
            context: context,
          ),
          fallbackBuilder: (context) => defaultLoading(),
        );
      },
    );
  }

  Widget buildFavorites({
    required ShopCubit cubit,
    required BuildContext context,
  }) {
    return Conditional.single(
      context: context,
      conditionBuilder: (context) =>
          cubit.favoritesModel!.data!.product.length > 0,
      widgetBuilder: (context) => showAllItems(
        cubit: cubit,
        context: context,
      ),
      fallbackBuilder: (context) => Center(
        child: Text(
          "No Items",
        ),
      ),
    );
  }

  Widget showAllItems({
    required ShopCubit cubit,
    required BuildContext context,
  }) {
    var productFavorite = cubit.favoritesModel!.data!.product;
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) => Container(
        width: 200.0,
        height: 200.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  ExtendedImage.network(
                    cubit.favoritesModel!.data!.product[index].image.toString(),
                    width: double.infinity,
                    height: 200.0,
                    cache: true,
                    fit: BoxFit.cover,
                    shape: BoxShape.rectangle,
                  ),
                  if (productFavorite[index].discount != 0) ...{
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.0,
                      ),
                      color: Colors.red,
                      child: Text(
                        "DISCOUNT",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                        ),
                      ),
                    )
                  }
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productFavorite[index].name.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          "${productFavorite[index].price.round().toString()}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: defaultColor,
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        if (productFavorite[index].discount != 0) ...{
                          Text(
                            "${productFavorite[index].oldPrice.round().toString()}",
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
                            cubit.AddFavoriteProduct(
                              idProduct: productFavorite[index].id.toInt(),
                            );
                          },
                          icon:
                              cubit.mapIsFavorite[productFavorite[index].id] ==
                                      true
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
            )
          ],
        ),
      ),
      separatorBuilder: (context, index) => Divider(),
      itemCount: productFavorite.length,
    );
  }
}
