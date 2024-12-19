import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'drawer.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final VoidCallback toggleDrawer;

  const CustomAppBar({
    super.key,
    required this.scaffoldKey,
    required this.toggleDrawer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,  // Use preferredSize for height
      width: double.infinity,
      decoration: _buildGradientDecoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildAppTitle(),
          _buildUserAvatar(context),
        ],
      ),
    );
  }

  Widget _buildAppTitle() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: RichText(
        text: const TextSpan(
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w500,
            color: Color(0xffbb0a1e),
            fontFamily: 'Splash_font',
          ),
          children: <TextSpan>[
            TextSpan(text: 'T'),
            TextSpan(
                text: 'rain ',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                )),
            TextSpan(text: 'H'),
            TextSpan(
                text: 'ard',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildUserAvatar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: InkWell(
        child: const CircleAvatar(
          radius: 25.0,
          child: FaIcon(FontAwesomeIcons.user),
        ),
        splashColor: Colors.blue,
        highlightColor: Colors.green,
          onTap: toggleDrawer,
      ),
    );
  }

  BoxDecoration _buildGradientDecoration({bool isRounded = true}) {
    return BoxDecoration(
      borderRadius: isRounded
          ? const BorderRadius.only(
        topLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      )
          : null,
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xff414141), Color(0xFF1A1A1A)],
      ),
    );
  }

  // Override preferredSize to provide a fixed height for the app bar
  @override
  Size get preferredSize => const Size.fromHeight(100);  // Use 100 as the height
}
