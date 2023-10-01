import 'package:dots_indicator/dots_indicator.dart';
import 'package:e_commerce_app/screens/Register/view/Register_screen_body.dart';
import 'package:e_commerce_app/screens/login/view/login_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  PageController controller = PageController();
  int _totalDots = 3;
  double _currentPosition = 0.0;

  double _validPosition(double position) {
    if (position >= _totalDots) return 0;
    if (position < 0) return _totalDots - 1.0;
    return position;
  }

  void _updatePosition(int position) {
    setState(() => _currentPosition = _validPosition(position.toDouble()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller,
            onPageChanged: _updatePosition,
            children: [
              OnboardingScreen(
                Image.asset(
                  'assets/img/Bibliophile-rafiki.png',
                ),
                [
                  Text(
                    "You Need A Library",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF174068).withOpacity(0.8),
                      letterSpacing: 0.3,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10), // Added space for subtitle
                  Text(
                    "Discover your passion, explore new interests",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey, // Subtitle text color
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
                ],
              ),
              OnboardingScreen(
                Image.asset('assets/img/Ebook-bro.png'),
                [
                  Text(
                    "Choose Expertise",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF174068).withOpacity(0.8),
                      letterSpacing: 0.3,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10), // Added space for subtitle
                  Text(
    "Discover a wide range of topics and subjects that pique your interest. Whether it's science, technology, literature, or any other field, our app offers a diverse selection of eBooks and resources to cater to your expertise.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey, // Subtitle text color
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                ],
              ),
              OnboardingScreen(
                Image.asset('assets/img/Ebook-rafiki.png'),
                [
                  Text(
                    "Start Reading Now",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF174068).withOpacity(0.8),
                      letterSpacing: 0.3,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10), // Added space for subtitle
                  Text(
                    "Access thousands of Books",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey, // Subtitle text color
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen()),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(HexColor("#174068")), // Background color
                          overlayColor: MaterialStateProperty.all(HexColor("#174068")), // Color when pressed
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0), // Rounded corners
                            ),
                          ),
                          padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 16, horizontal: 24)), // Padding
                          side: MaterialStateProperty.all(
                            BorderSide(
                              color: HexColor("#174068"), // Border color
                              width: 2.0, // Border width
                            ),
                          ),
                        ),
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Text color
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RegisterScreen()),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(HexColor("#174068")), // Background color
                          overlayColor: MaterialStateProperty.all(HexColor("#174068")), // Color when pressed
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0), // Rounded corners
                            ),
                          ),
                          padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 16, horizontal: 24)), // Padding
                          side: MaterialStateProperty.all(
                            BorderSide(
                              color: HexColor("#174068"), // Border color
                              width: 2.0, // Border width
                            ),
                          ),
                        ),
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Text color
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: DotsIndicator(
              dotsCount: 3,
              position: _currentPosition,
              onTap: (double page) {
                setState(() {
                  controller.animateToPage(page.toInt(), duration: Duration(milliseconds: 300), curve: Curves.ease);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingScreen extends StatelessWidget {
  final Widget? image;
  final List<Widget> text;

  const OnboardingScreen(this.image, this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // Set the background color to white
      child: Column(
        children: [
          if (image != null)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Card(
                  elevation: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white, // Background color of the card
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: Offset(0, 3), // changes the position of shadow
                        ),
                      ],
                    ),
                    child: image!,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              flex: 2,
            ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: text,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
