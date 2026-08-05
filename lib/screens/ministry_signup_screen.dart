import 'package:flutter/material.dart';
import '../models/ministry.dart';
import '../models/user_profile.dart';
import '../theme/app_theme.dart';
import '../widgets/logo_header.dart';
import 'pending_approval_screen.dart';

enum MembershipType { existingMember, wantsToJoin }

class MinistrySignupScreen extends StatefulWidget {
  final UserProfile profile;

  const MinistrySignupScreen({super.key, required this.profile});

  @override
  State<MinistrySignupScreen> createState() => _MinistrySignupScreenState();
}

class _MinistrySignupScreenState extends State<MinistrySignupScreen> {
  String? _selectedMinistryId;
  MembershipType _membershipType = MembershipType.existingMember;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const LogoHeader(height: 80),
            const SizedBox(height: 12),
            const Text(
              'Which ministry?',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: _ToggleChip(
                      label: "I'm already a member",
                      selected: _membershipType == MembershipType.existingMember,
                      onTap: () => setState(() => _membershipType = MembershipType.existingMember),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _ToggleChip(
                      label: 'I want to join',
                      selected: _membershipType == MembershipType.wantsToJoin,
                      onTap: () => setState(() => _membershipType = MembershipType.wantsToJoin),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: Ministry.all.length,
                itemBuilder: (context, index) {
                  final ministry = Ministry.all[index];
                  final selected = ministry.id == _selectedMinistryId;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedMinistryId = ministry.id),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: selected ? AppTheme.black : AppTheme.lightGrey,
                          width: selected ? 1.5 : 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(ministry.name),
                          if (selected) const Icon(Icons.check, size: 18),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: _selectedMinistryId == null
                    ? null
                    : () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => PendingApprovalScreen(
                              profile: widget.profile,
                              ministryId: _selectedMinistryId!,
                              membershipType: _membershipType,
                            ),
                          ),
                        );
                      },
                child: const Text('Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ToggleChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _ToggleChip({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? AppTheme.black : Colors.transparent,
          border: Border.all(color: AppTheme.black),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: selected ? AppTheme.white : AppTheme.black,
          ),
        ),
      ),
    );
  }
}
