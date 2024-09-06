import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../shared/network/local/cache_helper.dart';
import '../../../shared/styles/colors.dart';
import '../../shared/components/components.dart';
import '../login/shop_login_screen.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({required this.image, required this.title, required this.body});
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController boardController = PageController();

  final List<BoardingModel> boarding = [
    BoardingModel(
      title: 'On Board 1 Title',
      image: 'assets/images/onboard_1.png',
      body: 'On Board 1 Body',
    ),
    BoardingModel(
      title: 'On Board 2 Title',
      image: 'assets/images/onboard_1.png',
      body: 'On Board 2 Body',
    ),
    BoardingModel(
      title: 'On Board 3 Title',
      image: 'assets/images/onboard_1.png',
      body: 'On Board 3 Body',
    ),
  ];

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
            text: 'SKIP',
            onPressed: submit,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
                controller: boardController,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: defaultColor,
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 5,
                    expansionFactor: 4,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardController.nextPage(
                          duration: const Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: const Icon(
                    Icons.arrow_forward_ios,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void submit() {
    CacheHelper.saveData(
      key: 'onBoarding',
      value: true,
    ).then((value) {
      if (value) {
        navigateAndFinish(context, ShopLoginScreen());
      }
    });
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Image(
            image: AssetImage(model.image),
          )),
          const SizedBox(
            height: 30,
          ),
          Text(
            model.title,
            style: const TextStyle(
              fontSize: 24,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            model.body,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      );
}
