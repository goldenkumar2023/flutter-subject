// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
//
// class DynamicLinkService {
//   Future<String> createDynamicLink(String link) async {
//     final DynamicLinkParameters parameters = DynamicLinkParameters(
//       uriPrefix: 'https://yourapp.page.link',
//       link: Uri.parse(link),
//       androidParameters: AndroidParameters(
//         packageName: 'com.example.yourapp',
//         minimumVersion: 0,
//       ),
//       iosParameters: IosParameters(
//         bundleId: 'com.example.yourapp',
//         minimumVersion: '0',
//       ),
//     );
//     final ShortDynamicLink shortDynamicLink = await parameters.buildShortLink();
//     return shortDynamicLink.shortUrl.toString();
//   }
//
//   void initDynamicLink() async {
//     FirebaseDynamicLinks.instance.onLink(
//       onSuccess: (PendingDynamicLinkData? dynamicLinkData) async {
//         final Uri? deepLink = dynamicLinkData?.link;
//         if (deepLink != null) {
//           // Handle deeplink
//         }
//       },
//       onError: (OnLinkErrorException e) async {
//         print('onLinkError');
//         print(e.message);
//       },
//     );
//
//     final PendingDynamicLinkData? data =
//         await FirebaseDynamicLinks.instance.getInitialLink();
//     final Uri? deepLink = data?.link;
//     if (deepLink != null) {
//       // Handle deeplink
//     }
//   }
// }
