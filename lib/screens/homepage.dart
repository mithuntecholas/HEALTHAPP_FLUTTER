import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:healthapp/Screens/detail.dart';
import 'package:healthapp/models/user_model.dart';
import 'package:healthapp/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  DatabaseHelper _databaseHelper = DatabaseHelper();
   List<User> userList;
  int count = 0;
  @override
  Widget build(BuildContext context) {

    if (userList == null) {
      userList = <User>[];
      updateListView();
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("NOTES"),
        ),
        body: getListView(),

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            debugPrint("new item add");
            navigateToDetail("ADD PLAN");
          },
          tooltip: "ADD NOTE",
          child: Icon(Icons.add),

        )

    );
  }

  ListView getListView() {
    TextStyle titleStyle = Theme
        .of(context)
        .textTheme
        .subtitle1;
    return ListView.builder(itemCount: count,
        itemBuilder: (BuildContext context, int position) {
      String name;
      String adress;
      if(this.userList[position].name==null)
        {
          name="unknown";

        }else{
        name=userList[position].name;
      }
      if(this.userList[position].adress==null)
      {
        adress="unknown";

      }else{
        adress=userList[position].adress;
      }
          return Card(
              color: Colors.white,
              elevation: 2.0,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.yellow,
                  child: Icon(Icons.arrow_left),
                ),


                title: Text(name, style: titleStyle,),
                subtitle: Text(adress, style: titleStyle,),
                trailing: Icon(Icons.delete),
                onTap: () {
                  debugPrint("tapped");
                  navigateToDetail("EDIT PLAN");
                },
              )

          );
        }
    );
  }

  void updateListView() async{
    final Future<Database> dbFuture = _databaseHelper.initializeDatabase();
    dbFuture.then((database) {

      Future<List<User>> noteListFuture = _databaseHelper.getUSerList();

      noteListFuture.then((userList) {
        debugPrint('list count ${userList.length}');
        setState(() {
          this.userList = userList;
          this.count = userList.length;
        });
      });
    });

  }

  void navigateToDetail( String title) async {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Detail( title);
    }));

    if (result == true) {
      updateListView();
    }
  }

}
