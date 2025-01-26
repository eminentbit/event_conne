import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Privacy Policy', style: TextStyle(fontFamily: 'Open Sans')),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: const PrivacyPolicyContent(),
    );
  }
}

class PrivacyPolicyContent extends StatelessWidget {
  const PrivacyPolicyContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Introduction',
            style: TextStyle(
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Welcome to our app! We value your privacy and are committed to protecting your personal data. This Privacy Policy outlines how we handle your information.',
            style: TextStyle(fontFamily: 'Open Sans', fontSize: 16.0),
          ),
          SizedBox(height: 16),
          Text(
            'Information We Collect',
            style: TextStyle(
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'We may collect the following information:\n'
            '- Your name and contact details (email, phone number).\n'
            '- Location data, if enabled.\n'
            '- Payment information for transactions.\n'
            '- Usage data and preferences.',
            style: TextStyle(fontFamily: 'Open Sans', fontSize: 16.0),
          ),
          SizedBox(height: 16),
          Text(
            'How We Use Your Information',
            style: TextStyle(
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Your information is used to:\n'
            '- Provide and improve our services.\n'
            '- Process transactions and send notifications.\n'
            '- Personalize your app experience.\n'
            '- Comply with legal obligations.',
            style: TextStyle(fontFamily: 'Open Sans', fontSize: 16.0),
          ),
          SizedBox(height: 16),
          Text(
            'Sharing Your Information',
            style: TextStyle(
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'We do not share your personal information with third parties except as necessary to:\n'
            '- Complete transactions.\n'
            '- Comply with legal requirements.\n'
            '- Protect our rights and users.',
            style: TextStyle(fontFamily: 'Open Sans', fontSize: 16.0),
          ),
          SizedBox(height: 16),
          Text(
            'Your Rights',
            style: TextStyle(
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'You have the right to:\n'
            '- Access, update, or delete your personal data.\n'
            '- Opt-out of marketing communications.\n'
            '- Contact us with questions or concerns about your privacy.',
            style: TextStyle(fontFamily: 'Open Sans', fontSize: 16.0),
          ),
          SizedBox(height: 16),
          Text(
            'Contact Us',
            style: TextStyle(
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'If you have any questions about this Privacy Policy or our practices, please contact us at support@app.com.',
            style: TextStyle(fontFamily: 'Open Sans', fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}