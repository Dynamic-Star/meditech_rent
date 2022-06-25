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