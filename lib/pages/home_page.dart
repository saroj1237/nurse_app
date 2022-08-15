import 'package:flutter/material.dart';
import 'package:nurse_app/utils/my_theme.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(

//       body: Center(
//           child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Text("Home page"),
//           ElevatedButton(
//               onPressed: () {
//                 context.read<AuthCubit>().logOut();
//               },
//               child: const Text("Logout")),
//           ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                     context,
//                     CupertinoPageRoute(
//                         builder: (context) => const ProfilePage()));
//               },
//               child: const Text("Profile")),
//         ],
//       )),
//     );
//   }
// }

class Food {
  final String name;
  final String username;
  final String image;
  bool isFollowedByMe;

  Food(
    this.name,
    this.username,
    this.isFollowedByMe, {
    this.image = 'Nursing',
  });
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Food> _users = [
    Food('New Baneshwor, ktm ', '10am-2pm(4 hours)', false),
    Food('Old Baneshwor, ktm', '10am-2pm(4 hours)', false),
    Food('Kathleen Mcdonough', '10am-2pm(4 hours)', false),
    Food('Lalitpur', '10am-2pm(4 hours)', false),
    Food('Bhaktapur', '7am-12pm(5 hours)', false),
    Food('Pokhara lakeside', '10am-2pm(4 hours)', false),
    Food('Butwal new road', '@metz', false),
    Food('Old Baneshwor, ktm', '10am-2pm(4 hours)', false),
    Food('Old Baneshwor, ktm', '10am-2pm(4 hours)', false),
    Food('Gandaki New road kathmandu. ', '10am-2pm(4 hours)', false),
    Food('Old Baneshwor, ktm', '10am-2pm(4 hours)', false),
    Food('Old Baneshwor, ktm', '10am-2pm(4 hours)', false),
    Food('Gandaki New road kathmandu. ', '10am-2pm(4 hours)', false),
    Food('Old Baneshwor, ktm', '10am-2pm(4 hours)', false),
    Food('Old Baneshwor, ktm', '10am-2pm(4 hours)', false),
    Food('Gandaki New road kathmandu. ', '10am-2pm(4 hours)', false)
  ];

  List<Food> _foundedUsers = [];

  @override
  void initState() {
    super.initState();

    setState(() {
      _foundedUsers = _users;
    });
  }

  onSearch(String search) {
    setState(() {
      _foundedUsers = _users
          .where((user) => user.name.toLowerCase().contains(search))
          .toList();
    });
  }

  reset() {
    setState(() {
      _foundedUsers = _users;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.5,
        backgroundColor: MyTheme.themeColor,
        title: Container(
          height: 55,
          alignment: Alignment.center,
          child: TextField(
            onChanged: (value) => onSearch(value),
            decoration: InputDecoration(
              filled: true,
              fillColor: MyTheme.themeColor,
              contentPadding: const EdgeInsets.all(0),
              prefixIcon: const Icon(
                Icons.search,
                color: Color.fromARGB(255, 226, 226, 226),
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none),
              hintStyle: const TextStyle(
                  fontSize: 14, color: Color.fromARGB(255, 245, 245, 245)),
              hintText: "Search available jobs",
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Availabel jobs",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "View all",
                    ),
                  )
                ],
              ),
            ),
            ListView.builder(
              itemCount: _foundedUsers.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return userComponent(
                  user: _foundedUsers[index],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  userComponent({required Food user}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            // SizedBox(
            //     width: 60,
            //     height: 60,
            //     child: ClipRRect(
            //       borderRadius: BorderRadius.circular(50),
            //       child: Image.network(user.image),
            //     )),
            // const SizedBox(width: 10),

            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                user.name,
                style: const TextStyle(
                  // color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(user.username, style: TextStyle(color: Colors.grey[500])),
              const SizedBox(
                height: 5,
              ),
              Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.green[300],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    user.image,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  )),
            ])
          ]),
          GestureDetector(
            onTap: () {
              setState(() {
                user.isFollowedByMe = !user.isFollowedByMe;
              });
            },
            child: AnimatedContainer(
              height: 35,
              width: 110,
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                  color: user.isFollowedByMe
                      ? const Color.fromARGB(255, 140, 231, 211)
                      : const Color(0x00ffffff),
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: user.isFollowedByMe
                        ? Colors.transparent
                        : const Color.fromARGB(255, 196, 196, 196),
                  )),
              child: Center(
                child: Text(
                  user.isFollowedByMe ? 'Requested' : 'Request',
                  style: const TextStyle(
                      // color: user.isFollowedByMe ? Colors.white : Colors.white,
                      ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
