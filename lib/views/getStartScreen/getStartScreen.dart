import 'package:flutter/material.dart';
import 'package:todo_app/utils/colorConstants.dart';
import 'package:todo_app/utils/imageConstants.dart';

import 'package:todo_app/views/loginScreen/welcomeScreen.dart';

class GetStartScreen extends StatefulWidget {
  @override
  _GetStartScreenState createState() => _GetStartScreenState();
}

class _GetStartScreenState extends State<GetStartScreen> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colorconstants.DarkThemeBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colorconstants.DarkThemeBackgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Welcomescreen(),
                      ));
                },
                child: Text(
                  'SKIP',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          onPageChanged: (page) {
            setState(() {
              _currentPage = page;
            });
          },
          children: [
            // Page 1
            GetstartWidget(
                image: Imageconstants.startimage1,
                text1: 'Manage your tasks',
                text2: 'You can easily manage all of your daily',
                text3: 'tasks in DoMe for free'),
            // Page 2

            GetstartWidget(
                image: Imageconstants.startimage2,
                text1: 'Create daily routine',
                text2: 'In Uptodo  you can create your',
                text3: 'personalized routine to stay productive'),
            // Page 3
            GetstartWidget(
                image: Imageconstants.startimage3,
                text1: 'Orgonaize your tasks',
                text2: 'You can organize your daily tasks by ',
                text3: 'adding your tasks into separate categories'),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _currentPage > 0
                ? InkWell(
                    onTap: () {
                      _pageController.previousPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease);
                    },
                    child: Text(
                      'Back',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  )
                : Container(
                    height: 1,
                  ),
            InkWell(
              onTap: () {
                if (_currentPage < 2) {
                  _pageController.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease);
                } else {
                  // Navigate to the next screen when "Get Start" is tapped
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Welcomescreen(),
                      ));
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: 45,
                child: Center(
                  child: Text(
                    _currentPage < 2 ? "NEXT" : "GET START",
                    style: TextStyle(
                        color: Colorconstants.DarkThemeTextColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                ),
                decoration: BoxDecoration(
                    color: Colorconstants.ThemeColor,
                    borderRadius: BorderRadius.circular(5)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class GetstartWidget extends StatelessWidget {
  const GetstartWidget(
      {super.key,
      required this.image,
      required this.text1,
      required this.text2,
      required this.text3});
  final String image;
  final String text1;
  final String text2;
  final String text3;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 10,
          ),
          Container(child: Image.asset(image)),
          SizedBox(
            height: 100,
          ),
          Text(
            text1,
            //'Manage your tasks',
            style: TextStyle(
                color: Colorconstants.DarkThemeTextColor,
                fontSize: 30,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 40,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                text2,
                //'You can easily manage all of your daily',
                style: TextStyle(
                    color: Colorconstants.DarkThemeTextColor,
                    fontSize: 17,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                text3,
                //'tasks in DoMe for free',
                style: TextStyle(
                    color: Colorconstants.DarkThemeTextColor,
                    fontSize: 17,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
