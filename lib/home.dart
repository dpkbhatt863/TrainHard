import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'app_bar.dart';
//import 'nav.dart';
import 'gradient_button.dart';
import 'drawer.dart';
import 'bmi.dart';
import 'progress.dart';
import 'user_info.dart';
import 'diet_info.dart';

class MyHomePage extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final VoidCallback toggleDrawer;

  const MyHomePage({
    Key? key,
    required this.scaffoldKey,
    required this.toggleDrawer,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  bool _isFirstContainerExpanded = false;
  bool _isSecondContainerExpanded = false;
  late AnimationController _firstController;
  late AnimationController _secondController;
  late Animation<double> _firstIconTurns;
  late Animation<double> _secondIconTurns;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _firstController = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    _secondController = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    _firstIconTurns = Tween<double>(begin: 0.0, end: 0.25).animate(_firstController);
    _secondIconTurns = Tween<double>(begin: 0.0, end: 0.25).animate(_secondController);
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _firstController.dispose();
    _secondController.dispose();
    super.dispose();
  }

  void _toggleExpand(int containerIndex) {
    setState(() {
      if (containerIndex == 0) {
        _isFirstContainerExpanded = !_isFirstContainerExpanded;
        _isFirstContainerExpanded ? _firstController.forward() : _firstController.reverse();
      } else {
        _isSecondContainerExpanded = !_isSecondContainerExpanded;
        _isSecondContainerExpanded ? _secondController.forward() : _secondController.reverse();
      }
    });
  }

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProgressScreen()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BMIScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: CustomAppBar(
        scaffoldKey: scaffoldKey,
        toggleDrawer: () => scaffoldKey.currentState?.openEndDrawer(),
      ),
      endDrawer: Drawer(
        child: MenuScreen(),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(child: _buildListView()),
        ],
      ),
    );
  }

  Widget _buildListView() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            _buildExpandableContainer(
              index: 0,
              content: _buildFirstContainerContent(),
              isExpanded: _isFirstContainerExpanded,
            ),
            const SizedBox(height: 20),
            _buildExpandableContainer(
              index: 1,
              content: _buildSecondContainerContent(),
              isExpanded: _isSecondContainerExpanded,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandableContainer({
    required int index,
    required Widget content,
    required bool isExpanded,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: _buildCardDecoration(),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: content,
      ),
    );
  }

  Widget _buildFirstContainerContent() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildContainerHeader(
            title: 'WORKOUT PLANS',
            description: 'Discover personalized workout plans tailored to your fitness goals.',
            imagePath: 'assets/images/workout.jpg',
            onTap: () => _toggleExpand(0),
            iconTurns: _firstIconTurns,
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: _isFirstContainerExpanded
                ? Column(
              children: [
                const SizedBox(height: 20),
                _buildExpandedContent(),
              ],
            )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildSecondContainerContent() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildContainerHeader(
            title: 'DIET PLANS',
            description: 'Discover personalized diet plans tailored to your fitness goals.',
            imagePath: 'assets/images/diet.jpg',
            onTap: () => _toggleExpand(1),
            iconTurns: _secondIconTurns,
            isReversed: true,
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: _isSecondContainerExpanded
                ? Column(
              children: [
                const SizedBox(height: 20),
                _buildExpandedContentForDiet(),
              ],
            )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildContainerHeader({
    required String title,
    required String description,
    required String imagePath,
    required VoidCallback onTap,
    required Animation<double> iconTurns,
    bool isReversed = false,
  }) {
    final textColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            fontFamily: 'manteka',
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 15),
        Text(
          description,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white70,
            fontFamily: 'FOne',
            height: 1.5,
          ),
        ),
        const SizedBox(height: 15),
        GestureDetector(
          onTap: onTap,
          child: RotationTransition(
            turns: iconTurns,
            child: const FaIcon(FontAwesomeIcons.arrowRightFromBracket, color: Colors.white),
          ),
        ),
      ],
    );

    final imageWidget = Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(imagePath, height: 200, fit: BoxFit.cover),
      ),
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: isReversed
          ? [imageWidget, const SizedBox(width: 20), Expanded(child: textColumn)]
          : [Expanded(child: textColumn), const SizedBox(width: 20), imageWidget],
    );
  }

  Widget _buildExpandedContent() {
    return Column(
      children: [
        GradientButton(
          text: 'Start Workout',
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => UserInfoScreen()),
            );
          },
          horizontalPadding: 60,
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget _buildExpandedContentForDiet() {
    return Column(
      children: [
        GradientButton(
          text: 'Diet Planning',
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => DietInfoScreen()),
            );
          },
          horizontalPadding: 60,
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  BoxDecoration _buildCardDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xff414141), Color(0xFF1A1A1A)],
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ],
    );
  }
}