import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:eventos_deportivos/models/Event.dart';
import 'package:eventos_deportivos/ui/event_details/event_details_background.dart';
import 'event_details_content.dart';

class EventDetailsPage extends StatelessWidget {

  const EventDetailsPage({Key? key, required this.event}) : super(key: key);
  final Event event;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Provider<Event>.value(
        value: event,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            EventDetailsBackground(),
            EventDetailsContent(event: event),
          ],
        ),
      ),
    );
  }
}
