import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var linearGradient = const BoxDecoration(
      gradient: LinearGradient(
        begin: FractionalOffset.centerRight,
        end: FractionalOffset.bottomLeft,
        colors: <Color>[
          Color(0xFF079CDA),
          Color(0xFFB0DEF7),
        ],
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: linearGradient,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              FriendDetailHeader(),
              Padding(
                padding: EdgeInsets.all(24.0),
                child: FriendDetailBody(),
              ),
              FriendShowcase(),
            ],
          ),
        ),
      ),
    );
  }
}

class FriendDetailHeader extends StatelessWidget {
  static const BACKGROUND_IMAGE = 'assets/profile_bg.png';

  const FriendDetailHeader({Key? key}) : super(key: key);

  Widget _buildDiagonalImageBackground(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return const DiagonallyCutColoredImage();
  }

  Widget _buildAvatar() {
    return const Hero(
      tag: 'avatarTag',
      child: CircleAvatar(
        backgroundImage: AssetImage('assets/profile_bg.png'),
        radius: 50.0,
      ),
    );
  }

  Widget _buildFollowerInfo(TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Text('100 Followers'),
        ],
      ),
    );
  }

  Widget _buildActionButtons(ThemeData theme) {
    return _createPillButton(
      'AVAILABLE',
      backgroundColor: Colors.green,
    );
  }

  Widget _createPillButton(
    String text, {
    Color backgroundColor = const Color.fromARGB(179, 57, 0, 189),
    Color textColor = const Color.fromARGB(179, 255, 255, 255),
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30.0),
      child: MaterialButton(
        minWidth: 150.0,
        height: 50,
        color: backgroundColor,
        textColor: textColor,
        onPressed: () {},
        child: Text(text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    return Stack(
      children: <Widget>[
        _buildDiagonalImageBackground(context),
        Align(
          alignment: FractionalOffset.bottomCenter,
          heightFactor: 1.4,
          child: Column(
            children: <Widget>[
              _buildAvatar(),
              const SizedBox(height: 10),
              _buildFollowerInfo(textTheme),
              const SizedBox(height: 10),
              _buildActionButtons(theme),
            ],
          ),
        ),
        const Positioned(
          top: 26.0,
          left: 4.0,
          child: BackButton(color: Color.fromARGB(255, 0, 0, 0)),
        ),
      ],
    );
  }
}

class DiagonallyCutColoredImage extends StatelessWidget {
  const DiagonallyCutColoredImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: DiagonalClipper(),
      child: DecoratedBox(
        position: DecorationPosition.foreground,
        decoration: const BoxDecoration(color: Color(0xFFF4FDFA)),
        child: Container(
          height: 280,
          width: double.infinity,
          color: const Color.fromARGB(255, 31, 13, 13),
        ),
      ),
    );
  }
}

class DiagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height - 50.0);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class FriendDetailBody extends StatelessWidget {
  const FriendDetailBody({Key? key}) : super(key: key);

  Widget _buildLocationInfo(TextTheme textTheme) {
    return Row(
      children: const <Widget>[
        Icon(
          Icons.place,
          color: Colors.white,
          size: 16.0,
        ),
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            'New Baneshwor, Kathmandu',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _createCircleBadge(IconData iconData, Color color) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: CircleAvatar(
        backgroundColor: color,
        radius: 16.0,
        child: Icon(
          iconData,
          color: const Color.fromARGB(255, 5, 5, 5),
          size: 16.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Astha Shrestha',
          style: Theme.of(context).textTheme.headline6,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: _buildLocationInfo(textTheme),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 16.0),
          child: Text(
            'Lorem Ipsum is simply dummy text of the printing and typesetting '
            'industry. Lorem Ipsum has been the industry\'s standard dummy '
            'text ever since the 1500s.',
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Row(
            children: <Widget>[
              _createCircleBadge(
                  Icons.beach_access, theme.colorScheme.secondary),
              _createCircleBadge(Icons.cloud, Colors.white12),
              _createCircleBadge(Icons.shop, Colors.white12),
            ],
          ),
        ),
      ],
    );
  }
}

class HistoryShowcase extends StatelessWidget {
  const HistoryShowcase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return const Center(
      child: Text(
        'Articles: TODO',
      ),
    );
  }
}

class FriendShowcase extends StatefulWidget {
  const FriendShowcase({Key? key}) : super(key: key);

  @override
  _FriendShowcaseState createState() => _FriendShowcaseState();
}

class _FriendShowcaseState extends State<FriendShowcase>
    with TickerProviderStateMixin {
  late List<Tab> _tabs;
  late List<Widget> _pages;
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _tabs = [
      const Tab(text: 'Portfolio'),
      const Tab(text: 'History'),
    ];
    _pages = [
      PortfolioShowcase(),
      const HistoryShowcase(),
    ];
    _controller = TabController(
      length: _tabs.length,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          TabBar(
            controller: _controller,
            tabs: _tabs,
            indicatorColor: Colors.white,
          ),
          SizedBox.fromSize(
            size: const Size.fromHeight(400.0),
            child: TabBarView(
              controller: _controller,
              children: _pages,
            ),
          ),
        ],
      ),
    );
  }
}

class PortfolioShowcase extends StatelessWidget {
  List<Widget> _buildItems() {
    var items = <Widget>[];

    for (var i = 1; i <= 10; i++) {
      var image = Image.asset(
        'assets/profile_bg.png',
        width: 200.0,
        height: 200.0,
      );

      items.add(image);
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    var delegate = const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      crossAxisSpacing: 8.0,
      mainAxisSpacing: 8.0,
    );

    return GridView(
      padding: const EdgeInsets.only(top: 16.0),
      gridDelegate: delegate,
      shrinkWrap: true,
      children: _buildItems(),
    );
    // return HomeMyWalletGoalCell(
    //   title: "Goal",
    //   goal: 100.0,
    //   change: 100.0,
    //   reached: 1,
    //   onPressed: () {},
    // );
  }
}
