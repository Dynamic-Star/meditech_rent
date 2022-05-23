import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meditech_rent/centralized.dart';
import 'add_your_product.dart';

class BrowseProduct extends StatefulWidget {
  const BrowseProduct({Key? key}) : super(key: key);

  @override
  State<BrowseProduct> createState() => _BrowseProductState();
}

class _BrowseProductState extends State<BrowseProduct> {
  bool _isFavorited = true;
  int selectIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return
     Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Colors.white24,
                    Color(0xFFCAEEFF),
                  ],
                  end: Alignment.bottomCenter,
                  begin: Alignment.topCenter,
                ),
              ),
              // height: MediaQuery.of(context).size.height*0.82,  //0.833
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("profileInfo").snapshots(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      final userSnap = snapshot.data! as QuerySnapshot;
                      return ListView.builder(
                        itemCount: userSnap.docs.length,
                        itemBuilder: ((context, index) {
                          final userData = userSnap.docs[index].data() as Map<String,dynamic>;
                          return  myList(userData['title'], userData['imageurl'],
                                  userData['rent'],userData['id'],);

                        })
                        );
                    }
                    else{
                      return const Center(child: CircularProgressIndicator(),);
                    }

                }),
              ),
            ),
          ),

          //Yihan par vaipis se navigation bar ko call kar lena 
        ],
      )



    );
  }
  Widget buildUser(User user)=>ListTile(
    leading: CircleAvatar(child: Image.network(user.imageurl),),
    title: Text(user.title),
    subtitle:Text(user.desc),
    
  );
    GestureDetector Edit(String id) {
    return GestureDetector(
                  onTap: () {
                    final docUser = FirebaseFirestore.instance.collection("profileInfo").doc(id);
                    docUser.update({'desc':'hello'});
                     Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  AddYourProduct(id)));

                  }, child: const BoldFont("Edit", 15, darkblue));
  }

}
 Widget myList(String title, String image, String description,String id) {
    return Row(
      children: [
        Column(
          children: [
            Container(
              height: 80,
              width: 130,
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(color: hint, spreadRadius: 1, blurRadius: 1)
                ],
                  borderRadius: BorderRadius.circular(15),
                  // color: Colors.indigo,
                  image:
                      DecorationImage(image: NetworkImage(image), fit: BoxFit.cover)),
            ),
            const SizedBox(height: 30)
          ],
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            BoldFont(title, 18, darkblue),
            const SizedBox(height: 5),
            PlainFont(description, 16, black),
            const SizedBox(height: 5),
            BoldFont("Add to cart", 16, darkblue),
            SizedBox(height: 40,)
          ],
        )
      ],
    );
    
   
  }

  