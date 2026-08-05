import 'package:flutter/material.dart';
import '../models/ministry.dart';
import '../models/ministry_membership.dart';
import '../models/user_profile.dart';
import '../theme/app_theme.dart';
import '../widgets/logo_header.dart';
import 'home_screen.dart';
import 'ministry_signup_screen.dart';

class PendingApprovalScreen extends StatelessWidget {
  final UserProfile profile;
  final String ministryId;
  final MembershipType membershipType;

  const PendingApprovalScreen({
    super.key,
    required this.profile,
    required this.ministryId,
    required this.membershipType,
  });

  @override
  Widget build(BuildContext context) {
    final ministryName = Ministry.all.firstWhere((m) => m.id == ministryId).name;
    final actionWord = membershipType == MembershipType.existingMember ? 'membership' : 'join request';

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const LogoHeader(height: 80),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.hourglass_top, size: 48, color: AppTheme.black),
                    const SizedBox(height: 20),
                    Text(
                      'Waiting on admin approval',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Your $actionWord for $ministryName has been sent to the admin team. '
                      'You\'ll get access once it\'s approved.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 32),
                    // Demo-only shortcut. In the real app this screen just
                    // waits (with a push notification on approval) — remove
                    // this button once the backend/admin approval flow exists.
                    OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => HomeScreen(
                              profile: profile,
                              memberships: [
                                MinistryMembership(
                                  ministryId: ministryId,
                                  status: MembershipStatus.approved,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: const Text('Simulate approval (demo only)'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
