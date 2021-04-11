import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:yru_flutter_workshop_101/api/apiService.dart';
import 'package:yru_flutter_workshop_101/model/postsDao.dart';
import 'package:yru_flutter_workshop_101/screen/home/showImagePage.dart';
import '../../../configApp.dart';

class TabPosts extends StatelessWidget {
  final Widget child;
  const TabPosts({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Posts> postsList = [];
    return Container(
      // decoration: BackgroundYRU.decorationApp(),
      padding: new EdgeInsets.all(5.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Expanded(
              child: FutureBuilder(
                  future: ApiService.posts(accessTokenSave),
                  builder: (context, data) {
                    if (data.hasData) {
                      // LogDebug('data display= ${data.data}');

                      if (data.data != '' && data.data
                          .toString()
                          .length > 3) {
                        Map map = json.decode(data.data);
                        PostsDao dao = PostsDao.fromJson(map);

                        List<dynamic> list = dao.data;

                        LogDebug('list = ${list.length}');
                        if (postsList != null) {
                          LogDebug('postsList != null');
                          postsList = null;
                          postsList = [];
                        }
                        for (var i = 0; i < list.length; i++) {
                          postsList.add(new Posts(
                              '${dao.data[i].author.id}', '${dao.data[i].author.name}',
                              '${dao.data[i].author.email}',
                              '${dao.data[i].title}',
                              '${dao.data[i].description}',
                              '${dao.data[i].img}',
                          ));
                        }
                        return new ListView(
                          padding: new EdgeInsets.symmetric(
                              vertical: 1.0),
                          children: postsList.map((Posts postsList) {
                            return new UsersItemList(postsList);
                          }).toList(),
                        );
                      } else {
                        return Text('');
                      }
                    } else {
                      // return CircularProgressIndicator();
                      return Text('');
                    }
                  }
              )),


        ],
      ),
    );
  }
}


///For Tab ListPost
class UsersItemList extends StatefulWidget {
  final Posts postsList;
  UsersItemList(Posts postsList)
      : postsList = postsList,
        super(key: new ObjectKey(postsList));
  @override
  UsersItemState createState() {
    return new UsersItemState(postsList);
  }
}

class UsersItemState extends State<UsersItemList> {
  final Posts postsList;
  UsersItemState(this.postsList);
  @override
  Widget build(BuildContext context) {
    // return new Card(
    return new Card(
      child: new ListTile(
        title: new Column(
          children: <Widget>[
            // LogDebug('Touch List ${postsList.title.toString()}'),
            Text(postsList.title, style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 18.0,),
            textAlign: TextAlign.start),
            SizedBox(height: 10.0,),
            Image.network(postsList.img),
            SizedBox(height: 10.0,),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.linked_camera,color: Colors.blue),
                  onPressed: () {
                    setState(() {
                      LogDebug('icon 1 press:');
                      onTapped(postsList,1);
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.mode_comment_outlined,color: Colors.blue),
                  onPressed: () {
                    setState(() {
                      LogDebug('icon 2 press:');
                      onTapped(postsList,2);
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.send_rounded,color: Colors.blue),
                  onPressed: () {
                    setState(() {
                      LogDebug('icon 3 press:');
                      onTapped(postsList,3);
                    });
                  },
                ),

              ],
            ),
            SizedBox(height: 10.0,)
          ],
        ),
        subtitle: Text(postsList.description),
        // onTap: (){
        //   print('Touch List ${postsList.id.toString()}');
        // },
        onTap: () => onTapped(postsList,0),
      ),
    );


  }

  void onTapped(Posts select, int id) {
    // navigate to the next screen.
    LogDebug('name ${id.toString()}: ${select.name}');
    LogDebug('title ${id.toString()}: ${select.title}');
    LogDebug('img ${id.toString()}: ${select.img}');

    Navigator.push(context, MaterialPageRoute(builder: (context) =>
        ShowImagePage(title: select.title,imgUrl:select.img)),).then((value)  {
    });

  }
}

class Posts {
  String id;
  String name;
  String email;
  String title;
  String description;
  String img;
  Posts(this.id, this.name, this.email, this.title, this.description, this.img);
}