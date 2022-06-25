import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meditech_rent/centralized.dart';

import '../rent product/add_your_product.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({Key? key}) : super(key: key);

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  bool isLoading = false;
  UserInfodata? user;
  //  Map<String, dynamic>? usersMap;
  TextEditingController searchController = TextEditingController();

  void onSearch() async {
    try {
      FirebaseFirestore _firestore = FirebaseFirestore.instance;
      setState(() {
        isLoading = true;
      });

      _firestore
          .collection('profileInfo')
          .where(
            "title",
            isGreaterThanOrEqualTo: searchController.text.trim(),
          )
          .snapshots();
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      const Center(child: Text('item not found'));
    }
  }

  @override
  Widget build(BuildContext context) {
    var length = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
                       : Column(
                children: [
                  // search container
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 25, 12, 10),
                    child: Container(
                      height: length.height * 0.05,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 3, vertical: 0),
                      decoration: BoxDecoration(
                          color: white,
                          boxShadow: const [
                            BoxShadow(color: darkBlue, spreadRadius: 1)
                          ],
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 4, 0, 2),
                        child: TextField(
                          controller: searchController,
                          onChanged: (value) {
                            setState(() {});
                          },
                          decoration: InputDecoration(
                            fillColor: white,
                              filled: true,
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    onSearch();
                                  },
                                                                   icon: const Icon(
                                    Icons.search, size: 22, color: darkBlue
                                  )),
                              border: InputBorder.none,
                              prefixIcon: const Icon(Icons.accessible, size: 30, color: darkBlue),
                              hintText: "Search any product...",
                          hintStyle: const TextStyle(color: hint)),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('profileInfo')
                          .where(
                            'title',
                            isGreaterThanOrEqualTo:
                                searchController.text.trim(),
                          )
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          if (snapshot.hasData) {
                            QuerySnapshot dataSnapshot =
                                snapshot.data as QuerySnapshot;
                            if (dataSnapshot.docs.isNotEmpty) {
                              return ListView.builder(
                                itemCount: dataSnapshot.docs.length,
                                itemBuilder: (context, index) {
                                  Map<String, dynamic> userMap =
                                      dataSnapshot.docs[index].data()
                                          as Map<String, dynamic>;
                                  UserInfodata searchedUser =
                                      UserInfodata.fromJson(userMap);

                                  return ListTile(
                                    leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(25),
                                      child: CircleAvatar(
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .secondary
                                            .withAlpha(100),
                                        radius: 25,
                                        child: Image.network(
                                          searchedUser.imageurl,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              ((context, error, stackTrace) {
                                            return const Icon(
                                                Icons.account_circle_rounded);
                                          }),
                                        ),
                                      ),
                                    ),  
                                                                       title: Text(searchedUser.title.toString()),
                                    subtitle:
                                        Text(searchedUser.desc.toString()),
                                    trailing: const Icon(
                                        Icons.keyboard_arrow_right_rounded),
                                    onTap: () {},
                                  );
                                },
                              );
                            } else {
                              return const Padding(
                                padding: EdgeInsets.all(20),
                                child: Text(
                                  'Oops, No item found ! Check upper and lower cases...',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color:darkBlue
                                  ),
                                ),
                              );
                            }