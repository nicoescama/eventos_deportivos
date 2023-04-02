import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:eventos_deportivos/models/event.dart';
import '../../common/utils/styleguide.dart';

class EventDetailsContent extends StatelessWidget {
  final Event event;
  const EventDetailsContent({super.key, required this.event});

  @override
  initState(BuildContext context) {
  }

  @override
  Widget build(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 60,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.2),
            child: Text(
              event.title,
              style: eventWhiteTitleTextStyle,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.24),
            child: FittedBox(
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.calendar_today,
                    color: Colors.white,
                    size: 15,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                      DateFormat('E, d MMM yyyy hh:mm a').format(event.date.getDateTimeInUtc()),
                      //DateFormat('E, d MMM yyyy hh:mm a','es').format(event.date),
                    style: eventLocationTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.24),
            child: FittedBox(
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.location_on,
                    color: Colors.white,
                    size: 15,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    event.city + ", " + event.departamento,
                    style: eventLocationTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 80,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              "INFORMACIÓN",
              style: guestTextStyle,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                //for (final galleryImagePath in event.galleryImages)
                for (final galleryImagePath in ["assets/event_images/5_km_downtown_run.jpeg"])
                  Container(
                    margin: const EdgeInsets.only(left: 16, right: 16, bottom: 32),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child:  GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return  Scaffold(
                              body: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Center(
                                  child: Hero(
                                    tag: 'imageHero',
                                    child: Image.asset(
                                      galleryImagePath
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }));
                        },
                        child:Hero(
                        tag: 'imageHero',
                        child: Image.asset(
                          galleryImagePath,
                          width: 180,
                          height: 180,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    ),
                  ),
              ],
            ),
          ),
         /* SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                for (final guest in guests)
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: ClipOval(
                      child: Image.asset(
                        guest.imagePath,
                        width: 90,
                        height: 90,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
              ],
            ),
          ),*/
          //if (event.description.isNotEmpty) Padding(
            Padding(
            padding: const EdgeInsets.all(16),
            child: Text(event.description!, style: punchLine1TextStyle,),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: event.punchline1, style: eventLocationTextStyle,),
                  TextSpan(text: event.punchline2, style: eventLocationTextStyle,),
                ]
              ),
            ),
          ),
          //if (event.galleryImages.isNotEmpty) Padding(
            Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 16, bottom: 16),
            child: Text(
              "GALERÍA",
              style: guestTextStyle,
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                //for (final galleryImagePath in event.galleryImages)
                for (final galleryImagePath in ["assets/event_images/5_km_downtown_run.jpeg","assets/event_images/5_km_downtown_run.jpeg"])
                  Container(
                    margin: const EdgeInsets.only(left: 16, right: 16, bottom: 32),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: Image.asset(
                        galleryImagePath,
                        width: 180,
                        height: 180,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
