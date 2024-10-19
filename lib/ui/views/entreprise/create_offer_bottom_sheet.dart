import 'dart:io';

import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app/core/viewmodels/componay_view_model.dart';
import 'package:mobile_app/ui/presentation/extensions/media_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../../core/models/category.dart';
import '../../../core/models/offer.dart';
import '../../../core/models/skill.dart';
import '../../../core/viewmodels/offer_view_model.dart';
import '../../presentation/presentation.dart';
import '../../widgets/curve_painter.dart';
import '../../widgets/multi_select_dialog.dart';

class CreateOfferBottomSheet extends StatefulWidget {
  const CreateOfferBottomSheet({super.key, this.offer, this.isForUpdate = false});

  final Offer? offer;
  final bool isForUpdate;

  @override
  State<CreateOfferBottomSheet> createState() => _CreateOfferBottomSheetState();
}

class _CreateOfferBottomSheetState extends State<CreateOfferBottomSheet> {
  File? _pickedImage;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _contractController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  bool _changeImage = false;
  final ScrollController _scrollController = ScrollController();
  List<Skill> _selectedSkills = [];
  List<Category> _selectedCategories = [];

  @override
  initState() {
    super.initState();
    _initValues();
  }

  _initValues() {
    if (widget.offer != null) {
      _titleController.text = widget.offer!.title;
      _descriptionController.text = widget.offer!.description;
      _contractController.text = widget.offer!.contractType;
      _salaryController.text = widget.offer!.salary.toString();
      _locationController.text = widget.offer!.location;
      _selectedCategories = widget.offer!.categories;
      _selectedSkills = widget.offer!.skills;
    }
  }

  Future<void> _pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();

