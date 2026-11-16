import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fundsy/app/themes/app_colors.dart';
import 'package:fundsy/app/navigation/main_app_navigator.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  // Controller for the OTP input field
  final TextEditingController _otpController = TextEditingController();

  // State to track if there is an error (for box border color, button color, and error message)
  bool _hasError = false;
  String _errorMessage = '';

  // State to track if the code has been successfully resent
  bool _isResent = false;
  String _resendMessage = '';

  // Function to handle OTP verification logic with inline error display
  void _verifyOtp() {
    String otpCode = _otpController.text.trim();

    setState(() {
      // Validation: Check if the field is empty
      if (otpCode.isEmpty) {
        _hasError = true;
        _errorMessage = 'Please enter the verification code.';
        return;
      }

      // Validation: Check if the code is incomplete (less than 6 digits)
      if (otpCode.length < 6) {
        _hasError = true;
        _errorMessage = 'Verification code must be 6 digits.';
        return;
      }

      // Clear error if validation passes successfully
      _hasError = false;
      _errorMessage = '';
    });

    // If there is an error, stop here and do not navigate
    if (_hasError) return;

    // If validation passes successfully, proceed to dashboard
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MainAppNavigator()),
          (route) => false,
    );
  }

  // Function to handle resend code action with inline message below
  void _resendCode() {
    setState(() {
      _isResent = true;
      _resendMessage = 'Verification code resent successfully!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              // Logo Placeholder Container
              Container(
                width: 140,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade400, width: 1.5),
                ),
                child: const Center(
                  child: Text(
                    'LOGO PLACEHOLDER',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Title Header
              const Text(
                'Enter Verification Code',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'We have sent a 6-digit verification code to your email address. Please enter it below.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // OTP Input Field with Dynamic Border Color based on Error State
              TextField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                onChanged: (value) {
                  // Clear error automatically when user starts typing again
                  if (_hasError) {
                    setState(() {
                      _hasError = false;
                      _errorMessage = '';
                    });
                  }
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly, // Blocks letters and special characters
                ],
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 8,
                ),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  counterText: '',
                  hintText: '------',
                  hintStyle: TextStyle(letterSpacing: 8, color: Colors.grey.shade400),
                  // Changes border to red if _hasError is true, otherwise normal grey/indigo
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(
                      color: _hasError ? Colors.redAccent : Colors.grey.shade300,
                      width: _hasError ? 2.0 : 1.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(
                      color: _hasError ? Colors.redAccent : Colors.grey.shade200,
                      width: _hasError ? 2.0 : 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(
                      color: _hasError ? Colors.redAccent : AppColors.primary,
                      width: 2.0,
                    ),
                  ),
                ),
              ),

              // Inline Error Message Displayed Directly Below the Box
              if (_hasError) ...[
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Text(
                      _errorMessage,
                      style: const TextStyle(
                        color: Colors.redAccent,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],

              const SizedBox(height: 24),

              // Verify & Proceed Button (Turns red if there is an error)
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _hasError ? Colors.redAccent : AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  onPressed: _verifyOtp, // Calls our validation function
                  child: const Text(
                    'Verify Code',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Resend Section with "Resend" text and inline feedback message below
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Didn't receive the code? ",
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                        GestureDetector(
                          onTap: _resendCode, // Triggers inline resend message
                          child: const Text(
                            'Resend',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF8BC34A),
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Inline Success Message Displayed Directly Below the Resend Box
                  if (_isResent) ...[
                    const SizedBox(height: 8),
                    Text(
                      _resendMessage,
                      style: const TextStyle(
                        color: Color(0xFF8BC34A),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}