import 'package:flutter/material.dart';
import 'package:project2/herbalife/public/constants/Constants.dart';
import 'package:project2/herbalife/public/page/product.dart';
import 'package:project2/herbalife/public/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class Info extends StatefulWidget {
  final String? userId;
  const Info(this.userId, {super.key});

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> with SingleTickerProviderStateMixin {
  AnimationController? _animController;
  Animation<double>? _fadeAnim;
  Animation<Offset>? _slideAnim;

  @override
  void initState() {
    super.initState();
    final controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _animController = controller;
    _fadeAnim = CurvedAnimation(parent: controller, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
    controller.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<Authprovider>().getProfile();
    });
  }

  @override
  void dispose() {
    _animController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<Authprovider>();

    return Scaffold(
      backgroundColor: const Color(0xFFF1F8F1),
      body: Stack(
        children: [
          // ── decorative circles ───────────────────────────────────────
          Positioned(
            top: -80,
            left: -60,
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF388E3C).withValues(alpha: 0.10),
              ),
            ),
          ),
          Positioned(
            top: -40,
            right: -80,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF81C784).withValues(alpha: 0.13),
              ),
            ),
          ),
          Positioned(
            bottom: -60,
            right: -40,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF388E3C).withValues(alpha: 0.07),
              ),
            ),
          ),

          // ── main content ─────────────────────────────────────────────
          SafeArea(
            child: Column(
              children: [
                // ── custom app bar ──────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Herbalife",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: kPrimaryGreen,
                          fontSize: 22,
                          letterSpacing: -0.5,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF388E3C).withValues(alpha: 0.12),
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.stars_rounded,
                                size: 16, color: Color(0xFF43A047)),
                            const SizedBox(width: 6),
                            Text(
                              "${authProvider.ispoint}pt",
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF1B5E20),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              width: 1,
                              height: 14,
                              color: const Color(0xFFDCEEDC),
                            ),
                            const Icon(Icons.local_offer_rounded,
                                size: 15, color: Color(0xFF43A047)),
                            const SizedBox(width: 4),
                            Text(
                              "${authProvider.isdiscount}% off",
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF1B5E20),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // ── body ────────────────────────────────────────────────
                Expanded(
                  child: authProvider.isLoading
                      ? const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF43A047),
                      strokeWidth: 2.5,
                    ),
                  )
                      : FadeTransition(
                    opacity:
                    _fadeAnim ?? const AlwaysStoppedAnimation(1.0),
                    child: SlideTransition(
                      position: _slideAnim ??
                          const AlwaysStoppedAnimation(Offset.zero),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
                        child: Column(
                          children: [
                            // hero image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                'assets/images/herb2.png',
                                width: double.infinity,
                                height: 180,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 20),

                            // greeting
                            Align(
                              alignment: Alignment.centerLeft,
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Hello, ',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '${authProvider.isname}!',
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xFF1B5E20),
                                        fontFamily: 'KhmerFont',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // error message
                            if (authProvider.message != null &&
                                authProvider.message!.isNotEmpty &&
                                authProvider.message != "Profile loaded")
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 10),
                                decoration: BoxDecoration(
                                  color: Colors.red.shade50,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: Colors.red.shade200),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.error_outline,
                                        color: Colors.red.shade400,
                                        size: 18),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        authProvider.message!,
                                        style: TextStyle(
                                            color: Colors.red.shade600,
                                            fontSize: 13),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            const SizedBox(height: 20),

                            // profile card
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.fromLTRB(
                                  20, 22, 20, 22),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF388E3C)
                                        .withValues(alpha: 0.10),
                                    blurRadius: 24,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  // card title
                                  Row(
                                    children: [
                                      Container(
                                        width: 5,
                                        height: 28,
                                        decoration: BoxDecoration(
                                          color: kPrimaryGreen,
                                          borderRadius:
                                          BorderRadius.circular(4),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      const Text(
                                        'Profile Details',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF1B5E20),
                                          letterSpacing: -0.3,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 18),

                                  _buildInfoRow(
                                    icon: Icons.location_on_outlined,
                                    label: 'Address',
                                    value: authProvider.isaddress,
                                  ),
                                  const SizedBox(height: 14),
                                  _buildInfoRow(
                                    icon: Icons.phone_outlined,
                                    label: 'Phone',
                                    value: '0${authProvider.isphone}',
                                  ),
                                  const SizedBox(height: 14),
                                  _buildInfoRow(
                                    icon: Icons.mail_outline_rounded,
                                    label: 'Email',
                                    value: authProvider.isemail,
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 24),

                            // Continue button
                            SizedBox(
                              width: double.infinity,
                              height: 52,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Product(authProvider.userId),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: kPrimaryGreen,
                                  elevation: 0,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(16),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Continue',
                                      style: kTitleStyle.copyWith(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.3,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    const Icon(
                                        Icons.arrow_forward_rounded,
                                        color: Colors.white,
                                        size: 18),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      decoration: BoxDecoration(
        color: const Color(0xFFF5FBF5),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFDCEEDC), width: 1.5),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: const Color(0xFF43A047)),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF81C784),
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1B5E20),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}