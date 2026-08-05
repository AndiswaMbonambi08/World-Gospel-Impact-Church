class EventItem {
  final String id;
  final String title;
  final DateTime startTime;
  final String ministryId; // 'general' = visible to everyone, regardless of ministry
  final bool requiresTicket;
  final double ticketPrice;
  final String? posterAsset;
  bool isRsvped;

  EventItem({
    required this.id,
    required this.title,
    required this.startTime,
    required this.ministryId,
    this.requiresTicket = false,
    this.ticketPrice = 0,
    this.posterAsset,
    this.isRsvped = false,
  });

  static List<EventItem> sample() {
    final now = DateTime.now();
    return [
      EventItem(
        id: 'e1',
        title: 'Youth night',
        startTime: now.add(const Duration(days: 2, hours: 18)),
        ministryId: 'youth',
      ),
      EventItem(
        id: 'e2',
        title: 'Band rehearsal',
        startTime: now.add(const Duration(days: 3, hours: 10)),
        ministryId: 'band',
      ),
      EventItem(
        id: 'e3',
        title: 'Impact conference',
        startTime: now.add(const Duration(days: 5, hours: 9)),
        ministryId: 'general',
        requiresTicket: true,
        ticketPrice: 150,
      ),
      EventItem(
        id: 'e4',
        title: 'Sunday service',
        startTime: now.add(const Duration(days: 4, hours: 9)),
        ministryId: 'general',
      ),
    ];
  }
}
