import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:telr_payment_gateway/telr_payment_gateway.dart';



class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  // Example store credentials for testing
  final String storeId = "31730"; // Replace with your actual store ID
  final String secretKey = "6QsRj-Wxw7S@R6sz"; // Replace with your actual secret key
  final String amount = "20"; // Payment amount
  final String currency = "AED"; // Currency
  final String transactionType = "sale"; // Transaction type
  final String language = "EN"; // Language
  String _platformVersion = 'Unknown'; // To track platform version

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Initialize platform state asynchronously
  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion = await TelrPaymentGateway.platformVersion ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  // Method to initiate payment using Telr Payment Gateway
  Future<void> initiatePayment() async {
    try {
      // Log the payment parameters for debugging purposes
      print("Initiating Payment with the following details:");
      print("Store ID: $storeId");
      print("Secret Key: $secretKey");
      print("Amount: $amount");
      print("Currency: $currency");
      print("Transaction Type: $transactionType");
      print("Language: $language");

      // Log billing details
      print("Billing Details:");
      print("Name: John Doe");
      print("Email: john.doe@example.com");
      print("Phone: 528636596");
      print("City: Dubai");
      print("Country: AE");

      // Call TelrPaymentGateway to initiate the payment and get the response
      String message = await TelrPaymentGateway.callTelRForTransaction(
        store_id: storeId,
        key: secretKey,
        amount: amount,
        app_install_id: "123456", // Your app install ID
        app_name: "TelR",
        app_user_id: "12345", // User ID
        app_version: "1.0.0", // App version
        sdk_version: "123", // SDK version
        mode: "1", // Set mode to "0" for test, "1" for live mode
        tran_type: transactionType,
        tran_cart_id: "1003", // Transaction Cart ID
        desc: "Test Payment", // Payment description
        tran_lang: language,
        tran_currency: currency,
        bill_city: "Dubai", // Billing city
        bill_country: "AE", // Billing country
        bill_region: "Dubai", // Billing region
        bill_address: "SIT GTower", // Billing address
        bill_first_name: "John", // Billing first name
        bill_last_name: "Doe", // Billing last name
        bill_title: "Mr", // Billing title
        bill_email: "john.doe@example.com", // Billing email
        bill_phone: "528636596", // Billing phone
      ) ?? 'Unknown Message';

      // Print the response message (URL or status)
      print("Telr Payment Response: $message");

      // Check if the response is success or failure
      if (message == "SUCCESS") {
        print("Payment successful!");
      } else {
        print("Payment failed with response: $message");
      }

      // Show feedback to the user based on payment success or failure
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message == "SUCCESS" ? "Payment Successful!" : "Payment Failed!"),
        ),
      );
    } catch (e) {
      // Catch any errors and print debug information
      print("Error occurred during payment process: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred during payment!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Telr Payment Gateway'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Running on: $_platformVersion\n'),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              await initiatePayment();
              print("Cheeeeckkk");
            },
            child: Text('Pay Now'),
          ),
        ],
      ),
    );
  }
}