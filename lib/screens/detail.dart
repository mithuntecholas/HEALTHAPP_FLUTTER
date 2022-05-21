import 'package:flutter/material.dart';
import 'package:healthapp/models/user_model.dart';
import 'package:healthapp/utils/database_helper.dart';

class Detail extends StatefulWidget {

   final String tittle;
  Detail(this.tittle);

  @override
  _DetailState createState() {
    return _DetailState(this.tittle);
  }
}

class _DetailState extends State<Detail> {

  DatabaseHelper helper = DatabaseHelper();

  final String tittle;
  _DetailState(this.tittle);
  static var _priorities = ['beginner', 'intermediate','pro'];
  static var _type = ['weight lose', 'weight gain','musle building','core strength'];
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();


  @override
  Widget build(BuildContext context) {



    TextStyle textStyle = Theme.of(context).textTheme.subtitle1;

    return WillPopScope(

        onWillPop: () {
          // Write some code to control things, when user press Back navigation button in device navigationBar
          moveToLastScreen();
        },


        child: Scaffold(
      appBar: AppBar(


        title: Text(this.tittle),
        leading: IconButton(icon: Icon(
            Icons.arrow_back),
            onPressed: () {
              // Write some code to control things, when user press back button in AppBar
              moveToLastScreen();
            }
        ),
      ),

      body: Padding(
        padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[

            // First element
            ListTile(
              title: DropdownButton(
                  items: _priorities.map((String dropDownStringItem) {
                    return DropdownMenuItem<String> (
                      value: dropDownStringItem,
                      child: Text(dropDownStringItem),
                    );
                  }).toList(),

                  style: textStyle,

                  value: 'beginner',

                  onChanged: (valueSelectedByUser) {
                    setState(() {
                      debugPrint('User selected $valueSelectedByUser');

                    });
                  }
              ),
            ),
            // second element
            ListTile(
              title: DropdownButton(
                  items: _type.map((String dropDownStringItem) {
                    return DropdownMenuItem<String> (
                      value: dropDownStringItem,
                      child: Text(dropDownStringItem),
                    );
                  }).toList(),

                  style: textStyle,

                  value: 'weight lose',

                  onChanged: (valueSelectedByUser) {
                    setState(() {
                      debugPrint('User selected $valueSelectedByUser');

                    });
                  }
              ),
            ),


            // third Element
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: titleController,
                style: textStyle,
                onChanged: (value) {
                  debugPrint('Something changed in Title Text Field');
                },
                decoration: InputDecoration(
                    labelText: 'NAME',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)
                    )
                ),
              ),
            ),

            // fourth Element
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: descriptionController,
                style: textStyle,
                onChanged: (value) {
                  debugPrint('Something changed in Description Text Field');
                },
                decoration: InputDecoration(
                    labelText: 'Adress',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)
                    )
                ),
              ),
            ),

            // fifth Element
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Save',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        setState(() {
                          debugPrint("Save button clicked");
                          saveData();

                        });
                      },
                    ),
                  ),

                  Container(width: 5.0,),

                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Delete',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        setState(() {
                          debugPrint("Delete button clicked");

                        });
                      },
                    ),
                  ),

                ],
              ),
            ),

          ],
        ),
      ),


    ));
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }


  void saveData() async {

    User us =User("Mithun", "KOzhikode", 1, 3);
    int res= await helper.insertUser(us);
    if(res!=0)
      {
        debugPrint('User inserted $res');
      }else{
      debugPrint('User insertion failed $res');
    }
  }
}
