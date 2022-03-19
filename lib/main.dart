import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/layout/ShopLayout.dart';
import 'package:store/layout/cubit/cubit.dart';
import 'package:store/layout/cubit/states.dart';
import 'package:store/shared/bloc_observer.dart';
import 'package:store/shared/components/constants.dart';
import 'package:store/shared/network/local/cashe_helper.dart';
import 'package:store/shared/network/remote/dio_helper.dart';
import 'package:store/shared/theme/themeDark.dart';
import 'package:store/shared/theme/themeLight.dart';
import 'modules/onBoarding/OnBoarding.dart';
import 'modules/shop_login/login.dart';

void main(List<String> args) async {
  //on all functions then runAPP
  WidgetsFlutterBinding.ensureInitialized();
  //BLoC Observer
  BlocOverrides.runZoned(() {}, blocObserver: MyBlocObserver());
  //initial dio
  DioHelper.init();
  //initial shared Preferences
  await CacheHelper.init();
  //get data from shared Preferences
  //to light and dark
  bool? isDarkShared = CacheHelper.getBool(key: "isDark") ?? false;
  //onboarding
  bool? onBoarding = CacheHelper.getBool(key: "onBoarding");
  //token
  token = CacheHelper.getString(key: "token") ?? "";
  
  print("main =>token after =>${token}");


  //where i go from any widget ???
  late Widget widget;
  if (onBoarding != null) {
    widget = LoginShop();
    if (token != null) {
      widget = ShopLayout();
    }
  } else {
    widget = OnBoarding();
  }

  //run app
  runApp(
    MyApp(
      isDark: isDarkShared,
      widget: widget,
    ),
  );
}

class MyApp extends StatelessWidget {
  bool isDark;
  Widget widget;
  MyApp({
    required this.isDark,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ShopCubit()..getDataHome(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeLight,
        darkTheme: themeLight,
        home: widget,
      ),
    );
  }
}
