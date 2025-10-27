import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:todo_app_2/constants/color.dart';
import 'package:todo_app_2/screens/home.dart';
import 'package:flutter/services.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = PageController();
  int currentPage = 0;
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appbar
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Container(
          margin: EdgeInsets.only(left: 10, top: 10),
          child: Text(
            'Tiko',
            style: TextStyle(
              fontSize: 38,
              fontWeight: FontWeight.bold,
              color: HexColor(buttonColor),
            ),
          ),
        ),
      ),

      //body
      body: Container(
        padding: EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() {
              currentPage = index;
              isLastPage = index == 2;
            });
          },
          children: [
            buildPage(
              path: 'lib/assets/images/firstScreen.png',
              subtitle:
                  'Günlük aktivitelerini kolayca organize ederek maksimum verimliliğe ulaş',
              title: 'Planlamaya Başla',
            ),
            buildPage(
              path: 'lib/assets/images/thirdScreen.png',
              subtitle:
                  'Önceliklerinizi aklınızda tutmanızı sağlayacak hatırlatıcılar ayarlayın',
              title: 'Hatırlatıcılar Kur',
            ),
            buildPage(
              path: 'lib/assets/images/fourthScreen.png',
              subtitle: 'Notlar alın ve önemli yapılacaklar listesi hazırlayın',
              title: 'Notlarını Al',
            ),
          ],
        ),
      ),

      //alt bar
      bottomSheet: isLastPage
          ? Container(
              width: double.infinity,
              height: 80,
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 20),

              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(50),
                  ),
                ),
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setBool('showHome', true);
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
                child: Text(
                  'Başla',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                ),
              ),
            )
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              color: Colors.white,
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => controller.jumpToPage(2),
                    child: Text(
                      'Geç',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 21,
                      ),
                    ),
                  ),
                  Center(
                    child: SmoothPageIndicator(
                      controller: controller,
                      count: 3,
                      onDotClicked: (index) => controller.animateToPage(
                        index,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => controller.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                    ),
                    child: Text(
                      'İleri',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 21,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  //orta ekran
  Widget buildPage({
    required String path,
    required String subtitle,
    required String title,
  }) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          //image
          Expanded(flex: 4, child: Image.asset(path, scale: 1.1)),

          //title
          Expanded(
            flex: 1,
            child: Center(
              child: currentPage == 0
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Tiko",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: HexColor(buttonColor),
                          ),
                        ),
                        Text(
                          "'ya hoş geldin!",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  : Text(
                      title,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),

          //subtitle
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 0, right: 0),
              child: Text(
                subtitle,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
