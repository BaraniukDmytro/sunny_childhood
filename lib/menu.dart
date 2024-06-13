import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sunny_childhood/const/colors.dart';

class AppMenu extends StatelessWidget {
  const AppMenu({super.key});

  void logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context){
    return Drawer(
      backgroundColor: custom_green,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
        // drawer header
        DrawerHeader(
            child:Row(
              children: [
                Image.asset(
                  'images/menuImage.png',
                  height: 270,
                  width: 270,
                ),
              ],
            )
        ),

        const SizedBox(height: 25),

        // home_tile
        Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: ListTile(
            leading: Icon(
                Icons.home,
            ),
            title: Text("Н О В И Н И"),
            onTap: (){
              Navigator.pop(context);
              Navigator.pushNamed(context, '/home_page');
            },
          ),
        ),

        // profile_tile
        Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: ListTile(
            leading: Icon(
                Icons.person,
            ),
            title: const Text("П Р О Ф І Л Ь"),
            onTap: (){
              Navigator.pop(context);
              Navigator.pushNamed(context, '/profile_page');
            },
          ),
        ),

          // schedule_tile
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              leading: Icon(
                Icons.calendar_month,
              ),
              title: const Text("З А Н Я Т Т Я"),
              onTap: (){
                Navigator.pop(context);
                Navigator.pushNamed(context, '/schedule_page');
              },
            ),
          ),

        // users_tile
        Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: ListTile(
            leading: Icon(
              Icons.group,
            ),
            title: const Text("В О Л О Н Т Е Р И"),
            onTap: (){
              Navigator.pop(context);
              Navigator.pushNamed(context, '/users_page');
            },
          ),
        ),


          // progress tile
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              leading: Icon(
                Icons.grass_outlined,
              ),
              title: const Text("П Р О Г Р Е С"),
              onTap: (){
                Navigator.pop(context);
                Navigator.pushNamed(context, '/progress_page');
              },
            ),
          ),

          // instruction tile
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              leading: Icon(
                Icons.integration_instructions,
              ),
              title: const Text("І Н С Т Р У К Ц І Я"),
              onTap: (){
                Navigator.pop(context);
                Navigator.pushNamed(context, '/instruction_page');
              },
            ),
          ),

        // logout tile
        Padding(
          padding: const EdgeInsets.only(left: 25.0, bottom: 25),
          child: ListTile(
            leading: Icon(
              Icons.logout,
            ),
            title: Text("В И Х І Д"),
            onTap: (){
              Navigator.pop(context);
              //logout
              logout();
            },
          ),
        ),
      ],),
    );
  }
}