import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/event_item.dart';
import '../theme/app_theme.dart';

class EventCard extends StatelessWidget {
  final EventItem event;
  final VoidCallback onAction;
  final VoidCallback? onOpenDetail;

  const EventCard({
    super.key,
    required this.event,
    required this.onAction,
    this.onOpenDetail,
  });

  @override
  Widget build(BuildContext context) {
    final dateStr = DateFormat('EEE, d MMM · h:mm a').format(event.startTime);
    final buttonLabel = event.requiresTicket
        ? 'Buy ticket'
        : (event.isRsvped ? "RSVP'd" : 'RSVP');

    return GestureDetector(
      onTap: onOpenDetail,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: AppTheme.lightGrey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(event.title, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 2),
                  Text(
                    event.requiresTicket
                        ? '$dateStr · R${event.ticketPrice.toStringAsFixed(0)}'
                        : dateStr,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: onAction,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: event.requiresTicket ? AppTheme.black : Colors.transparent,
                  border: Border.all(color: AppTheme.black),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  buttonLabel,
                  style: TextStyle(
                    fontSize: 12,
                    color: event.requiresTicket ? AppTheme.white : AppTheme.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
