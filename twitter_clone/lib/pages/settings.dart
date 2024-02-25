import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twitter_clone/providers/user_provider.dart';

class Settings extends ConsumerStatefulWidget {
  const Settings({super.key});

  @override
  ConsumerState<Settings> createState() => _SettingsState();
}

class _SettingsState extends ConsumerState<Settings> {
  void popPage() {
    Navigator.pop(context);
  }

  final TextEditingController _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    LocalUser currentUser = ref.watch(userProvider);
    _nameController.text = currentUser.user.name;
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                final ImagePicker picker = ImagePicker();
                // Pick an image
                final XFile? pickedImage = await picker.pickImage(
                  source: ImageSource.gallery,
                  requestFullMetadata: false,
                );

                if (pickedImage != null) {
                  ref
                      .read(userProvider.notifier)
                      .updateImage(File(pickedImage.path));

                  await Future.delayed(const Duration(seconds: 3));
                  popPage();
                }
              },
              child: Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    child: CircleAvatar(
                      radius: 100,
                      foregroundImage:
                          NetworkImage(currentUser.user.profilePic),
                    ),
                  ),
                  Positioned(
                    bottom: 15,
                    right: 20,
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: "Enter Your Name"),
              controller: _nameController,
            ),
            Container(
              margin: const EdgeInsets.only(top: 25),
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                ),
                onPressed: () {
                  ref
                      .read(userProvider.notifier)
                      .updateName(_nameController.text);
                  popPage();
                },
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                  child: Text("Update"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
