import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:eventos_deportivos/common/utils/styleguide.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';

import 'package:eventos_deportivos/models/Event.dart';

class EventWidget extends StatelessWidget {
  final Event event;

  const EventWidget({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 20),
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(24))),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
              child: event.eventImageUrl != null
                  ? Stack(children: [
                const Center(child: CircularProgressIndicator()),
                CachedNetworkImage(
                  cacheKey: event.eventImageKey,
                  imageUrl: event.eventImageUrl!,
                  width: double.maxFinite,
                  height: 100,
                  alignment: Alignment.topCenter,
                  fit: BoxFit.fitWidth,
                ),
              ])
                  :Image.asset(
                //event.imagePath,
                "assets/event_images/5_km_downtown_run.jpeg",
                height: 100,
                fit: BoxFit.fitWidth,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          event.title,
                          style: eventTitleTextStyle,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        FittedBox(
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.location_on),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                event.city +", " + event.departamento,
                                style: eventLocationTextStyle,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      //DateFormat('E, d MMM yyyy hh:mm a','es').format(event.date),
                      DateFormat('E, d MMM yyyy hh:mm a').format(event.date.getDateTimeInUtc()),
                      textAlign: TextAlign.right,
                      style: eventLocationTextStyle.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
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
