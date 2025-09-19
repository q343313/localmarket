import 'package:introduction_screen/introduction_screen.dart';
import 'package:localmarket/allpaths.dart';

class IntroScreens extends StatelessWidget {
  IntroScreens({super.key});

  final introkey = GlobalKey<IntroductionScreenState>();

  @override
  Widget build(BuildContext context) {
    final bodyStyle = TextStyle(
      fontSize: 18,
      fontFamily: "body_c",
      color: Colors.black87,
    );

    final titleStyle = TextStyle(
      fontSize: 26,
      fontFamily: "title",
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );

    final pageDecoration = PageDecoration(
      titleTextStyle: titleStyle,
      bodyTextStyle: bodyStyle,
      bodyPadding: const EdgeInsets.all(16.0),
      imagePadding: const EdgeInsets.only(top: 40),
      pageColor: Colors.transparent,
    );

    return IntroductionScreen(
      key: introkey,
      globalBackgroundColor: Colors.white,
      allowImplicitScrolling: true,
      autoScrollDuration: 3000,
      infiniteAutoScroll: true,
      pages: [
        _buildPage(
          image: "assets/images/pngegg (12).png",
          title: "Create & Manage Your Account",
          body:
          "Start your journey by creating your personal account. Update your profile, manage your details, and keep everything organized in one place.",
          pageDecoration: pageDecoration,
          gradient: [Colors.blueAccent, Colors.lightBlue.shade100],
        ),
        _buildPage(
          image: "assets/images/pngegg (13).png",
          title: "Buy & Sell Products Easily",
          body:
          "Add your products with images and prices, explore local listings, and connect with buyers or sellers just like a real marketplace.",
          pageDecoration: pageDecoration,
          gradient: [Colors.purpleAccent, Colors.pink.shade100],
        ),
        _buildPage(
          image: "assets/images/pngegg (14).png",
          title: "Stay Connected & Secure",
          body:
          "Chat with other shop owners, get instant notifications for updates, and enjoy a safe & secure shopping experience with privacy controls.",
          pageDecoration: pageDecoration,
          gradient: [Colors.orangeAccent, Colors.amber.shade100],
        ),
      ],
      onDone: () =>
          Navigator.pushReplacementNamed(context, RouteNames.signupscreen),
      onSkip: () =>
          Navigator.pushReplacementNamed(context, RouteNames.signupscreen),
      showSkipButton: true,
      skip: const Text("Skip",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
      next: const Icon(Icons.arrow_forward_ios, color: Colors.black87),
      done: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [Colors.blueAccent, Colors.lightBlue]),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Text(
          "Get Started",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      curve: Curves.fastLinearToSlowEaseIn,
      dotsDecorator: DotsDecorator(
        size: const Size(12, 12),
        color: Colors.grey.shade400,
        activeSize: const Size(28, 12),
        activeColor: Colors.blueAccent,
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );
  }

  PageViewModel _buildPage({
    required String image,
    required String title,
    required String body,
    required PageDecoration pageDecoration,
    required List<Color> gradient,
  }) {
    return PageViewModel(
      decoration: pageDecoration,
      titleWidget: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, blurRadius: 10, offset: Offset(0, 5))
          ],
        ),
        child: Text(title,
            textAlign: TextAlign.center, style: pageDecoration.titleTextStyle),
      ),
      bodyWidget: Container(
        margin: const EdgeInsets.only(top: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(body,
            textAlign: TextAlign.center, style: pageDecoration.bodyTextStyle),
      ),
      image: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: gradient),
          borderRadius: BorderRadius.circular(200),
        ),
        padding: const EdgeInsets.all(20),
        child: Image.asset(image, width: 220, height: 220, fit: BoxFit.contain),
      ),
    );
  }
}
