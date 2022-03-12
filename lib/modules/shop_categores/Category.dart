import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/components.dart';

class Category extends StatelessWidget {
  const Category({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Conditional.single(
          context: context,
          conditionBuilder: (context) => cubit.categoryModel != null,
          widgetBuilder: (context) => BuildItemCategory(cubit: cubit),
          fallbackBuilder: (context) => defaultLoading(),
        );
      },
    );
  }

  Widget BuildItemCategory({
    ShopCubit? cubit,
  }) =>
      ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => Container(
          child: Row(
            children: [
              ExtendedImage.network(
                "${cubit!.categoryModel!.data!.data[index].image}",
                width: 150.0,
                height: 150.0,
                cache: true,
              ),
              SizedBox(
                width: 20.0,
              ),
              Text(
                '${cubit.categoryModel!.data!.data[index].name}',
                style: TextStyle(color: Colors.black),
              ),
              Spacer(),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.chevron_right_sharp,
                ),
              ),
            ],
          ),
        ),
        separatorBuilder: (context, index) => Divider(),
        itemCount: cubit!.categoryModel!.data!.data.length,
      );
}
