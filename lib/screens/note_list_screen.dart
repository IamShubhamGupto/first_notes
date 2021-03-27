

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:first_notes/res/custom_colors.dart';
import 'package:first_notes/screens/user_info_screen.dart';
import 'package:first_notes/widgets/app_bar_title.dart';

class NoteListScreen extends StatefulWidget{
  const NoteListScreen({Key? key, required User user})
  :
    _user = user,
    super(key: key);

  final User _user;

  @override
  _NoteListScreenState createState() => _NoteListScreenState();

}

class _NoteListScreenState extends State<NoteListScreen>{
  late User _user;

  Route _routeToUserInfoScreen() {
    print("----------routing to user info screen-------------------");
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => UserInfoScreen(user:_user),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  void initState() {
    _user = widget._user;
    print("-----------------------At note list screen-------------------");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.firebaseNavy,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CustomColors.firebaseNavy,
        title: AppBarTitle(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(),
              _user.photoURL != null
                  ? ClipOval(
                      child: Material(
                        
                        color: CustomColors.firebaseGrey.withOpacity(0.3),
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap:() {
                            print("------TAP DETECTED----------------");
                              Navigator.of(context).pushReplacement(
                                _routeToUserInfoScreen()
                              );
                            },
                          child: Image.network(
                            _user.photoURL!,
                            fit: BoxFit.fitHeight,
                          ), 
                        ),
                      ),
                    )
                  : ClipOval(
                      child: Material(
                        color: CustomColors.firebaseGrey.withOpacity(0.3),
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: (){
                            print("------TAP DETECTED----------------");
                            Navigator.of(context).pushReplacement(
                                  _routeToUserInfoScreen()
                                );
                          },
                          child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Icon(
                            Icons.person,
                            size: 60,
                            color: CustomColors.firebaseGrey,
                          ),
                        ),
                        )
                      ),
                    ),
              SizedBox(height: 16.0),
                   Expanded(
                     child: Align(
                        alignment: Alignment.bottomRight,
                        child: FloatingActionButton(
                          backgroundColor: const Color(0xff03dac6),
                          foregroundColor: Colors.black,
                          onPressed: () {
                            // Respond to button press
                          },
                          child: Icon(Icons.add),
                        ),
                      ),
                  ) 
            ],
          ),
        ),
      ),
    );
  }
}