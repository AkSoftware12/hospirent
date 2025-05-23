import 'package:hospirent/constants.dart';
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

                      }),
                  _drawerItem(
                      icon: Icons.photo_library,
                      label: 'Gallery',
                      onTap: () {}),
                  _drawerItem(
                      icon: Icons.shopping_cart,
                      label: 'Cart',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const Cart(appBar: 'Cart')));
                      }),
                  _drawerItem(
                      icon: Icons.person, label: 'Profile', onTap: () {}),
                  _drawerItem(
                      icon: Icons.description,
                      label: 'Terms & Conditions',
                      onTap: () {}),
                  _drawerItem(
                      icon: Icons.privacy_tip,
                      label: 'Privacy Policy',
                      onTap: () {}),
                  _drawerItem(
                      icon: Icons.contact_mail,
                      label: 'Contact Us',
                      onTap: () {
                        UrlLaunch.makeEmail(
                            email: RawString.gitHubRepo,
                            body: 'Hello,',
                            subject: 'Can we talk?');
                      }),
                  _drawerItem(
                      icon: Icons.info_outline,
                      label: 'About App',
                      onTap: () {
                        Navigator.pop(context);
                        showAboutDialog(
                          context: context,
                          applicationName: RawString.appName,
                          applicationVersion: '1.0.0+1',
                        );
                      }),
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
