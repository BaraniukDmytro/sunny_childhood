import 'package:flutter/material.dart';
import 'package:sunny_childhood/const/colors.dart';
import 'package:sunny_childhood/repository/auth_data.dart';

class SignUp_Screen extends StatefulWidget {
  final VoidCallback show;
  SignUp_Screen(this.show, {super.key});

  @override
  State<SignUp_Screen> createState() => _SignUp_ScreenState();
}

class _SignUp_ScreenState extends State<SignUp_Screen> {
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();
  final FocusNode _focusNode5 = FocusNode();
  final FocusNode _focusNode6 = FocusNode();

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController PasswordConfirm = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController age = TextEditingController();
  final TextEditingController additionalInfo = TextEditingController();

  int? _selectedAvatarIndex;
  List<String> avatarImages = [
    'images/avatar1.png',
    'images/avatar2.png',
  ];

  @override
  void initState() {
    super.initState();
    _focusNode1.addListener(() {
      setState(() {});
    });
    _focusNode2.addListener(() {
      setState(() {});
    });
    _focusNode3.addListener(() {
      setState(() {});
    });
    _focusNode4.addListener(() {
      setState(() {});
    });
    _focusNode5.addListener(() {
      setState(() {});
    });
    _focusNode6.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
    _focusNode4.dispose();
    _focusNode5.dispose();
    _focusNode6.dispose();
    email.dispose();
    password.dispose();
    PasswordConfirm.dispose();
    name.dispose();
    age.dispose();
    additionalInfo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColors,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              image(),
              SizedBox(height: 10),
              account(),
              SizedBox(height: 10),
              textfield(email, _focusNode1, 'Email', Icons.email),
              SizedBox(height: 10),
              textfield(password, _focusNode2, 'Password', Icons.password),
              SizedBox(height: 10),
              textfield(PasswordConfirm, _focusNode3, 'Password Confirm', Icons.password),
              SizedBox(height: 10),
              textfield(name, _focusNode4, 'Name', Icons.person),
              SizedBox(height: 10),
              textfield(age, _focusNode5, 'Age', Icons.calendar_today),
              SizedBox(height: 10),
              textfield(additionalInfo, _focusNode6, 'Additional Info', Icons.info),
              SizedBox(height: 20),
              avatarSelection(),
              //SizedBox(height: 0),
              signUpButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget account() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Already have an account?",
            style: TextStyle(color: Colors.grey[700], fontSize: 14),
          ),
          SizedBox(width: 5),
          GestureDetector(
            onTap: widget.show,
            child: Text(
              'Login',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  Widget signUpButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GestureDetector(
        onTap: () {
          if (password.text == PasswordConfirm.text) {
            if (_selectedAvatarIndex != null) {
              String selectedAvatar = avatarImages[_selectedAvatarIndex!];
              AuthenticationRemote().register(
                email.text,
                password.text,
                PasswordConfirm.text,
                name.text,
                age.text,
                additionalInfo.text,
                selectedAvatar,  // Передаємо вибраний аватар
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Please select an avatar')),
              );
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Passwords do not match')),
            );
          }
        },
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: custom_green,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            'Sign Up',
            style: TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget textfield(TextEditingController controller, FocusNode focusNode, String typeName, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          style: TextStyle(fontSize: 18, color: Colors.black),
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: focusNode.hasFocus ? custom_green : Color(0xffc5c5c5),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            hintText: typeName,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Color(0xffc5c5c5),
                width: 2.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: custom_green,
                width: 2.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget image() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
          color: backgroundColors,
          image: DecorationImage(
            image: AssetImage('images/7.png'),
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }

  Widget avatarSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            'Select Avatar',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 10,),
        GridView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 15),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1,
          ),
          itemCount: avatarImages.length,
          itemBuilder: (context, index) {
            return RadioListTile<int>(
              value: index,
              groupValue: _selectedAvatarIndex,
              onChanged: (value) {
                setState(() {
                  _selectedAvatarIndex = value;
                });
              },
              title: Image.asset(
                avatarImages[index],
                width: 100,
                height: 100,
              ),
            );
          },
        ),
      ],
    );
  }
}