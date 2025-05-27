import 'package:hospirent/constants.dart';
import '../../../../main.dart';
import '../../../DrawerScreen/ContactUs.dart';
import '../../../DrawerScreen/privacy.dart';
import '../../../DrawerScreen/terms.dart';
import '../../../Profile/profile.dart';
import '../../const/raw_string.dart';
import '../../imports.dart';
import '../../utils/url_launch.dart';
import '../../widgets/app_name_widget.dart';
import '../../widgets/text/text_builder.dart';
import '../cart/cart.dart';
import '../home/home.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({super.key});

  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: AppColors.primary,
        child: Column(
          children: [
            // Top Header: Full width
            Container(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              color: Colors.blue.shade800,
              width: double.infinity,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(RawString.appLogoURL),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextBuilder(
                          text: RawString.appName,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 6),
                        TextBuilder(
                          text: RawString.dummyEmail,
                          fontSize: 14.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.white70,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Menu Items: take full remaining space
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _drawerItem(
                      icon: Icons.dashboard,
                      label: 'Dashboard',
                      onTap: () {
                        Navigator.pop(context);
                      }),
                  _drawerItem(
                      icon: Icons.article,
                      label: 'Blogs',
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MainScreen(initialIndex: 1,)));


                      }),
                  _drawerItem(
                      icon: Icons.photo_library,
                      label: 'Gallery',
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MainScreen(initialIndex: 2,)));

                      }),
                  _drawerItem(
                      icon: Icons.shopping_cart,
                      label: 'Cart',
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MainScreen(initialIndex: 3,)));

                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (_) => const Cart(appBar: 'Cart')));
                      }),
                  _drawerItem(
                      icon: Icons.person, label: 'Profile', onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MainScreen(initialIndex: 4,)));

                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (_) => const ProfileScreen(appBar: 'Profile')));
                  }),
                  _drawerItem(
                      icon: Icons.description,
                      label: 'Terms & Conditions',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TermsAndConditionsScreen(
                              lastUpdated: 'May 27, 2025',
                              version: '1.0.0',
                              sections:[
                                {
                                  "title": "1. Introduction",
                                  "content": "Welcome to our application. By using our services, you agree to these Terms and Conditions. Please read them carefully. These terms govern your access to and use of our platform, including any content, functionality, and services offered."
                                },
                                {
                                  "title": "2. User Responsibilities",
                                  "content": "You are responsible for maintaining the confidentiality of your account and password. You agree to accept responsibility for all activities that occur under your account. You must notify us immediately of any unauthorized use of your account."
                                },
                                {
                                  "title": "3. Prohibited Activities",
                                  "content": "You may not use our services for any illegal or unauthorized purpose. This includes, but is not limited to, violating any applicable laws, transmitting harmful code, or engaging in activities that interfere with the operation of our services."
                                },
                                {
                                  "title": "4. Intellectual Property",
                                  "content": "All content provided through our services, including text, graphics, logos, and software, is the property of the company or its licensors and is protected by intellectual property laws. You may not reproduce, distribute, or create derivative works without permission."
                                },
                                {
                                  "title": "5. Termination",
                                  "content": "We reserve the right to terminate or suspend your account at our sole discretion, without prior notice, for conduct that we believe violates these Terms or is harmful to other users or third parties."
                                },
                                {
                                  "title": "6. Rental Service and Non-Refundable Policy",
                                  "content": "Our application offers a rental service for products such as furniture, equipment, or vehicles ('Rental Products'). By renting products through our platform, you agree to the following conditions, including a strict non-refundable policy for all payments: 1. All rental payments, including fees and deposits, are non-refundable unless otherwise stated in writing by us. 2. You must provide valid identification (e.g., Aadhaar, passport, or driver’s license) at the time of booking, which will be verified before product delivery. 3. A refundable security deposit is required, which will be returned within 7-10 business days after the rental period, subject to a quality check confirming no damage to the product. 4. You are responsible for returning the Rental Product in the same condition as received, excluding normal wear and tear; any damage will result in deduction from the security deposit. 5. The minimum rental period is three months, and early termination does not entitle you to a refund of rental fees. 6. You must not sublet, transfer, or allow unauthorized use of the Rental Product by third parties. 7. Products must be used only for their intended purpose and in compliance with all applicable laws and regulations. 8. Late returns will incur a penalty fee of 10% of the daily rental rate per day, deducted from the security deposit. 9. You are responsible for any additional costs, such as cleaning fees (minimum INR 200) if the product is returned in poor condition, or repair costs for damages caused by misuse. 10. We reserve the right to cancel your rental booking if you fail to meet eligibility requirements (e.g., valid ID, payment, or credit check), with no refund of any prepaid amounts. 11. Delivery and pickup of Rental Products are subject to availability and may incur additional fees if your location lacks elevator access or requires special handling. 12. You must notify us at least 48 hours in advance for any changes to the rental agreement, such as extending the rental period; failure to do so may result in additional charges or forfeiture of the rental. These terms ensure a fair and efficient rental process for all users."
                                },
                                {
                                  "title": "7. Payment Terms",
                                  "content": "All payments for rental services must be made through the approved payment methods on our platform. You agree to provide accurate billing information and authorize us to charge the specified amounts. Late payments may result in additional fees or suspension of services."
                                },
                                {
                                  "title": "8. Limitation of Liability",
                                  "content": "To the fullest extent permitted by law, we are not liable for any indirect, incidental, or consequential damages arising from your use of our services, including loss of profits, data, or property damage, even if advised of the possibility of such damages."
                                },
                                {
                                  "title": "9. Privacy Policy",
                                  "content": "We collect and process personal information in accordance with our Privacy Policy. By using our services, you consent to the collection, use, and sharing of your data as outlined therein, including for verification and service delivery purposes."
                                },
                                {
                                  "title": "10. Governing Law",
                                  "content": "These Terms and Conditions are governed by the laws of India. Any disputes arising under these terms will be subject to the exclusive jurisdiction of the courts located in [Your City], India."
                                }
                              ],

                            ),
                          ),
                        );

                      }),
                  _drawerItem(
                      icon: Icons.privacy_tip,
                      label: 'Privacy Policy',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const PrivacyPage()));

                      }),
                  _drawerItem(
                      icon: Icons.contact_mail,
                      label: 'Contact Us',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ContactUsPage()));
                      }),
                  // _drawerItem(
                  //     icon: Icons.info_outline,
                  //     label: 'About App',
                  //     onTap: () {
                  //       Navigator.pop(context);
                  //       showAboutDialog(
                  //         context: context,
                  //         applicationName: RawString.appName,
                  //         applicationVersion: '1.0.0+1',
                  //       );
                  //     }),
                  _drawerItem(
                      icon: Icons.logout,
                      label: 'Logout',
                      onTap: () {
                        Navigator.pop(context);
                        // your logout logic here
                      }),
                ],
              ),
            ),

            // Bottom Footer: Full width
            Container(
              width: double.infinity,
              color: Colors.blueGrey.shade900,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              child: Column(
                children: [
                  const AppNameWidget(),
                  const SizedBox(height: 6),
                  TextBuilder(
                    text: RawString.appDescription,
                    fontSize: 12,
                    color: Colors.white70,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem(
      {required IconData icon,
      required String label,
      required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: TextBuilder(
        text: label,
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      horizontalTitleGap: 10,
    );
  }
}
