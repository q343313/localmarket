

import '../../allpaths.dart';
import '../../config/components/signupwidgets.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Terms & Conditions"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Scrollbar(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Heading
                  Text(
                    "Welcome to SnapSell!",
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                      fontFamily: "heading"
                    ),
                  ),
                  const SizedBox(height: 12),
                  buildsubtitlewidget("Please read these Terms & Conditions carefully before using the SnapSell app. By using our services, you agree to follow these terms.", width),
                  const SizedBox(height: 24),
                  buildheadingwidget( "1. Account Registration", width,18),
                  const SizedBox(height: 8),
                  buildsubtitlewidget( "• Users must create an account with accurate information.\n"
                      "• You are responsible for maintaining your account security.\n"
                      "• SnapSell is not liable for unauthorized account use.", width),
                  const SizedBox(height: 24),
                  buildheadingwidget("2. Product Listings", width,18),
                  const SizedBox(height: 8),
                  buildsubtitlewidget( "• Only legal items are allowed to be listed.\n"
                      "• You must provide clear and honest product descriptions.\n"
                      "• SnapSell reserves the right to remove inappropriate listings.", width),
                  const SizedBox(height: 24),
                  buildheadingwidget( "3. Payments & Transactions", width,18),
                  const SizedBox(height: 8),
                  buildsubtitlewidget("• SnapSell does not handle payments directly.\n"
                      "• Users must ensure safe and secure transactions.\n"
                      "• SnapSell is not responsible for disputes between buyers and sellers.", width),
                  const SizedBox(height: 24),
                  buildheadingwidget( "4. User Conduct", width,18),
                  const SizedBox(height: 8),
                  buildsubtitlewidget( "• Respect other users and avoid abusive behavior.\n"
                      "• Do not use SnapSell for illegal activities.\n"
                      "• Any violation may result in account suspension.", width),
                  const SizedBox(height: 24),
                  buildheadingwidget( "5. Changes to Terms", width,18),
                  const SizedBox(height: 8),
                  buildsubtitlewidget( "• SnapSell may update these Terms at any time.\n"
                      "• Continued use of the app means you accept the updated Terms.", width),
                  const SizedBox(height: 24),

                  // Section 6
                  buildheadingwidget( "6. Contact Us", width,18),
                  const SizedBox(height: 8),
                  buildsubtitlewidget(  'If you have questions about these Terms & Conditions, please contact us at: "talhaafridishah@gmail.com" or  "+923182586785"' , width),
                  const SizedBox(height: 32),
                  buildbackelevatedbutton(context),
                  SizedBox(height: 30,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



Widget buildbackelevatedbutton(BuildContext context,){
  return Center(
    child: ElevatedButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text(
        "Accept & Continue",
        style: TextStyle(fontSize: 16, color: Colors.white,fontFamily: "title"),
      ),
    ),
  );
}