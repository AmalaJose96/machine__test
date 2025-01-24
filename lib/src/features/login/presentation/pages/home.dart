import 'package:flutter/material.dart';
import 'package:machine_test/src/features/login/presentation/pages/login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late bool _buttonVisible;

  @override
  void initState() {
    super.initState();
    _buttonVisible = false; // Initially, button is hidden
    _animateButton();
  }

  // Function to animate the Register Now button
  Future<void> _animateButton() async {
    await Future.delayed(const Duration(milliseconds: 800)); // Delay before the button appears
    setState(() {
      _buttonVisible = true; // Show the button after the delay
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/backgrndimage1.jpg', // Add your background image here
              fit: BoxFit.cover, // Stretch the image to cover the screen
            ),
          ),
          
       
        
          // Content: Register Now button with animation
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Title or other widgets can go here
                AnimatedOpacity(
                  opacity: _buttonVisible ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 1000), // Duration of the fade-in animation
                  child: AnimatedScale(
                    scale: _buttonVisible ? 1.0 : 0.5, // Scale effect
                    duration: const Duration(milliseconds: 1000), // Duration of the scale animation
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                       // Button color
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                       Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Login()),
            );
                      },
                      child: const Text(
                        'Register Now',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

