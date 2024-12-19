import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'logIn.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  Future<void> _logOut(BuildContext context) async {
    // Clear login state
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    // Navigate to login screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LogIn()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark().copyWith(
        textTheme: ThemeData.dark().textTheme.apply(fontFamily: 'Roboto'),
      ),
      child: Drawer(
        child: Container(
          color: Colors.black87,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                SizedBox(height: 20),
                Expanded(
                  child: _buildMenuItems(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget _buildHeader(BuildContext context) {
  //   return Container(
  //     padding: const EdgeInsets.all(16.0),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         _buildCloseButton(context),
  //         const SizedBox(height: 16),
  //         _buildLoginButton(context),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildHeader(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCloseButton(context),
          const SizedBox(height: 16),
          if(user == null) _buildLoginButton(context),
        ],
      ),
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: CircleAvatar(
        radius: 20,
        backgroundColor: Colors.white.withOpacity(0.1),
        child:
            const FaIcon(FontAwesomeIcons.xmark, color: Colors.white, size: 20),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton.icon(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => LogIn())),
        icon: const FaIcon(FontAwesomeIcons.rightToBracket, size: 18),
        label: const Text("Log In"),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Color(0xffbb0a1e),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
      ),
    );
  }

  Widget _buildMenuItems(BuildContext context) {
    return ListView(
      children: [
        _buildExpandableMenuItem(
          context,
          'Settings',
          FontAwesomeIcons.gear,
          [
            SubMenuItem('Account Settings', _showDevelopmentPopup),
            SubMenuItem('Notification Preferences', _showDevelopmentPopup),
            SubMenuItem('Privacy Settings', _showDevelopmentPopup),
            SubMenuItem('App Appearance', _showDevelopmentPopup),
          ],
        ),
        _buildExpandableMenuItem(
          context,
          'Help & Support',
          FontAwesomeIcons.circleQuestion,
          [
            SubMenuItem('FAQs', _showDevelopmentPopup),
            SubMenuItem('Contact Support', _showDevelopmentPopup),
            SubMenuItem('Report a Bug', _showDevelopmentPopup),
            SubMenuItem('Feature Request', _showDevelopmentPopup),
          ],
        ),
        _buildExpandableMenuItem(
          context,
          'About',
          FontAwesomeIcons.circleInfo,
          [
            SubMenuItem('App Version', _showDevelopmentPopup),
            SubMenuItem('Terms of Service', _showDevelopmentPopup),
            SubMenuItem('Privacy Policy', _showDevelopmentPopup),
            SubMenuItem('Licenses', _showDevelopmentPopup),
          ],
        ),
        _buildDrawerItem(context, 'Share', FontAwesomeIcons.shareNodes,
            _showDevelopmentPopup),
        _buildDrawerItem(
            context, 'Log Out', FontAwesomeIcons.rightFromBracket, _logOut),
      ],
    );
  }

  Widget _buildExpandableMenuItem(
    BuildContext context,
    String title,
    IconData icon,
    List<SubMenuItem> subItems,
  ) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        leading: FaIcon(icon, color: Colors.white70, size: 22),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        trailing: SizedBox.shrink(), // This removes the dropdown arrow icon
        children: subItems
            .map((subItem) => ListTile(
                  title: Text(
                    subItem.title,
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  onTap: () => subItem.onTap(context),
                  contentPadding: const EdgeInsets.only(left: 72, right: 24),
                ))
            .toList(),
        backgroundColor: Colors.transparent,
        collapsedBackgroundColor: Colors.transparent,
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, String title, IconData icon,
      Function(BuildContext) onTap) {
    return ListTile(
      leading: FaIcon(icon, color: Colors.white70, size: 22),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      onTap: () => onTap(context),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      hoverColor: Colors.white.withOpacity(0.1),
    );
  }

  void _showDevelopmentPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black87,
          title: const Text("Feature in Development",
              style: TextStyle(color: Colors.white)),
          content: const Text(
            "This feature is still being developed.",
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child:
                  const Text("OK", style: TextStyle(color: Color(0xffbb0a1e))),
            ),
          ],
        );
      },
    );
  }
}

class SubMenuItem {
  final String title;
  final Function(BuildContext) onTap;

  SubMenuItem(this.title, this.onTap);
}
