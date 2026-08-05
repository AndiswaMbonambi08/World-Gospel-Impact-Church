enum MembershipStatus { pending, approved }

class MinistryMembership {
  final String ministryId;
  MembershipStatus status;

  MinistryMembership({required this.ministryId, required this.status});
}
