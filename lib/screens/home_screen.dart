import 'package:flutter/material.dart';
import '../models/event_item.dart';
import '../models/ministry.dart';
import '../models/ministry_membership.dart';
import '../models/user_profile.dart';
import '../theme/app_theme.dart';
import '../widgets/event_card.dart';
import '../widgets/logo_header.dart';
import 'event_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  final UserProfile profile;
  final List<MinistryMembership> memberships;

  const HomeScreen({super.key, required this.profile, required this.memberships});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<EventItem> _events;
  late List<MinistryMembership> _memberships;
  String _activeFilter = 'general';
  int _navIndex = 0;

  @override
  void initState() {
    super.initState();
    _events = EventItem.sample();
    _memberships = widget.memberships;
  }

  List<EventItem> get _visibleEvents {
    return _events.where((e) => e.ministryId == _activeFilter).toList();
  }

  void _handleEventAction(EventItem event) {
    if (event.requiresTicket) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Buy ticket'),
          content: Text('Proceed to pay R${event.ticketPrice.toStringAsFixed(0)} for "${event.title}"?'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Pay')),
          ],
        ),
      );
    } else {
      setState(() => event.isRsvped = !event.isRsvped);
    }
  }

  void _addMinistry(String ministryId) {
    setState(() {
      _memberships.add(MinistryMembership(ministryId: ministryId, status: MembershipStatus.pending));
    });
    Navigator.pop(context);
  }

  void _simulateApproval(MinistryMembership membership) {
    setState(() => membership.status = MembershipStatus.approved);
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      _buildHomeTab(),
      _buildMinistriesTab(),
      _buildProfileTab(),
    ];

    return Scaffold(
      body: SafeArea(child: pages[_navIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _navIndex,
        onTap: (i) => setState(() => _navIndex = i),
        selectedItemColor: AppTheme.black,
        unselectedItemColor: AppTheme.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.groups), label: 'Ministries'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildHomeTab() {
    // Only "General" (church-wide, everyone sees these) plus ministries
    // this user has actually joined or requested. Approved ones can be
    // tapped to filter; pending ones are shown but disabled.
    final chips = <Widget>[
      _FilterChip(
        label: 'General',
        selected: _activeFilter == 'general',
        onTap: () => setState(() => _activeFilter = 'general'),
      ),
    ];
    for (final m in _memberships) {
      final name = Ministry.all.firstWhere((min) => min.id == m.ministryId).name;
      final isPending = m.status == MembershipStatus.pending;
      chips.add(
        _FilterChip(
          label: isPending ? '$name (pending)' : name,
          selected: _activeFilter == m.ministryId,
          disabled: isPending,
          onTap: isPending
              ? () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Still waiting on admin approval for this ministry')),
                  )
              : () => setState(() => _activeFilter = m.ministryId),
        ),
      );
    }

    return Column(
      children: [
        const LogoHeader(height: 80),
        SizedBox(
          height: 44,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            itemCount: chips.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, i) => chips[i],
          ),
        ),
        const Divider(height: 1, color: AppTheme.lightGrey),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 4),
            children: [
              const Text('Upcoming events', style: TextStyle(fontWeight: FontWeight.w500)),
              const SizedBox(height: 8),
              ..._visibleEvents.map(
                (e) => EventCard(
                  event: e,
                  onAction: () => _handleEventAction(e),
                  onOpenDetail: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => EventDetailScreen(
                          event: e,
                          onAction: () {
                            Navigator.of(context).pop();
                            _handleEventAction(e);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 4, 14, 14),
          child: GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: AppTheme.black, borderRadius: BorderRadius.circular(12)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Give tithe or offering', style: TextStyle(color: AppTheme.white, fontWeight: FontWeight.w500)),
                  Icon(Icons.arrow_forward, color: AppTheme.white, size: 18),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMinistriesTab() {
    final joinedIds = _memberships.map((m) => m.ministryId).toSet();
    final available = Ministry.all.where((m) => !joinedIds.contains(m.id)).toList();

    return Column(
      children: [
        const LogoHeader(height: 80),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text('Your ministries', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
              const SizedBox(height: 12),
              ..._memberships.map((m) {
                final ministry = Ministry.all.firstWhere((min) => min.id == m.ministryId);
                final approved = m.status == MembershipStatus.approved;
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppTheme.lightGrey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(ministry.name),
                      GestureDetector(
                        onTap: approved ? null : () => _simulateApproval(m),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: approved ? AppTheme.black : Colors.transparent,
                            border: Border.all(color: AppTheme.black),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            approved ? 'Approved' : 'Pending · tap to simulate',
                            style: TextStyle(
                              fontSize: 11,
                              color: approved ? AppTheme.white : AppTheme.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 20),
              const Text('Join another ministry', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
              const SizedBox(height: 12),
              ...available.map(
                (m) => GestureDetector(
                  onTap: () => _addMinistry(m.id),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppTheme.lightGrey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(m.name),
                        const Icon(Icons.add, size: 18),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfileTab() {
    final p = widget.profile;
    final rows = <MapEntry<String, String>>[
      MapEntry('Name', '${p.firstName} ${p.surname}'),
      MapEntry('Phone', p.phone),
      MapEntry('Email', p.email),
      MapEntry('Age', p.age.toString()),
      MapEntry('Location', p.location),
    ];

    return Column(
      children: [
        const LogoHeader(height: 80),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text('Your profile', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
              const SizedBox(height: 12),
              ...rows.map(
                (r) => Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppTheme.lightGrey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(r.key, style: const TextStyle(color: AppTheme.grey, fontSize: 13)),
                      Text(r.value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final bool disabled;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? AppTheme.black : Colors.transparent,
          border: Border.all(color: disabled ? AppTheme.lightGrey : AppTheme.black),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: selected ? AppTheme.white : (disabled ? AppTheme.grey : AppTheme.black),
          ),
        ),
      ),
    );
  }
}
