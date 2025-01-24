// import 'package:flutter/material.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';

// class QRScannerScreen extends StatefulWidget {
//   const QRScannerScreen({super.key});

//   @override
//   State<QRScannerScreen> createState() => _QRScannerScreenState();
// }

// class _QRScannerScreenState extends State<QRScannerScreen> {
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   QRViewController? controller;
//   String scannedData = "";

//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Scan QR Code")),
//       body: Column(
//         children: [
//           Expanded(
//             flex: 4,
//             child: QRView(
//               key: qrKey,
//               onQRViewCreated: (QRViewController controller) {
//                 setState(() => this.controller = controller);
//                 controller.scannedDataStream.listen((scanData) {
//                   setState(() {
//                     scannedData = scanData.code ?? "";
//                   });

//                   // Close scanner and return data
//                   controller.pauseCamera();
//                   if (mounted) {
//                     Navigator.pop(context, scannedData);
//                   }
//                 });
//               },
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: Center(
//               child: scannedData.isNotEmpty
//                   ? Text("Scanned: $scannedData",
//                       style: const TextStyle(fontSize: 18))
//                   : const Text("Scan a QR Code",
//                       style: TextStyle(fontSize: 18)),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
