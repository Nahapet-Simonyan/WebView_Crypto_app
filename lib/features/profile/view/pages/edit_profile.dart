import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

import 'package:bin7r4decl/core/constants/colors.dart';
import 'package:bin7r4decl/components/components.dart';
import 'package:bin7r4decl/features/simulator/data/data.dart';

TextEditingController? _controller = TextEditingController();

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  Uint8List? _image = GetIt.I<BettingRepository>().getUserImage();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.cardColor,
        automaticallyImplyLeading: false,
        surfaceTintColor: Colors.transparent,
        title: const CustomAppBar(title: 'Edit profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                width: 110,
                height: 110,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 110,
                        height: 110,
                        child: CircleAvatar(
                          backgroundImage: _image != null && _image!.isNotEmpty
                              ? MemoryImage(_image!)
                              : null,
                          backgroundColor: AppColors.gray1,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        pickImage();
                        if (_image != null) {
                          GetIt.I<BettingRepository>()
                              .saveOrUpdateImage(_image!);
                        }
                      },
                      borderRadius: BorderRadius.circular(100.0),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Image.asset('assets/icons/yellow_photo.png'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 38.0),
            SizedBox(
              height: 47,
              child: TextFormField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Name',
                  hintStyle: const TextStyle(color: AppColors.gray3),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColors.white),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColors.gray2),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColors.gray2),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 91.0),
            CustomButton(
              onTap: () {
                if (_image != null) {
                  GetIt.I<BettingRepository>().saveOrUpdateImage(_image!);
                }
                if (_controller?.text != null) {
                  GetIt.I<BettingRepository>().saveOrUpdateName(
                    _controller!.text,
                  );
                }
                Navigator.pop(context);
              },
              child: Text(
                'Save',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.black,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void pickImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    Uint8List imageBytes = await image.readAsBytes();

    setState(() {
      _image = imageBytes;
    });
  }
}
