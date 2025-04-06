import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'agreement-page.dart';
import 'utils.dart';

class LicenseeDetailsPage extends StatefulWidget {
  final String movieTitle;
  final String releaseDate;
  final String description;
  final String licensorName;
  final String licensorCompany;
  final String licensorEmail;
  final String licensorPhone;
  final String licensorAddress;
  final String licensorCountry;

  LicenseeDetailsPage({
    required this.movieTitle,
    required this.releaseDate,
    required this.description,
    required this.licensorName,
    required this.licensorCompany,
    required this.licensorEmail,
    required this.licensorPhone,
    required this.licensorAddress,
    required this.licensorCountry,
  });

  @override
  _LicenseeDetailsPageState createState() => _LicenseeDetailsPageState();
}

class _LicenseeDetailsPageState extends State<LicenseeDetailsPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _upfrontPaymentController = TextEditingController();
  final TextEditingController _revenueShareController = TextEditingController();

  String _selectedCountry = "India";
  String _selectedCountryCode = "+91";
  String _selectedLicenseType = "Exclusive";

  final List<String> _licenseTypes = [
    "Exclusive",
    "Non-Exclusive",
    "Streaming-Only",
    "Download & Streaming",
    "Perpetual",
    "Time-Limited",
  ];

  void _submitDetails() {
    if (_formKey.currentState!.validate()) {
      final agreement = generateLicenseAgreement(
        movieTitle: widget.movieTitle,
        releaseDate: widget.releaseDate,
        description: widget.description,
        licensorName: widget.licensorName,
        licensorCompany: widget.licensorCompany,
        licensorEmail: widget.licensorEmail,
        licensorPhone: widget.licensorPhone,
        licensorAddress: widget.licensorAddress,
        licensorCountry: widget.licensorCountry,
        licenseeName: _nameController.text,
        licenseeCompany: _companyController.text,
        licenseeEmail: _emailController.text,
        licenseePhone: _phoneController.text,
        licenseeAddress: _addressController.text,
        licenseeCountry: _selectedCountry,
        licenseType: _selectedLicenseType,
        upfrontPayment: _upfrontPaymentController.text,
        revenueShare: _revenueShareController.text,
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AgreementPage(agreementText: agreement),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Licensee Details")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField("Licensee Name", _nameController),
              _buildTextField("Company Name", _companyController),
              _buildEmailField(),
              _buildPhoneField(),
              _buildTextField("Address", _addressController),
              _buildCountryPicker(),
              _buildLicenseTypeDropdown(),
              _buildTextField("Upfront Payment (\$)", _upfrontPaymentController, isNumeric: true),
              _buildTextField("Revenue Share (%)", _revenueShareController, isNumeric: true),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: _submitDetails,
                child: Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool isNumeric = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        validator: (value) => value == null || value.isEmpty ? "Please enter $label" : null,
      ),
    );
  }

  Widget _buildEmailField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: _emailController,
        decoration: InputDecoration(
          labelText: "Email ID",
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null ||
              !RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(value)) {
            return "Enter a valid email";
          }
          return null;
        },
      ),
    );
  }

  Widget _buildPhoneField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(_selectedCountryCode),
          ),
          SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "Phone Number",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.length != 10) {
                  return "Enter valid 10-digit phone number";
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCountryPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Country", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            margin: EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_selectedCountry),
                Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLicenseTypeDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: "License Type",
          border: OutlineInputBorder(),
        ),
        value: _selectedLicenseType,
        items: _licenseTypes
            .map((type) => DropdownMenuItem(value: type, child: Text(type)))
            .toList(),
        onChanged: (value) {
          setState(() {
            _selectedLicenseType = value!;
          });
        },
      ),
    );
  }
}
