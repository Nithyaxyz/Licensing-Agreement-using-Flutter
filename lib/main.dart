import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_app/licensor_details_page.dart';

void main() {
  runApp(VividApp());
}

class VividApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vivid',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

// Home Page
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.lightBlue.shade50, Colors.lightBlue.shade100],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/viv.jpg',
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Welcome to Vivid',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Manage your digital content licensing with ease.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ContractFormPage()
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue.shade800,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5,
                  ),
                  child: Text(
                    'Manage Contracts',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Contract Form Page with Validation
class ContractFormPage extends StatefulWidget {
  const ContractFormPage({super.key});

  @override
  _ContractFormPageState createState() => _ContractFormPageState();
}

class _ContractFormPageState extends State<ContractFormPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController releaseDateController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String? dateError;

  // Function to validate date format
  bool isValidDate(String input) {
    try {
      DateFormat("yyyy-MM-dd").parseStrict(input);
      return true;
    } catch (e) {
      return false;
    }
  }

  void validateAndProceed() {
    setState(() {
      dateError = isValidDate(releaseDateController.text)
          ? null
          : "Enter a valid date (YYYY-MM-DD)";
    });

    if (dateError == null) {
      // Proceed to next step
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Form submitted successfully!")),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LicensorDetailsPage(
            movieTitle: titleController.text,
            releaseDate: releaseDateController.text,
            description: descriptionController.text,
          ),
        ),
      );  

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movie Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                "Enter Movie Details",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Movie Title',
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                controller: releaseDateController,
                decoration: InputDecoration(
                  labelText: 'Release Date (YYYY-MM-DD)',
                  border: OutlineInputBorder(),
                  errorText: dateError,
                ),
                keyboardType: TextInputType.datetime,
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ),

            SizedBox(height: 20),

            Center(
              child: ElevatedButton(
                onPressed: validateAndProceed,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Next',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
