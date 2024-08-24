// import 'package:flutter/material.dart';
// import 'package:share/share.dart';
//
// import 'dynamic_links_service.dart';
//
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   final DynamicLinksService _dynamicLinksService = DynamicLinksService();
//   String _linkMessage = '';
//
//   @override
//   void initState() {
//     super.initState();
//     _dynamicLinksService.initDynamicLinks();
//   }
//
//   Future<void> _createLink() async {
//     final link =
//         await _dynamicLinksService.createDynamicLink('https://www.example.com');
//     setState(() {
//       _linkMessage = link;
//     });
//   }
//
//   void _shareLink() {
//     Share.share(_linkMessage);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flutter Dynamic Links'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'Dynamic Link:',
//             ),
//             SelectableText(
//               _linkMessage,
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _createLink,
//               child: Text('Create Link'),
//             ),
//             ElevatedButton(
//               onPressed: _shareLink,
//               child: Text('Share Link'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
