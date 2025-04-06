String generateLicenseAgreement({
  required String movieTitle,
  required String releaseDate,
  required String description,

  required String licensorName,
  required String licensorCompany,
  required String licensorEmail,
  required String licensorPhone,
  required String licensorAddress,
  required String licensorCountry,

  required String licenseeName,
  required String licenseeCompany,
  required String licenseeEmail,
  required String licenseePhone,
  required String licenseeAddress,
  required String licenseeCountry,

  required String licenseType,
  required String upfrontPayment,
  required String revenueShare,
}) {
  return '''
🎬 LICENSING AGREEMENT

This Licensing Agreement (“Agreement”) is made and entered into on $releaseDate between:

**Licensor:**  
Name: $licensorName  
Company: $licensorCompany  
Email: $licensorEmail  
Phone: $licensorPhone  
Address: $licensorAddress  
Country: $licensorCountry  

**Licensee:**  
Name: $licenseeName  
Company: $licenseeCompany  
Email: $licenseeEmail  
Phone: $licenseePhone  
Address: $licenseeAddress  
Country: $licenseeCountry  

---

**1. Licensed Work**  
Title: $movieTitle  
Description: $description  
Release Date: $releaseDate  

**2. Grant of License**  
The Licensor hereby grants to the Licensee a **$licenseType** license to use, distribute, or otherwise exploit the Licensed Work as outlined in this agreement.

**3. Payment Terms**  
- Upfront Payment: \$$upfrontPayment  
- Revenue Share: $revenueShare%

**4. Ownership**  
Licensor retains full ownership of the Licensed Work. Licensee is granted rights solely as per the terms of this agreement.

**5. Term and Termination**  
This agreement remains effective unless terminated by either party with a 30-day written notice.

**6. Governing Law**  
This agreement shall be governed by the laws of the Licensor's country: $licensorCountry.

---

**IN WITNESS WHEREOF**, the parties hereto have executed this Agreement on the date first above written.

_________________________  
Licensor: $licensorName  

_________________________  
Licensee: $licenseeName  
''';
}
