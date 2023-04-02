import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:eventos_deportivos/models/event.dart';
import 'event_details_background.dart';
import 'event_details_content.dart';

class EventDetailsPage extends StatefulWidget {

  final Event event;

  const EventDetailsPage({Key? key, required this.event}) : super(key: key);

  @override
  _EventDetailsPage createState() => _EventDetailsPage();
}

class _EventDetailsPage extends  State<EventDetailsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Provider<Event>.value(
        value: widget.event,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            EventDetailsBackground(),
            EventDetailsContent(event: widget.event),
          ],
        ),
      ),
    );
  }
}