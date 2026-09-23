import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: WelcomeBackForm()));

class WelcomeBackForm extends StatefulWidget {
  const WelcomeBackForm({super.key});

  @override
  State<WelcomeBackForm> createState() => _WelcomeBackFormState();
}

class _WelcomeBackFormState extends State<WelcomeBackForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  String _sex = 'Male';
  bool _machineLearning = true;
  bool _fullStack = true;
  bool _mobileApp = false;
  double _tuition = 50;
  String? _submittedMessage;

  String? _usernameError;
  String? _passwordError;

  void _handleSubmit() {
    setState(() {
      _usernameError =
          _usernameController.text.length < 10 ? 'Username must be 10 char long' : null;
      _passwordError =
          _passwordController.text.length < 8 ? 'Password must be 8 char long' : null;

      _submittedMessage =
          (_usernameError == null && _passwordError == null) ? 'Submitted successful 🎉' : null;
    });
  }

  void _handleClear() {
    setState(() {
      _usernameController.clear();
      _passwordController.clear();
      _sex = 'Male';
      _machineLearning = false;
      _fullStack = false;
      _mobileApp = false;
      _tuition = 50;
      _usernameError = null;
      _passwordError = null;
      _submittedMessage = null;
    });
  }

  // Reusable labeled field row.
  // TextField expands to fill the Row, wrapped in Expanded so it doesn't
  // throw a layout error (TextField has no intrinsic width on its own).
  Widget _buildFieldRow({
    required String label,
    required TextEditingController controller,
    String? errorText,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 90,
            child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: obscureText,
              decoration: InputDecoration(
                isDense: true,
                filled: true,
                fillColor: Colors.grey.shade200,
                border: const OutlineInputBorder(),
                errorText: errorText,
                suffixIcon: suffixIcon,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Center(
        child: Container(
          width: 340,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: Colors.grey.shade300,
                padding: const EdgeInsets.symmetric(vertical: 12),
                alignment: Alignment.center,
                child: const Text('Welcome Back!!!',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 12),

              _buildFieldRow(
                label: 'Username',
                controller: _usernameController,
                errorText: _usernameError,
              ),

              _buildFieldRow(
                label: 'Password',
                controller: _passwordController,
                obscureText: _obscurePassword,
                errorText: _passwordError,
                suffixIcon: IconButton(
                  icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                ),
              ),

              const SizedBox(height: 8),
              const Text('Sex', style: TextStyle(fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Radio<String>(
                    value: 'Male',
                    groupValue: _sex,
                    onChanged: (v) => setState(() => _sex = v!),
                  ),
                  const Text('Male'),
                  Radio<String>(
                    value: 'Female',
                    groupValue: _sex,
                    onChanged: (v) => setState(() => _sex = v!),
                  ),
                  const Text('Female'),
                ],
              ),

              const SizedBox(height: 8),
              const Text('Courses', style: TextStyle(fontWeight: FontWeight.bold)),
              CheckboxListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                title: const Text('Machine Learning'),
                value: _machineLearning,
                onChanged: (v) => setState(() => _machineLearning = v!),
              ),
              CheckboxListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                title: const Text('Full stack'),
                value: _fullStack,
                onChanged: (v) => setState(() => _fullStack = v!),
              ),
              CheckboxListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                title: const Text('Mobile application'),
                value: _mobileApp,
                onChanged: (v) => setState(() => _mobileApp = v!),
              ),

              const SizedBox(height: 8),
              const Text('Tuition', style: TextStyle(fontWeight: FontWeight.bold)),
              Slider(
                value: _tuition,
                min: 0,
                max: 100,
                activeColor: Colors.green,
                onChanged: (v) => setState(() => _tuition = v),
              ),

              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow.shade100,
                        foregroundColor: Colors.black,
                      ),
                      onPressed: _handleSubmit,
                      child: const Text('Submit'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: _handleClear,
                      child: const Text('Clear'),
                    ),
                  ),
                ],
              ),

              if (_submittedMessage != null) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.black87,
                  alignment: Alignment.center,
                  child: Text(_submittedMessage!,
                      style: const TextStyle(color: Colors.white)),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
