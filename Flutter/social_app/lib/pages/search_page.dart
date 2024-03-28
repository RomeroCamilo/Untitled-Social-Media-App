import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../database/user_info.dart';
import '../database/database_services.dart';
import 'package:social_app/pages/other_profile_page.dart';
import '../pages/profile_page.dart';
import 'package:social_app/navbar/body_view.dart';

// This makes the widget stateful
class SearchPage extends StatefulWidget {
  SearchPage({super.key});
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final List<Map<String, dynamic>> searchUsers = [];
  /* store out input */
  final TextEditingController _textEditingController = TextEditingController();

  User_Info? user_info; // This will store the fetched user data
  String username = "";
  String user_id_fetched = "";

/* handle event of function clicked */
  void _handleButtonClick(BuildContext context) async {
    String searchText = _textEditingController.text;

    /* attempt to search user where is input is not empty */
    if (searchText.isNotEmpty) {
      /* search for user in database */
      await searchExist(searchText);

      /* if no user found */
      if (username.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$searchText not found'),
            duration: Duration(seconds: 3),
          ),
        );
      }
      /* if user found */
      else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$username exists!'),
            duration: Duration(seconds: 3),
          ),
        );

        String currentUser_id = DatabaseServices.getUserId();

        /* go to current user profile page */
        if (currentUser_id == user_id_fetched) {

          /* go to that user page */
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProfilePage(
                      uid: currentUser_id,
                    )),
          );
        } else {
          /* go to that user page */
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OtherProfilePage(
                      uid: user_id_fetched,
                    )),
          );
        }
      }
    }
    /* if no input at all */
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter something to search.'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  Future<void> searchExist(String user_searching) async {
    /* populate user_data */
    User_Info? user_data =
        await DatabaseServices.searchUserCloud(user_searching);

    try {
      setState(() {
        /* init user fields */
        user_info = user_data;
        username = user_info?.username ?? "";
        user_id_fetched = user_info?.user_id ?? "";
      });
    } catch (e) {
      ('Failed to fetch user info: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: SizedBox(
          height: 40,
          /* input */
          child: TextField(
            controller: _textEditingController,
            /* styling */
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              filled: true,
              fillColor: Color.fromARGB(255, 189, 180, 180),
              hintText: 'Search',
              hintStyle: TextStyle(color: Color.fromARGB(255, 56, 55, 55)),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.grey,
              ),
            ),
          ),
        ),
        /* handle our onPressed */
        actions: [
          TextButton(
            onPressed: () => _handleButtonClick(context),
            child: Text(
              'Search',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: searchUsers.length,
        itemBuilder: (context, index) {
          var data = searchUsers[index];
          return ListTile(
            title: Text(data['username'].toString()),
          );
        },
      ),
    );
  }
}


// class SearchPage extends StatefulWidget {
//   SearchPage({super.key});

//   @override
//   State<SearchPage> createState() => _SearchViewState();
// }

// class _SearchViewState extends State<SearchPage> {
//   var searchName = "";
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         title: SizedBox(
//           height: 40,
//           child: TextField(
//             onChanged: (value) {
//               setState(() {
//                 searchName = value;
//               });
//             },
//             decoration: InputDecoration(
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: BorderSide.none),
//                 contentPadding:
//                     EdgeInsets.symmetric(horizontal: 8, vertical: 5),
//                 filled: true,
//                 fillColor: Color.fromARGB(255, 39, 39, 39),
//                 hintText: 'Search',
//                 hintStyle: TextStyle(color: Colors.grey),
//                 prefixIcon: Icon(
//                   Icons.search,
//                   color: Colors.grey,
//                 )),
//           ),
//         ),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//           stream: FirebaseFirestore.instance
//               .collection('users')
//               .orderBy('userName')
//               .startAt([searchName]).endAt([searchName + "\uf8ff"]).snapshots(),
//           builder: (context, snapshot) {
//             if (snapshot.hasError) {
//               return Text('Something went wrong');
//             }

//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Text("Loading");
//             }
//             return ListView.builder(
//                 itemCount: snapshot.data!.docs.length,
//                 itemBuilder: (context, index) {
//                   var data = snapshot.data!.docs[index];
//                   return ListTile(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => ProfilePage(
//                                   uid: data['id'],
//                                 )),
//                       );
//                     },
//                     leading: CircleAvatar(
//                       radius: 24,
//                       backgroundImage: NetworkImage(data['profileUrl']),
//                     ),
//                     title: Text(data['userName']),
//                     subtitle: Text(data['email']),
//                   );
//                 });
//           }),
//     );
//   }
// }
