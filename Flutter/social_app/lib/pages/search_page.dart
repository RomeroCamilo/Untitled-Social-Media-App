import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});
  final List<Map<String, dynamic>> searchUsers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: SizedBox(
          height: 40,
          child: TextField(
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
