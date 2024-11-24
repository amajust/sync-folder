import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
    );
  }
}

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),

            // App Title with Consistent Divider
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.android, color: Colors.green, size: 30),
                    const SizedBox(width: 8),
                    Text(
                      "Android Devi Tools Installer",
                      style: GoogleFonts.roboto(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  height: 1, // Consistent height for the divider
                  color: Colors.grey.shade300, // Same color as footer divider
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Welcome Text
            Text(
              "Welcome to the Android Dev Tools Installer",
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Discover the seamless way to set up your development environment\nwith our comprehensive installer package, tailored for Android enthusiasts\nand professionals alike.",
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                fontSize: 16,
                color: Colors.black54,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 30),

            // Full-Body Android Mascot
            Image.asset(
              'images/android_logo.png', // Replace with the actual URL of the full-body Android mascot
              width: 300,
              height: 300,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 30),

            // Button
            ElevatedButton(
              onPressed: () {
                // Handle button press
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
              child: Text(
                "Lets go to Installation Options",
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 50),

            // Footer with Divider
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              height: 1, // Consistent height
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "© 2023 Android Dev Tools Installer",
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Privacy Policy",
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ),
                const Text(" | "),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Terms of Service",
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ),
                const Text(" | "),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Contact Us",
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

