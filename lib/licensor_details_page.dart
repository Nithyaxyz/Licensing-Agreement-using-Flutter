import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'LicenseeDetailsPage.dart';


class LicensorDetailsPage extends StatefulWidget {
  final String movieTitle;
  final String releaseDate;
  final String description;

  const LicensorDetailsPage({
    Key? key,
    required this.movieTitle,
    required this.releaseDate,
    required this.description,
  }) : super(key: key);

  @override
  _LicensorDetailsPageState createState() => _LicensorDetailsPageState();
}

class _LicensorDetailsPageState extends State<LicensorDetailsPage> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedCountry = "India";
  String? _selectedCountryCode = "+91";

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Licensor Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoField("Movie Title", widget.movieTitle),
                _buildInfoField("Release Date", widget.releaseDate),
                _buildInfoField("Description", widget.description),

                _buildTextField("Licensor Name", _nameController),
                _buildTextField("Company Name", _companyController),
                _buildEmailField(),
                _buildPhoneField(),
                _buildTextField("Company Address", _addressController),

                const SizedBox(height: 10),
                const Text("Country", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

                GestureDetector(
                  onTap: () {
                    showCountryPicker(
                      context: context,
                      showPhoneCode: true,
                      onSelect: (Country country) {
                        setState(() {
                          _selectedCountry = country.name;
                          _selectedCountryCode = "+${country.phoneCode}";
                        });
                      },
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_selectedCountry!),
                        const Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Navigate to Licensee Page and pass all values
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LicenseeDetailsPage(
                            movieTitle: widget.movieTitle,
                            releaseDate: widget.releaseDate,
                            description: widget.description,
                            licensorName: _nameController.text,
                            licensorCompany: _companyController.text,
                            licensorEmail: _emailController.text,
                            licensorPhone: _phoneController.text,
                            licensorAddress: _addressController.text,
                            licensorCountry: _selectedCountry!,
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text("Next"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        initialValue: value,
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter $label";
          }
          return null;
        },
      ),
    );
  }

  Widget _buildEmailField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: _emailController,
        decoration: const InputDecoration(
          labelText: "Email ID",
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null ||
              !RegExp(r"^[\w\.-]+@[\w\.-]+\.\w+$").hasMatch(value)) {
            return "Enter a valid email";
          }
          return null;
        },
      ),
    );
  }

  Widget _buildPhoneField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(_selectedCountryCode!),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "Phone Number",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null ||
                    value.length != 10 ||
                    !RegExp(r'^[0-9]+$').hasMatch(value)) {
                  return "Enter a valid 10-digit phone number";
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
