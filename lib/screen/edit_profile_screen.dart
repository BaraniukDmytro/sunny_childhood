import 'package:flutter/material.dart';
import 'package:sunny_childhood/const/colors.dart'; // Імпортуємо кольори з вашого файлу const/colors.dart

class EditProfilePage extends StatefulWidget {
  final Map<String, dynamic>? userData;

  const EditProfilePage({Key? key, this.userData}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _additionalInfoController;
  int _selectedAvatarIndex = 0; // Індекс обраного аватара

  // Список зображень аватарів
  final List<String> avatarImages = [
    'images/avatar1.png',
    'images/avatar2.png',
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.userData?['name']);
    _ageController = TextEditingController(text: widget.userData?['age']);
    _additionalInfoController = TextEditingController(text: widget.userData?['additionalInfo']);
    _selectedAvatarIndex = widget.userData?['avatarIndex'] ?? 0; // Встановлюємо індекс обраного аватара
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _additionalInfoController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      final updatedData = {
        'name': _nameController.text,
        'age': _ageController.text,
        'additionalInfo': _additionalInfoController.text,
        'avatarIndex': _selectedAvatarIndex, // Зберігаємо індекс обраного аватара
        'avatarUrl': avatarImages[_selectedAvatarIndex], // Зберігаємо шлях до обраного аватара
      };
      Navigator.pop(context, updatedData);
    }
  }

  Widget avatarSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            'Вибрати аватар',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 10),
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
                  _selectedAvatarIndex = value!;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Редагування профілю'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Імя'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Будь ласка введіть імя';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(labelText: 'Вік'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Будь ласка введіть вік';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _additionalInfoController,
                decoration: InputDecoration(labelText: 'Додаткова інформація'),
              ),
              SizedBox(height: 20),
              avatarSelection(), // Додаємо вибір аватара
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: custom_green, // Зелений колір кнопки
                ),
                child: Text('Зберегти',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
