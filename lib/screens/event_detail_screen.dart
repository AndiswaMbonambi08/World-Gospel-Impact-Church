import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/event_item.dart';
import '../theme/app_theme.dart';

class EventDetailScreen extends StatelessWidget {
  final EventItem event;
  final VoidCallback onAction;

  const EventDetailScreen({super.key, required this.event, required this.onAction});

  @override
  Widget build(BuildContext context) {
    final dateStr = DateFormat('EEEE, d MMMM · h:mm a').format(event.startTime);
    final buttonLabel = event.requiresTicket
        ? 'Buy ticket · R${event.ticketPrice.toStringAsFixed(0)}'
        : (event.isRsvped ? "RSVP'd" : 'RSVP');

    return Scaffold(
      appBar: AppBar(title: Text(event.title)),
      body: SafeArea(
        child: ListView(
          children: [
            // Poster placeholder. Swap for:
            //   Image.asset('assets\images\OIP.webp{event.posterAsset}')
            SizedBox(
              height: 180,
              width: double.infinity,
              child: Container(
                color: AppTheme.black,
                alignment: Alignment.center,
                child: event.posterAsset != null
                    ? Image.asset('assets/images/posters/${event.posterAsset}', fit: BoxFit.cover)
                    : const Icon(Icons.image, color: AppTheme.white, size: 36),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(event.title, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 6),
                  Text(dateStr, style: Theme.of(context).textTheme.bodySmall),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: onAction,
                    child: Text(buttonLabel),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
