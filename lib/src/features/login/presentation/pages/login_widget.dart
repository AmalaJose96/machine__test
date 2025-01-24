import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:machine_test/src/features/home/presentation/pages/home.dart';
import 'package:machine_test/src/features/login/data/models/login_request.dart';
import 'package:machine_test/src/features/login/presentation/bloc/login_bloc.dart';
import 'package:machine_test/src/features/login/presentation/widgets/custom_button_widget.dart';
import 'package:machine_test/src/features/login/presentation/widgets/textformfield_widget.dart';
import 'package:machine_test/src/utils/constants/app_constants.dart';
import 'package:machine_test/src/utils/helpers/extentions.dart';
import 'package:machine_test/src/utils/toasters/toast.dart';

class LoginBodyWidget extends StatefulWidget {
  const LoginBodyWidget({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.usernameController,
    required this.phonescontroller,
    required this.timescontroller,
    required this.purposescontroller,
    required this.emailscontroller,
    required this.genderscontroller,
    required this.datescontroller,
    required this.remarkscontroller,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final TextEditingController usernameController;
  final TextEditingController phonescontroller;
  final TextEditingController timescontroller;
  final TextEditingController purposescontroller;
  final TextEditingController emailscontroller;
  final TextEditingController genderscontroller;
  final TextEditingController datescontroller;
  final TextEditingController remarkscontroller;

  @override
  _LoginBodyWidgetState createState() => _LoginBodyWidgetState();
}

class _LoginBodyWidgetState extends State<LoginBodyWidget> {
  late List<bool> _formFieldVisibility;
  late bool _logoVisible;

  // Dropdown options for the time, gender, and date fields
  final List<String> _timeOptions = [
    'AM',
    'PM',
  ];

  final List<String> _genderOptions = [
    'Male',
    'Female',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    _formFieldVisibility = List.generate(8, (index) => false);
    _logoVisible = false;  // Initially logo is not visible
    _animateFormFields();
    _animateLogo();
  }

  // Animate form fields sequentially
  Future<void> _animateFormFields() async {
    for (int i = 0; i < _formFieldVisibility.length; i++) {
      await Future.delayed(Duration(milliseconds: 300 * i));
      setState(() {
        _formFieldVisibility[i] = true;
      });
    }
  }

  // Animate logo
  Future<void> _animateLogo() async {
    await Future.delayed(const Duration(milliseconds: 200)); // Delay before logo animation
    setState(() {
      _logoVisible = true;
    });
  }

  // Date Picker function
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        widget.datescontroller.text = "${pickedDate.toLocal()}".split(' ')[0]; // Format to yyyy-mm-dd
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginFailedState) {
            showToast(state.error);
          }
          if (state is LoginSuccessState) {
            widget.usernameController.clear();
            widget.phonescontroller.clear();
            widget.timescontroller.clear();
            widget.purposescontroller.clear();
            widget.emailscontroller.clear();
            widget.genderscontroller.clear();
            widget.datescontroller.clear();
            widget.remarkscontroller.clear();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Home(
                  name: state.response?.name ?? '',
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              // Background Image
              Positioned.fill(
                child: Image.asset(
                  'assets/bckimage.jpg',  // Add your background image here
                  fit: BoxFit.cover,  // This will stretch the image to fill the screen
                ),
              ),

              // Form Section
              Form(
                key: widget._formKey,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Carousel Slider on the Left
                    Expanded(
                      flex: 1,
                      child: CarouselSlider(
                        options: CarouselOptions(
                          autoPlay: true,
                          enlargeCenterPage: false,
                          viewportFraction: 1.0,
                          aspectRatio: 0.1,
                          initialPage: 0,
                        ),
                        items: [
                          'assets/image1.png',
                          'assets/image2.png',
                          'assets/image3.png',
                        ].map((imagePath) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    imagePath,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ),

                    // Form Fields on the Right
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Logo Animation (Scale and Fade-in)
                            AnimatedOpacity(
                              opacity: _logoVisible ? 1.0 : 0.0,
                              duration: const Duration(milliseconds: 500),
                              child: AnimatedScale(
                                scale: _logoVisible ? 1.0 : 0.5,
                                duration: const Duration(milliseconds: 500),
                                child: Center(
                                  child: Image.asset(
                                    'assets/icon.png',  // Your logo file
                                    width: 130,
                                    height: 130,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 30),

                            AnimatedOpacity(
                              opacity: _formFieldVisibility[0] ? 1.0 : 0.0,
                              duration: const Duration(milliseconds: 500),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormFieldWidget(
                                      prefixIcon: Icons.person_2_outlined,
                                      controller: widget.usernameController,
                                      errorText: StringConstants.usernameError,
                                      hintText: StringConstants.name,
                                      inputType: InputTypes.username,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: TextFormFieldWidget(
                                      prefixIcon: Icons.phone,
                                      controller: widget.phonescontroller,
                                      errorText: StringConstants.phoneError,
                                      hintText: StringConstants.phone,
                                      inputType: InputTypes.username,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            20.height,
                            AnimatedOpacity(
                              opacity: _formFieldVisibility[1] ? 1.0 : 0.0,
                              duration: const Duration(milliseconds: 500),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: widget.timescontroller,
                                      readOnly: true, // Prevent manual input
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(Icons.timeline_outlined),
                                        hintText: StringConstants.visitedTime,
                                        suffixIcon: PopupMenuButton<String>(
                                          icon: const Icon(Icons.arrow_drop_down), // Dropdown icon
                                          onSelected: (String value) {
                                            setState(() {
                                              widget.timescontroller.text = value; // Update text field value
                                            });
                                          },
                                          itemBuilder: (BuildContext context) {
                                            return _timeOptions.map((String time) {
                                              return PopupMenuItem<String>(
                                                value: time,
                                                child: Text(time),
                                              );
                                            }).toList();
                                          },
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white.withOpacity(1.0), // Transparent background
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: TextFormFieldWidget(
                                      controller: widget.purposescontroller,
                                      errorText: StringConstants.purposeError,
                                      hintText: StringConstants.purpose,
                                      inputType: InputTypes.username,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            20.height,
                            AnimatedOpacity(
                              opacity: _formFieldVisibility[2] ? 1.0 : 0.0,
                              duration: const Duration(milliseconds: 500),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormFieldWidget(
                                      prefixIcon: Icons.email,
                                      controller: widget.emailscontroller,
                                      errorText: StringConstants.email,
                                      hintText: StringConstants.email,
                                      inputType: InputTypes.username,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: TextFormField(
                                      controller: widget.genderscontroller,
                                      readOnly: true, // Prevent manual input
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(Icons.person),
                                        hintText: StringConstants.gender,
                                        suffixIcon: PopupMenuButton<String>(
                                          icon: const Icon(Icons.arrow_drop_down), // Dropdown icon
                                          onSelected: (String value) {
                                            setState(() {
                                              widget.genderscontroller.text = value; // Update text field value
                                            });
                                          },
                                          itemBuilder: (BuildContext context) {
                                            return _genderOptions.map((String gender) {
                                              return PopupMenuItem<String>(
                                                value: gender,
                                                child: Text(gender),
                                              );
                                            }).toList();
                                          },
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white.withOpacity(1.0), // Transparent background
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            20.height,
                            AnimatedOpacity(
                              opacity: _formFieldVisibility[3] ? 1.0 : 0.0,
                              duration: const Duration(milliseconds: 500),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: widget.datescontroller,
                                      readOnly: true, // Prevent manual input
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(Icons.date_range),
                                        hintText: StringConstants.visitedDate,
                                        suffixIcon: IconButton(
                                          icon: const Icon(Icons.calendar_today), // Calendar icon
                                          onPressed: () => _selectDate(context), // Open date picker
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white.withOpacity(1.0), // Transparent background
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: TextFormFieldWidget(
                                      controller: widget.remarkscontroller,
                                      errorText: StringConstants.remarks,
                                      hintText: StringConstants.remarks,
                                      inputType: InputTypes.username,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            20.height,

                            // Submit Button with Animation
                            AnimatedOpacity(
                              opacity: _formFieldVisibility[4] ? 1.0 : 0.0,
                              duration: const Duration(milliseconds: 500),
                              child: Center(
                                child: PrimaryButton(
                                  isLoading: state is LoginLoadingState,
                                  title: StringConstants.buttonText,
                                  onTap: () {
                                    if (widget._formKey.currentState!.validate()) {
                                      context.read<LoginBloc>().add(OnLoginEvent(
                                            loginRequest: LoginRequest(
                                              username: widget.usernameController.text.trim(),
                                              password: widget.phonescontroller.text.trim(),
                                            ),
                                          ));
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
