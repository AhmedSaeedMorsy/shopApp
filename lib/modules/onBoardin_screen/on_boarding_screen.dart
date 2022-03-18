// ignore_for_file: unnecessary_string_interpolations

import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/modules/login/login_screen.dart';
import 'package:shopapp/shared/componant/componant.dart';
import 'package:shopapp/shared/constant.dart';
import 'package:shopapp/shared/network/local/shared_pref.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScren extends StatefulWidget {
  const OnBoardingScren({Key? key}) : super(key: key);

  @override
  _OnBoardingScrenState createState() => _OnBoardingScrenState();
}

class BoardingModel {
  late final String image1;
  late final String title;
  late final String body;

  BoardingModel(this.body, this.image1, this.title);
}

class _OnBoardingScrenState extends State<OnBoardingScren> {
  var pageController = PageController();

  List<BoardingModel> boardigItem = [
    BoardingModel("body page 1", "assets/images/onBoarding_1.png", "Title page 1"),
    BoardingModel("body page 2", "assets/images/onBoarding_2.png", "Title page 2")
  ];

  bool isLast = false;

  void toLoginScreen(){
    CacheHelper.setData(key: 'onBoarding' ,value: true);
    navigatorPushAndReblace(context,  LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              toLoginScreen();
            },
            child: const Text('Skip',
                style: TextStyle(
                  color: mainColor,
                  
                  fontWeight: FontWeight.bold,
                )),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (index) {
                  if (index == boardigItem.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                physics: const BouncingScrollPhysics(),
                controller: pageController,
                itemBuilder: (context, index) =>
                    onBoardingItemUi(boardigItem[index]),
                itemCount: boardigItem.length,
              ),
            ),
            const SizedBox(
              height: 60.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count: boardigItem.length,
                  effect: const ExpandingDotsEffect(
                      activeDotColor: mainColor,
                      dotHeight: 6.0,
                      dotWidth: 6.0,
                      spacing: 4.0,
                      expansionFactor: 4.0),
                ),
                const Spacer(),
                ConditionalBuilderRec(
                  builder: (context) => Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: TextButton(
                      onPressed: () =>
                          toLoginScreen(),
                      child: const Text(
                        "Login",
                        style: TextStyle(
                            color: mainColor, fontSize: 18.0),
                      ),
                    ),
                  ),
                  condition: isLast == true,
                  fallback: (context) => FloatingActionButton(
                    onPressed: () => pageController.nextPage(
                      duration: const Duration(milliseconds: 700),
                      curve: Curves.easeOutQuad,
                    ),
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget onBoardingItemUi(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Image(
                    image: AssetImage("${model.image1}"),
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
              ],
            ),
          ),
          Text(
            "${model.title}",
            style: const TextStyle(
              fontSize: 24.0,
              color: Colors.white,
            ),
          ),
          Text(
            "${model.body}",
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.white,
            ),
          ),
        ],
      );

  
}
