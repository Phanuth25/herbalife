import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

Future<void> launchYouTube(String videoId) async {
  final Uri appUri = Uri.parse('vnd.youtube:$videoId');
  final Uri webUri = Uri.parse('https://www.youtube.com/watch?v=$videoId');

  try {
    if (Platform.isAndroid) {
      if (await canLaunchUrl(appUri)) {
        await launchUrl(appUri);
      } else {
        await launchUrl(webUri, mode: LaunchMode.externalApplication);
      }
    } else {
      // iOS or others
      if (await canLaunchUrl(webUri)) {
        await launchUrl(webUri, mode: LaunchMode.externalApplication);
      }
    }
  } catch (e) {
    // If both fail, try one last time with simple web link
    if (await canLaunchUrl(webUri)) {
      await launchUrl(webUri, mode: LaunchMode.externalApplication);
    } else {
      print('Could not launch YouTube: $e');
    }
  }
}
