import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification{

  FlutterLocalNotificationsPlugin localNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  initializationSettings() async{
      var initializeAndroid = AndroidInitializationSettings('ic_launcher');
      var initializeIOS = IOSInitializationSettings();
      var initSettings = InitializationSettings(initializeAndroid, initializeIOS);
      await localNotificationsPlugin.initialize(initSettings);
  }
  Future singleNotificationSchedule(DateTime dateTime, String title, String body, int hashcode, {String sound })async{
    var androidChannel = AndroidNotificationDetails(
      'chanel-id', 'channel-name', 'channel-description',
      importance: Importance.Max,
      priority: Priority.Max
    );
    var iosChannel = IOSNotificationDetails();
    var platformChannel = NotificationDetails(androidChannel, iosChannel);
    await localNotificationsPlugin.schedule(hashcode, title, body, dateTime, platformChannel,payload: hashcode.toString());
  }
  sendSingleNotificationSchedule(DateTime dateTime, String title, String body, int hashcode)async{
    await sendSingleNotificationSchedule(dateTime, title, body, hashcode);
  }
  cancelAllNotifications()async{
    await localNotificationsPlugin.cancelAll();
  }

}