import 'package:awesome_notifications/awesome_notifications.dart';




Future<void> bookingConfirmedNotification() async 
{
  await AwesomeNotifications().createNotification
  (
    content: NotificationContent
    (
      id: createUniqueId(), 
      channelKey: 'basic_channel',
      title: '${Emojis.paper_bookmark} Your booking for ride has been acceptedl!!!',
      body: 'The ride has been sucesfully booked by you',
    )
  );
}

Future<void> rideConfirmedNotification() async 
{
  await AwesomeNotifications().createNotification
  (
    content: NotificationContent
    (
      id: createUniqueId(), 
      channelKey: 'basic_channel',
      title: '${Emojis.paper_bookmark} Request a ride.',
      body: 'You have request a ride , you can view the detail in waiting page.',
    )
  );
}

Future<void> tciketNotification() async 
{
  await AwesomeNotifications().createNotification
  (
    content: NotificationContent
    (
      id: createUniqueId(), 
      channelKey: 'basic_channel',
      title: '${Emojis.paper_bookmark} Sucesfully requested a ticket supprot!!!',
      body: 'Your ticket has been created, the support team will assist you by mail soon..',
    )
  );
}

Future<void> profileNotification() async 
{
  await AwesomeNotifications().createNotification
  (
    content: NotificationContent
    (
      id: createUniqueId(), 
      channelKey: 'basic_channel',
      title: '${Emojis.paper_bookmark} Update profile!',
      body: 'Your have uptaed your profile details..',
    )
  );
}

int createUniqueId()
{
  return DateTime.now().millisecondsSinceEpoch.remainder(100000);
}