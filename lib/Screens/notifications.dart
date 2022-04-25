import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../helpers/apiprefs.dart';

class TimeAgo{
  static String timeAgoSinceDate(String dateString, {bool numericDates = true}) {
    DateTime notificationDate = DateFormat("dd-MM-yyyy hh:mm").parse(dateString);
    final date2 = DateTime.now();
    final difference = date2.difference(notificationDate);

    print(difference.inDays);
    if (difference.inDays > 8) {
      return dateString;
    } else if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1 week ago' : 'Last week';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1 day ago' : 'Yesterday';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} hours ago';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 hour ago' : 'An hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 minute ago' : 'A minute ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} seconds ago';
    } else {
      return 'Just now';
    }
  }

} 


class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> 
{

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      appBar: AppBar
      (
       
        title: const Text("Notifications"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column
        (
          children: 
          [
            FutureBuilder
            (
              future: getUserNotifications(),
              builder: (context, AsyncSnapshot snapshot) 
              {
                if(snapshot.data == null)
                {
                  return const SizedBox(height: 325, child: Center(child: CircularProgressIndicator()));
                }
                else
                {
                  return SingleChildScrollView
                  (
                    child: Row
                    (
                      children: 
                      [
                        Expanded
                        (
                          child: SizedBox
                          (
                            height: 750,
                            width: 400,
                            child: ListView.builder
                            (
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, i)
                              {
                                return SingleChildScrollView
                                (
                                  child: Padding
                                  (
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                    child: SingleChildScrollView(
                                      child: Column
                                      (
                                        children: 
                                        [
                                          SizedBox(height: 20,),
                                          
                                          
                                          Row
                                          (
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Icon(Icons.bookmark_added, size: 30,),
                                              SizedBox
                                              (
                                                width: 200,
                                                child: Text("${snapshot.data[i].notificationMessage} ${snapshot.data[i].other}", style: TextStyle(fontSize: 18),)
                                              ),
                                              Text(TimeAgo.timeAgoSinceDate(snapshot.data[i].notificationDate)),
                                            ],
                                          ),
                                          const Padding
                                          (
                                            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                            child:  Divider(color: Colors.black54, thickness: 1)
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                );
                              }
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              }
            )
          ],
        ),
      )
      
    );
  }
}