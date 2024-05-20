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
                  'images/forest1.png',
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
            title: Text("H O M E"),
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
            title: const Text("P R O F I L E"),
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
              title: const Text("S C H E D U L E"),
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
            title: const Text("V O L U N T E E R S"),
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
              title: const Text("P R O G R E S S"),
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
              title: const Text("I N S T R U C T I O N"),
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
            title: Text("L O G O U T"),
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