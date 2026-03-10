import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tob/core/theme/app_theme.dart';
import 'package:tob/features/add_property/bloc/add_property_bloc.dart';
import 'package:tob/features/add_property/bloc/add_property_event.dart';
import 'package:tob/features/add_property/bloc/add_property_state.dart';

void showPropertyTypeModal(BuildContext context) {
  final options = ["Residential", "Commercial", "Shortlet", "Land"];

  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (_) {
      final theme = Theme.of(context);
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Property Type",
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 16),

            ...options.map(
              (e) => GestureDetector(
                onTap: () {
                  context.read<AddPropertyBloc>().add(UpdatePropertyType(e));
                  Navigator.pop(context);
                },
                child: Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  // alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: e == "Residential"
                        ? theme.primaryColor
                        : theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    e,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: e == "Residential"
                          ? theme.cardColor
                          : theme.primaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

final picker = ImagePicker();

Future<String?> pickFromCamera() async {
  final img = await picker.pickImage(source: ImageSource.camera);
  return img?.path;
}

Future<String?> pickFromGallery() async {
  final img = await picker.pickImage(source: ImageSource.gallery);
  return img?.path;
}

class PhotoGrid extends StatelessWidget {
  const PhotoGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return BlocBuilder<AddPropertyBloc, AddPropertyState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              color: theme.colorScheme.surface,
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  if (state.photos.isEmpty)
                    Row(
                      spacing: size.width * 0.027,
                      children: [1, 2, 3]
                          .map(
                            (e) => Container(
                              width: size.width * 0.265,
                              height: size.width * 0.265,
                              decoration: BoxDecoration(
                                color: AppTheme.grayAltColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          )
                          .toList(),
                    ),

                  ...List.generate(state.photos.length, (index) {
                    final photo = state.photos[index];

                    return Stack(
                      children: [
                        Container(
                          width: size.width * 0.265,
                          height: size.width * 0.265,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: FileImage(File(photo.path)),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        Positioned(
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              context.read<AddPropertyBloc>().add(
                                RemovePhoto(index),
                              );
                            },
                            child: const CircleAvatar(
                              radius: 10,
                              backgroundColor: Colors.red,
                              child: Icon(
                                Icons.close,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),

                  GestureDetector(
                    onTap: () => showUploadOptions(context),
                    child: Row(children: [Icon(Icons.add), Text("Add Photo")]),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class PropertyPhoto {
  final String path;

  PropertyPhoto(this.path);
}

void showUploadOptions(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (_) {
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text("Camera"),
              onTap: () async {
                final path = await pickFromCamera();
                if (path != null) {
                  context.read<AddPropertyBloc>().add(AddPhoto(path));
                }

                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.image),
              title: const Text("Gallery"),
              onTap: () async {
                final path = await pickFromGallery();
                if (path != null) {
                  context.read<AddPropertyBloc>().add(AddPhoto(path));
                }

                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    },
  );
}
