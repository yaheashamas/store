import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/layout/cubit/cubit.dart';
import 'package:store/layout/cubit/states.dart';
import 'package:store/modules/shop_search/Search.dart';
import 'package:store/shared/components/components.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        print("cubit page currentIndex=> ${cubit.currentIndex}");
        return Scaffold(
          appBar: AppBar(
            title: Text("salla"),
            actions: [
              IconButton(
                onPressed: () {
                  navigateTo(
                    context: context,
                    Widget: Search(),
                  );
                },
                icon: Icon(
                  Icons.search_sharp,
                ),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (value) {
              cubit.changeCurrentIndex(value);
              cubit.changeScreen();
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category_outlined),
                label: "Category",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_sharp),
                label: "Favorite",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: "Settings",
              ),
            ],
          ),
          body: cubit.widgets[cubit.currentIndex],
        );
      },
    );
  }
}
