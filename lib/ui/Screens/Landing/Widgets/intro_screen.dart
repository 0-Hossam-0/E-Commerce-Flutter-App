import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

final GlobalKey<IntroductionScreenState> introKey =
    GlobalKey<IntroductionScreenState>();

class IntroPage extends StatelessWidget {
  final Function(int) onPageChange;
  const IntroPage({Key? key, required this.onPageChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      allowImplicitScrolling: true,
      autoScrollDuration: 5000,
      infiniteAutoScroll: true,
      onChange: onPageChange, // Notify parent when the page changes
      globalHeader: Align(
        alignment: Alignment.topRight,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 16, right: 16),
          ),
        ),
      ),
      globalFooter: SizedBox(
        width: double.infinity,
      ),
      pages: [
        PageViewModel(
          image: Image.asset('assets/images/intro1.png'),
          titleWidget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80),
            child: Text(
              textAlign: TextAlign.center,
              'Find Items What You Are Looking For',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Color(0xFF3347C4),
                fontSize: 20,
              ),
            ),
          ),
          bodyWidget: Text(
            'Various available goods you need.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromARGB(250, 159, 159, 159),
            ),
          ),
        ),
        PageViewModel(
          image: Image.asset('assets/images/intro2.png'),
          titleWidget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80),
            child: Text(
              textAlign: TextAlign.center,
              'Add Quantity Selected Items',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Color(0xFF3347C4),
                fontSize: 20,
              ),
            ),
          ),
          bodyWidget: Text(
            'You can add the number of items.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromARGB(250, 159, 159, 159),
            ),
          ),
        ),
        PageViewModel(
          image: Image.asset('assets/images/intro3.png'),
          titleWidget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80),
            child: Text(
              textAlign: TextAlign.center,
              'Save Items Into Basket',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Color(0xFF3347C4),
                fontSize: 20,
              ),
            ),
          ),
          bodyWidget: Text(
            'Can save items in your cart.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromARGB(250, 159, 159, 159),
            ),
          ),
        ),
      ],
      // We're using our custom button so we don't need the built-in ones.
      overrideDone: const SizedBox.shrink(),
      overrideNext: const SizedBox.shrink(),
      controlsPosition: Position(
          top: MediaQuery.sizeOf(context).height * 0.75,
          bottom: 0,
          left: 0,
          right: 0),
      curve: Curves.fastLinearToSlowEaseIn,
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(25, 7),
        activeColor: Color(0xFF7888F2),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
