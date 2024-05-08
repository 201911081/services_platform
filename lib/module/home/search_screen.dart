import 'package:argiserve/module/details/details_screen.dart';
import 'package:argiserve/shared/component/component.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/state.dart';



class SearchScreen extends StatefulWidget {



  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String title = "";
  List<Map<String, dynamic>> data = [
  ];

  addData() async {
    for (var element in data) {
      FirebaseFirestore.instance.collection('posts').add(element);
    }
    print('all data added');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addData();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
            title: Card(
              child: TextField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search), hintText: 'Search about product...'),
                onChanged: (val) {
                  setState(() {
                    title = val;

                  });
                },
              ),
            )),
        body: BlocConsumer<ArgiServeCubit,ArgiServeStates>(
          listener: (context,state){
          },
          builder: (context,state){
            return StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('posts').snapshots(),
              builder: (context, snapshots) {
                return (snapshots.connectionState == ConnectionState.waiting)
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    : ListView.builder(
                    itemCount: snapshots.data!.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapshots.data!.docs[index].data()
                      as Map<String, dynamic>;

                      if (title.isEmpty) {
                        if(data['text']!= ArgiServeCubit.get(context).postModel?.title ) {
                          return InkWell(
                            onTap: (){
                              navigateTo(context, DetailsScreen(
                                title: data['title'],
                                text:data['text'],
                                firstImage: data['firstPostImage'],
                                phone: data['phone'],
                                name: data['name'],
                              ));
                             },
                            child: Row(
                              children: [
                                if(data['firstPostImage'] !='')
                                Image(image: NetworkImage(data['firstPostImage']), height: 80,
                                  width: 80,),
                                Expanded(
                                  child: ListTile(
                                    title: Text(
                                      data['text'],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          color: Colors.blue,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                      data['title'],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          color: Colors.black54,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),

                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      }
                      if (data['text']
                          .toString()
                          .toLowerCase()
                          .startsWith(title.toLowerCase())) {
                        if(data['text']!= ArgiServeCubit.get(context).postModel?.title ) {
                          return InkWell(
                            onTap: (){
                              navigateTo(context, DetailsScreen(
                                title: data['title'],
                                text:data['text'],
                                firstImage: data['firstPostImage'],
                                phone: data['phone'],
                                name: data['name'],
                              ));

                              },
                            child: Row(
                              children: [
                                if(data['firstPostImage'] !='')
                                  Image(image: NetworkImage(data['firstPostImage']), height: 80,
                                    width: 80,),
                                Expanded(
                                  child: ListTile(
                                    title: Text(
                                      data['text'],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          color: Colors.blue,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                      data['title'],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          color: Colors.black54,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),

                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      }
                      return Container();
                    });
              },
            );
          },
        ));

  }
}
