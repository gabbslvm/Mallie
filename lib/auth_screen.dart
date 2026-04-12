import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'mallie_home_screen.dart';

class AuthScreen extends StatefulWidget {
  final List<String> selectedPreferences;
  const AuthScreen({super.key, this.selectedPreferences = const []});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  bool _isLogin = false;
  bool _obscurePass = true;
  bool _obscureConfirm = true;
  bool _isLoading = false;

  bool _isNewUser = true;
  String? _rememberedEmail;

  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  late final AnimationController _animCtrl;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _checkUserStatus();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 380),
    );
    _fade = CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.05),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut));
    _animCtrl.forward();
  }

  Future<void> _checkUserStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final hasAccount = prefs.getBool('has_account') ?? false;
    final storedEmail = prefs.getString('user_email');

    setState(() {
      _isNewUser = !hasAccount;
      _isLogin = false;
      _rememberedEmail = storedEmail;
      _emailCtrl.clear();
    });
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  void _switchMode() {
    _formKey.currentState?.reset();
    _passCtrl.clear();
    _confirmCtrl.clear();

    setState(() {
      _isLogin = !_isLogin;
      if (_isLogin && _rememberedEmail != null) {
        _emailCtrl.text = _rememberedEmail!;
      } else if (!_isLogin) {
        _emailCtrl.clear();
      }
    });

    _animCtrl
      ..reset()
      ..forward();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final navigator = Navigator.of(context);

    final prefs = await SharedPreferences.getInstance();
    final email = _emailCtrl.text.trim();
    final password = _passCtrl.text;

    setState(() => _isLoading = true);

    await Future.delayed(const Duration(milliseconds: 1600));

    if (!mounted) return;

    if (_isLogin) {
      final storedEmail = prefs.getString('user_email');
      final storedPass = prefs.getString('user_password');

      if (email != storedEmail || password != storedPass) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid email or password. Please try again.'),
            backgroundColor: Color(0xFFE05555),
          ),
        );
        return;
      }
    } else {
      await prefs.setString('user_email', email);
      await prefs.setString('user_password', password);
      await prefs.setBool('has_account', true);
    }

    setState(() => _isLoading = false);

    final displayName = _isLogin
        ? email.split('@').first
        : _nameCtrl.text.trim();

    navigator.pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => MallieHomeScreen(
          userName: displayName,
          userEmail: email,
          selectedPreferences: widget.selectedPreferences,
        ),
      ),
      (route) => false,
    );
  }

  String? _validatePassword(String? v) {
    if (v == null || v.isEmpty) return 'Password is required';

    if (!_isLogin) {
      if (v.length < 8) return 'Minimum 8 characters required';
      if (!v.contains(RegExp(r'[A-Z]'))) {
        return 'Must contain an uppercase letter';
      }
      if (!v.contains(RegExp(r'[0-9]'))) {
        return 'Must contain at least one number';
      }
      if (!v.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
        return 'Must contain a special character';
      }
    }
    return null;
  }

  InputDecoration _fieldDeco({
    required String label,
    required IconData prefixIcon,
    Widget? suffix,
    bool readOnly = false,
  }) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(
        color: Color(0xFF6A8FAF),
        fontSize: 13.5,
        fontWeight: FontWeight.w400,
      ),
      prefixIcon: Icon(prefixIcon, color: const Color(0xFF165CA1), size: 20),
      suffixIcon: suffix,
      filled: true,
      fillColor: readOnly ? const Color(0xFFF0F7FF) : Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
      border: _border(const Color(0xFFB8D4E8)),
      enabledBorder: _border(const Color(0xFFB8D4E8)),
      focusedBorder: _border(const Color(0xFF165CA1), width: 1.8),
      errorBorder: _border(const Color(0xFFE05555)),
      focusedErrorBorder: _border(const Color(0xFFE05555), width: 1.8),
      errorStyle: const TextStyle(color: Color(0xFFE05555), fontSize: 11.5),
    );
  }

  OutlineInputBorder _border(Color c, {double width = 1.2}) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
        borderSide: BorderSide(color: c, width: width),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFa8d2e6), Color(0xFFeaf6ff), Color(0xFFffffff)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
              child: Column(
                children: [
                  const _MallieLogo(),
                  const SizedBox(height: 18),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(
                            0xFF165CA1,
                          ).withValues(alpha: 0.10),
                          blurRadius: 32,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.fromLTRB(22, 26, 22, 28),
                    child: Column(
                      children: [
                        if (!_isNewUser)
                          _AuthTabSwitcher(
                            isLogin: _isLogin,
                            onSwitch: _switchMode,
                          ),
                        if (!_isNewUser) const SizedBox(height: 26),
                        FadeTransition(
                          opacity: _fade,
                          child: SlideTransition(
                            position: _slide,
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  if (!_isLogin) ...[
                                    TextFormField(
                                      controller: _nameCtrl,
                                      style: const TextStyle(
                                        color: Color(0xFF1a1a1a),
                                        fontSize: 14,
                                      ),
                                      decoration: _fieldDeco(
                                        label: 'Full Name',
                                        prefixIcon:
                                            Icons.person_outline_rounded,
                                      ),
                                      validator: (v) =>
                                          (v == null || v.trim().isEmpty)
                                          ? 'Please enter your name'
                                          : null,
                                    ),
                                    const SizedBox(height: 14),
                                  ],
                                  TextFormField(
                                    controller: _emailCtrl,
                                    readOnly:
                                        _isLogin && _rememberedEmail != null,
                                    keyboardType: TextInputType.emailAddress,
                                    style: const TextStyle(
                                      color: Color(0xFF1a1a1a),
                                      fontSize: 14,
                                    ),
                                    decoration: _fieldDeco(
                                      label: 'Email Address',
                                      prefixIcon: Icons.alternate_email_rounded,
                                      readOnly:
                                          _isLogin && _rememberedEmail != null,
                                    ),
                                    validator: (v) {
                                      if (v == null || v.trim().isEmpty) {
                                        return 'Email is required';
                                      }

                                      if (!RegExp(
                                        r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$',
                                      ).hasMatch(v)) {
                                        return 'Enter a valid email';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 14),
                                  TextFormField(
                                    controller: _passCtrl,
                                    obscureText: _obscurePass,
                                    style: const TextStyle(
                                      color: Color(0xFF1a1a1a),
                                      fontSize: 14,
                                    ),
                                    decoration: _fieldDeco(
                                      label: 'Password',
                                      prefixIcon: Icons.lock_outline_rounded,
                                      suffix: IconButton(
                                        icon: Icon(
                                          _obscurePass
                                              ? Icons.visibility_off_outlined
                                              : Icons.visibility_outlined,
                                          color: const Color(0xFF6A8FAF),
                                          size: 20,
                                        ),
                                        onPressed: () => setState(
                                          () => _obscurePass = !_obscurePass,
                                        ),
                                      ),
                                    ),
                                    validator: _validatePassword,
                                  ),
                                  if (!_isLogin) ...[
                                    const SizedBox(height: 14),
                                    TextFormField(
                                      controller: _confirmCtrl,
                                      obscureText: _obscureConfirm,
                                      style: const TextStyle(
                                        color: Color(0xFF1a1a1a),
                                        fontSize: 14,
                                      ),
                                      decoration: _fieldDeco(
                                        label: 'Confirm Password',
                                        prefixIcon: Icons.lock_reset_rounded,
                                        suffix: IconButton(
                                          icon: Icon(
                                            _obscureConfirm
                                                ? Icons.visibility_off_outlined
                                                : Icons.visibility_outlined,
                                            color: const Color(0xFF6A8FAF),
                                            size: 20,
                                          ),
                                          onPressed: () => setState(
                                            () => _obscureConfirm =
                                                !_obscureConfirm,
                                          ),
                                        ),
                                      ),
                                      validator: (v) {
                                        if (v == null || v.isEmpty) {
                                          return 'Confirm your password';
                                        }

                                        if (v != _passCtrl.text) {
                                          return 'Passwords do not match';
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                  if (_isLogin) ...[
                                    const SizedBox(height: 10),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: GestureDetector(
                                        onTap: () {},
                                        child: const Text(
                                          'Forgot password?',
                                          style: TextStyle(
                                            color: Color(0xFF165CA1),
                                            fontSize: 12.5,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                  const SizedBox(height: 26),
                                  _SubmitButton(
                                    label: _isLogin
                                        ? 'Sign In'
                                        : 'Create Account',
                                    isLoading: _isLoading,
                                    onTap: _submit,
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    children: const [
                                      Expanded(
                                        child: Divider(
                                          color: Color(0xFFD6E8F2),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 12,
                                        ),
                                        child: Text(
                                          'or continue with',
                                          style: TextStyle(
                                            color: Color(0xFF6A8FAF),
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Divider(
                                          color: Color(0xFFD6E8F2),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _SocialButton(
                                          label: 'Google',
                                          icon: Icons.g_mobiledata_rounded,
                                          onTap: () {},
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: _SocialButton(
                                          label: 'Facebook',
                                          icon: Icons.facebook_rounded,
                                          onTap: () {},
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (!_isNewUser)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _isLogin
                              ? "Don't have an account? "
                              : 'Already have an account? ',
                          style: const TextStyle(
                            color: Color(0xFF4A6A8A),
                            fontSize: 13,
                          ),
                        ),
                        GestureDetector(
                          onTap: _switchMode,
                          child: Text(
                            _isLogin ? 'Sign Up' : 'Sign In',
                            style: const TextStyle(
                              color: Color(0xFFF0B552),
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  if (!_isLogin) ...[
                    const SizedBox(height: 12),
                    const Text(
                      'By signing up, you agree to our Terms of Service\nand Privacy Policy.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF6A8FAF),
                        fontSize: 11,
                        height: 1.6,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MallieLogo extends StatelessWidget {
  const _MallieLogo();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/MallieLogoMain.png',
          width: 180,
          height: 180,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) => const Icon(
            Icons.store_mall_directory_rounded,
            color: Color(0xFFF0B552),
            size: 80,
          ),
        ),
        const SizedBox(height: 0),
        const Text(
          'MALLIE',
          style: TextStyle(
            color: Color(0xFFF0B552),
            fontSize: 32,
            fontWeight: FontWeight.w900,
            letterSpacing: 2.0,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Your friendly mall companion',
          style: TextStyle(
            color: Color(0xFF4A6A8A),
            fontSize: 13,
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }
}

class _AuthTabSwitcher extends StatelessWidget {
  final bool isLogin;
  final VoidCallback onSwitch;
  const _AuthTabSwitcher({required this.isLogin, required this.onSwitch});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFFEAF6FF),
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: const Color(0xFFB8D4E8), width: 1),
      ),
      child: Row(
        children: [
          _Tab(
            label: 'Sign In',
            active: isLogin,
            onTap: () => !isLogin ? onSwitch() : null,
          ),
          _Tab(
            label: 'Sign Up',
            active: !isLogin,
            onTap: () => isLogin ? onSwitch() : null,
          ),
        ],
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;
  const _Tab({required this.label, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: active ? const Color(0xFF165CA1) : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: active ? Colors.white : const Color(0xFF6A8FAF),
              fontSize: 14,
              fontWeight: active ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class _SubmitButton extends StatefulWidget {
  final String label;
  final bool isLoading;
  final VoidCallback onTap;
  const _SubmitButton({
    required this.label,
    required this.isLoading,
    required this.onTap,
  });

  @override
  State<_SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<_SubmitButton> {
  bool _pressed = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          width: double.infinity,
          height: 54,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFFCA28), Color(0xFFF0B552)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          alignment: Alignment.center,
          child: widget.isLoading
              ? const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Text(
                  widget.label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  const _SocialButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: const Color(0xFFF4F9FD),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFB8D4E8), width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: const Color(0xFF165CA1), size: 22),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF165CA1),
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}