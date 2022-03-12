import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/components/components.dart';
import '../../shared/network/local/cashe_helper.dart';
import '../../shared/style/colors.dart';
import '../shop_login/login.dart';

class onBoardingClass {
  late String image;
  late String title;
  late String body;

  onBoardingClass({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoarding extends StatefulWidget {
  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  var pageController = PageController();

  List<onBoardingClass> listOnBoarding = [
    onBoardingClass(
      image: "assets/images/onBoarding/onBoard1.png",
      title: "onBoarding screen title 1",
      body: "onBoarding screen body 1",
    ),
    onBoardingClass(
      image: "assets/images/onBoarding/onBoard1.png",
      title: "onBoarding screen title 2",
      body: "onBoarding screen body 2",
    ),
    onBoardingClass(
      image: "assets/images/onBoarding/onBoard1.png",
      title: "onBoarding screen title 3",
      body: "onBoarding screen body 3",
    ),
  ];

  bool isLast = false;

  submit() {
    CacheHelper.setData(key: "onBoarding", value: true).then((value) {
      if (value) {
        print(value);
        navigateToRemove(
          context: context,
          Widget: LoginShop(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              submit();
            },
            child: Text(
              "Skip",
              style: TextStyle(
                color: defaultColor,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: pageController,
                pageSnapping: true,
                onPageChanged: (value) {
                  if (value == listOnBoarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (BuildContext context, int index) =>
                    defaultOnBoarding(
                  listOnBoarding[index],
                ),
                itemCount: listOnBoarding.length,
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count: listOnBoarding.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotWidth: 10,
                    dotHeight: 10,
                    spacing: 5.0,
                    expansionFactor: 4,
                    activeDotColor: defaultColor,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    pageController.nextPage(
                      //تنقل
                      duration: Duration(seconds: 1),
                      //شكل التنقل
                      curve: Curves.fastLinearToSlowEaseIn,
                    );
                    if (isLast == true) {
                      submit();
                    }
                  },
                  child: Icon(
                    Icons.chevron_right_rounded,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget defaultOnBoarding(onBoardingClass model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          model.image,
        ),
        SizedBox(
          height: 70.0,
        ),
        Text(
          model.title,
          style: TextStyle(
              fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          model.body,
          style: TextStyle(
            fontSize: 14.0,
          ),
        ),
      ],
    );
  }
}