    var status = await Permission.camera.status;

    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No image selected'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onTap: () {},
        child: DraggableScrollableSheet(
          initialChildSize: 0.8,
          builder: (context, scrollController) => CustomPaint(
            size: Size(context.width, context.height * 0.1),
            painter: CurvePainter(
              reversed: true,
              colors: [
                Colors.white,
                Colors.white,
              ],
              deviceHeight: context.height,
              direction: Axis.vertical,
              curveStrength: 1.5,
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.md,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Text(
                      widget.isForUpdate ? 'Update Offer' : 'Create New Offer',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: FadingEdgeScrollView.fromSingleChildScrollView(
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          child: Column(
                            children: [
                              TextField(
                                controller: _titleController,
                                decoration: InputDecoration(
                                  labelText: 'title',
                                  hintStyle: TextStyles.body0Semibold(color: Colors.black),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(Dimensions.sm),
                                    borderSide: BorderSide(color: Colors.black.withOpacity(0.8)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(Dimensions.sm),
                                    borderSide: BorderSide(color: Colors.black.withOpacity(0.8)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(Dimensions.sm),
                                    borderSide: BorderSide(color: Colors.black.withOpacity(0.8)),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: Dimensions.sm,
                                    vertical: Dimensions.xxxs,
                                  ),
                                ),
                                style: TextStyles.calloutRegular(color: Colors.black),
                              ),
                              const SizedBox(height: 20),
                              TextField(
                                controller: _descriptionController,
                                decoration: InputDecoration(
                                  labelText: 'description',
                                  hintStyle: TextStyles.body0Semibold(color: Colors.black),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(Dimensions.sm),
                                    borderSide: BorderSide(color: Colors.black.withOpacity(0.8)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(Dimensions.sm),
                                    borderSide: BorderSide(color: Colors.black.withOpacity(0.8)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(Dimensions.sm),
                                    borderSide: BorderSide(color: Colors.black.withOpacity(0.8)),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: Dimensions.sm,
                                    vertical: Dimensions.xxxs,
                                  ),
                                ),
                                style: TextStyles.calloutRegular(color: Colors.black),
                              ),
                              const SizedBox(height: 20),
                              TextField(
                                controller: _contractController,
                                decoration: InputDecoration(
                                  labelText: 'Contract Type',
                                  hintStyle: TextStyles.body0Semibold(color: Colors.black),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(Dimensions.sm),
                                    borderSide: BorderSide(color: Colors.black.withOpacity(0.8)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(Dimensions.sm),
                                    borderSide: BorderSide(color: Colors.black.withOpacity(0.8)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(Dimensions.sm),
                                    borderSide: BorderSide(color: Colors.black.withOpacity(0.8)),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: Dimensions.sm,
                                    vertical: Dimensions.xxxs,
                                  ),
                                ),
                                style: TextStyles.calloutRegular(color: Colors.black),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: _salaryController,
                                      decoration: InputDecoration(
                                        labelText: 'salary',
                                        hintStyle: TextStyles.body0Semibold(color: Colors.black),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(Dimensions.sm),
                                          borderSide: BorderSide(color: Colors.black.withOpacity(0.8)),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(Dimensions.sm),
                                          borderSide: BorderSide(color: Colors.black.withOpacity(0.8)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(Dimensions.sm),
                                          borderSide: BorderSide(color: Colors.black.withOpacity(0.8)),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding: const EdgeInsets.symmetric(
                                          horizontal: Dimensions.sm,
                                          vertical: Dimensions.xxxs,
                                        ),
                                      ),
                                      style: TextStyles.calloutRegular(color: Colors.black),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: TextField(
                                      controller: _locationController,
                                      decoration: InputDecoration(
                                        labelText: 'location',
                                        hintStyle: TextStyles.body0Semibold(color: Colors.black),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(Dimensions.sm),
                                          borderSide: BorderSide(color: Colors.black.withOpacity(0.8)),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(Dimensions.sm),
                                          borderSide: BorderSide(color: Colors.black.withOpacity(0.8)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(Dimensions.sm),
                                          borderSide: BorderSide(color: Colors.black.withOpacity(0.8)),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding: const EdgeInsets.symmetric(
                                          horizontal: Dimensions.sm,
                                          vertical: Dimensions.xxxs,
                                        ),
                                      ),
                                      style: TextStyles.calloutRegular(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              FutureBuilder<List<Category>>(
                                future: context.read<CompanyViewModel>().getAllCategories(),
                                builder: (BuildContext context, AsyncSnapshot<List<Category>> snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                    return const Text('No categories available');
                                  } else {
                                    List<Category> categories = snapshot.data!;
                                    return Column(
                                      children: [
                                        ElevatedButton(
                                          onPressed: () async {
                                            final List<Category>? selectedCategories = await showDialog<List<Category>>(
                                              context: context,
                                              builder: (context) {
                                                return MultiSelectDialog<Category>(
                                                  items: categories,
                                                  selectedItems: _selectedCategories,
                                                  itemLabel: (Category category) => category.title,
                                                );
                                              },
                                            );

                                            if (selectedCategories != null) {
                                              setState(() {
                                                _selectedCategories = selectedCategories;
                                              });
                                            }
                                          },
                                          child: const Text('Select Categories'),
                                        ),
                                        Wrap(
                                          spacing: 8.0,
                                          children: _selectedCategories.map((category) {
                                            return Chip(
                                              label: Text(category.title),
                                              deleteIcon: const Icon(Icons.close),
                                              onDeleted: () {
                                                setState(() {
                                                  _selectedCategories.remove(category);
                                                });
                                              },
                                            );
                                          }).toList(),
                                        ),
                                      ],
                                    );
                                  }
                                },
                              ),
                              const SizedBox(height: 20),
                              FutureBuilder<List<Skill>>(
                                future: context.read<CompanyViewModel>().getAllSkills(),
                                builder: (BuildContext context, AsyncSnapshot<List<Skill>> snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                    return const Text('No Skills available');
                                  } else {
                                    List<Skill> skills = snapshot.data!;
                                    return Column(
                                      children: [
                                        ElevatedButton(
                                          onPressed: () async {
                                            final List<Skill>? selectedSkills = await showDialog<List<Skill>>(
                                              context: context,
                                              builder: (context) {
                                                return MultiSelectDialog<Skill>(
                                                  items: skills,
                                                  selectedItems: _selectedSkills,
                                                  itemLabel: (skill) => skill.skill,
                                                );
                                              },
                                            );

                                            if (selectedSkills != null) {
                                              setState(() {
                                                _selectedSkills = selectedSkills;
                                              });
                                            }
                                          },
                                          child: const Text('Select Skills'),
                                        ),
                                        // Display selected skills
                                        Wrap(
                                          spacing: 8.0,
                                          children: _selectedSkills.map((skill) {
                                            return Chip(
                                              label: Text(skill.skill), // Display the skill's name
                                              deleteIcon: const Icon(Icons.close),
                                              onDeleted: () {
                                                setState(() {
                                                  _selectedSkills.remove(skill);
                                                });
                                              },
                                            );
                                          }).toList(),
                                        ),
                                      ],
                                    );
                                  }
                                },
                              ),
                              const SizedBox(height: 20),
                              widget.offer != null && !_changeImage
                                  ? Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        Image.asset(
                                          widget.offer!.imageUrl ?? '',
                                          width: 100,
                                          height: 100,
                                        ),
                                        Positioned(
                                          right: -5,
                                          top: -5,
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _pickedImage = null;
                                                _changeImage = true;
                                              });
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(4),
                                              decoration: const BoxDecoration(
                                                color: Colors.purple,
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(Icons.close, size: 15, color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : _pickedImage != null
                                      ? Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            Image.file(
                                              _pickedImage!,
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.cover,
                                            ),
                                            Positioned(
                                              right: -10,
                                              top: -10,
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _pickedImage = null;
                                                  });
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets.all(4),
                                                  decoration: const BoxDecoration(
                                                    color: Colors.purple,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: const Icon(Icons.close, size: 15, color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : ElevatedButton(
                                          onPressed: _pickImageFromGallery,
                                          child: const Text('Select Company Logo'),
                                        ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () async {
                                  if (widget.offer != null) {
                                    Offer offer = Offer(
                                      id: widget.offer!.id,
                                      title: _titleController.text,
                                      description: _descriptionController.text,
                                      salary: double.parse(_salaryController.text),
                                      location: _locationController.text,
                                      skills: _selectedSkills,
                                      categories: _selectedCategories,
                                      imageUrl: widget.offer!.imageUrl,
                                      file: _pickedImage,
                                      contractType: _contractController.text,
                                      companyId: context.read<CompanyViewModel>().company!.id!,
                                    );
                                    await context.read<OfferViewModel>().updateOffer(offer);
                                    if (context.mounted) {
                                      context.read<OfferViewModel>().getCompanyOffers();
                                      Navigator.pop(context);
                                    }
                                  } else {
                                    Offer offer = Offer(
                                      id: DateTime.now().toString(),
                                      title: _titleController.text,
                                      description: _descriptionController.text,
                                      salary: double.parse(_salaryController.text),
                                      location: _locationController.text,
                                      skills: _selectedSkills,
                                      categories: _selectedCategories,
                                      imageUrl: _pickedImage != null ? _pickedImage!.path : '',
                                      file: _pickedImage,
                                      companyId: context.read<CompanyViewModel>().company!.id!,
                                      contractType: _contractController.text,
                                    );
                                    await context.read<OfferViewModel>().createOffer(offer);
                                    if (context.mounted) {
                                      context.read<OfferViewModel>().getCompanyOffers();
                                      Navigator.pop(context);
                                    }
                                  }
                                },
                                child: widget.offer != null ? const Text('Change ') : const Text('Create '),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
