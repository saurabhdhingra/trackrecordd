import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Privacy Policy"),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Privacy Policy",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Your privacy is important to us. This privacy policy explains how our workout tracking application collects, uses, and safeguards your information.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle("1. Information We Collect"),
            const Text(
              "We collect the following personal information from you:\n- Name\n- Email address\n- Age\n- Body measurements (e.g., weight, height, etc.)",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle("2. How We Use Your Information"),
            const Text(
              "We use your information for the following purposes:\n- To track your workout progress and body measurements.\n- To personalize your experience with the app.\n- To contact you if needed regarding app updates or issues.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle("3. Data Security"),
            const Text(
              "We are committed to ensuring that your information is secure. We have implemented suitable physical, electronic, and managerial procedures to safeguard and secure the information we collect online.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle("4. No Sharing of Personal Data"),
            const Text(
              "We do not share, sell, rent, or trade your personal data with any third parties.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle("5. Your Consent"),
            const Text(
              "By using our app, you consent to the collection and use of your information as outlined in this Privacy Policy.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle("6. Changes to This Privacy Policy"),
            const Text(
              "We reserve the right to update this Privacy Policy at any time. Any changes will be posted here.",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
