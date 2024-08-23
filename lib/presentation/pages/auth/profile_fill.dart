import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../blocs/auth/profile_fill/profile_fill_bloc.dart';
import '../../../configs/app_theme.dart';
import '../../../gen/assets.gen.dart';
import '../../components/movement/button.dart';
import '../../components/text_editing/text_field.dart';

class ProfileFillPage extends StatefulWidget {
  final String userId;

  const ProfileFillPage({
    required this.userId,
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileFillPage> createState() => _ProfileFillPageState();
}

class _ProfileFillPageState extends State<ProfileFillPage> {
  final wtagTextController = TextEditingController();
  String? _selectedImagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: BlocConsumer<ProfileFillBloc, ProfileFillState>(
        listener: (context, state) {
          if (state is ProfileFillSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Profile updated successfully')),
            );
          } else if (state is ProfileFillFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Profile update failed')),
            );
          } else if (state is ProfileImageSelectionSuccess) {
            setState(() {
              _selectedImagePath = state.imagePath;
            });
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.primaryColor,
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              GoRouter.of(context).pop();
                            },
                            child: Image.asset(
                              Assets.images.icons.arrowIcon.path,
                            ),
                          ),
                          const SizedBox(height: 17),
                          const Text(
                            'Profile',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Choose your profile image and personal w-tag',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppTheme.lightTheme.primaryColor,
                              image: _selectedImagePath != null
                                  ? DecorationImage(
                                      image:
                                          FileImage(File(_selectedImagePath!)),
                                      fit: BoxFit.cover,
                                    )
                                  : DecorationImage(
                                      image: AssetImage(
                                          Assets.images.icons.ellipse.path),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: IconButton(
                              onPressed: () {
                                context.read<ProfileFillBloc>().add(
                                    const ProfileImageSelected(
                                        ImageSource.gallery));
                              },
                              icon: const Icon(
                                Icons.add_circle,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      UpdatedTextField(
                        controller: wtagTextController,
                        hintText: 'Your W-TAG',
                        obsecureText: false,
                        background: AppTheme.lightTheme.scaffoldBackgroundColor,
                      ),
                      const SizedBox(height: 41),
                      UpdateButton(
                        onTap: () {
                          if (_selectedImagePath != null) {
                            context.read<ProfileFillBloc>().add(
                                  ProfileUpdateRequested(
                                    userId: widget.userId,
                                    imagePath: _selectedImagePath!,
                                    weTag: wtagTextController.text,
                                  ),
                                );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please select an image first'),
                              ),
                            );
                          }
                        },
                        text: 'Continue',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
