// import 'package:flutter/material.dart';

// class DraggableBottomSheet extends StatefulWidget {
//   const DraggableBottomSheet({super.key});

//   @override
//   DraggableBottomSheetState createState() => DraggableBottomSheetState();
// }

// class DraggableBottomSheetState extends State<DraggableBottomSheet> {
//   ScrollController scrollController = ScrollController();
//   double containerSize =
//       67; //my px value of the panel that need to be shown when closed
//   late double margin;
//   double unlockScroll = 0;
//   late double previousOffset;
//   bool lock = false;

//   @override
//   void initState() {
//     super.initState();
//     margin = containerSize;
//     WidgetsBinding.instance.addPostFrameCallback((_) => scrollController.jumpTo(
//         scrollController
//             .position.maxScrollExtent)); //put the panel in closed position
//   }

//   Future<void> waitAndUpdate() async {
//     //Wait for the ScrollPhysics to stop before updating the scrollarea
//     //(I maybe need to change the scrollphysics's speed if some users play around quickly)
//     if (lock) return;
//     lock = true;
//     Future.doWhile(() async {
//       if (previousOffset == scrollController.offset) {
//         updateScrollArea(1000);
//         lock = false;
//         return false;
//       }
//       previousOffset = scrollController.offset;
//       await Future<dynamic>.delayed(const Duration(milliseconds: 40));
//       return true;
//     });
//   }

//   void updateScrollArea(double dimension) {
//     if (dimension != 1000) {
//       //print("child's dimension augmented");
//       setState(() {
//         containerSize = dimension - 1;
//         unlockScroll = 1;
//       });
//     } else {
//       //Lower the view port
//       setState(() => containerSize = margin);
//       //callback after the frame built
//       WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
//             containerSize = scrollController.position.maxScrollExtent -
//                 scrollController.offset +
//                 margin;

//             //If it reached max (can't be scrolled since its useless), add 1px and update
//             if (containerSize ==
//                 scrollController.position.maxScrollExtent + margin) {
//               unlockScroll = 1;
//               containerSize =
//                   scrollController.position.maxScrollExtent + margin - 1;
//             }
//             print('container size = $containerSize');
//           }));
//     }
//   }

//   // void notified() {
//   //   //Called by the "pause" button
//   //   //print("viewport $scrollController.position.viewportDimension");
//   //   //print("capacuty to scroll $scrollController.position.maxScrollExtent");
//   //   updateScrollArea((scrollController.position.maxScrollExtent > 0)
//   //       ? scrollController.position.maxScrollExtent +
//   //           scrollController.position.viewportDimension
//   //       : null);
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//         builder: (BuildContext context, BoxConstraints constraints) {
//       return Listener(
//         onPointerUp: (_) => waitAndUpdate(),
//         onPointerDown: (_) => setState(() => containerSize = margin),
//         child: SizedBox(
//           height: containerSize,
//           child: SingleChildScrollView(
//             // physics: NoVelocityScrollPhysics(),
//             controller: scrollController,
//             clipBehavior: Clip.none,
//             reverse: true,
//             child: Column(
//               children: <Widget>[
//                 Container(height: unlockScroll),
//                 Container(
//                   //My drawer
//                   decoration: const BoxDecoration(
//                       color: Colors.blue,
//                       borderRadius:
//                           BorderRadius.vertical(top: Radius.circular(30))),
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
//                   // child: Panel(notifySize: notified),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     });
//   }
// }

// // it's a stateful widget!
// class _MyDraggableSheetState extends State<MyDraggableSheet> {
//   final _sheet = GlobalKey();
//   final _controller = DraggableScrollableController();

//   @override
//   Widget build(BuildContext context) {
//     return DraggableScrollableSheet(
//       key: _sheet,
//       initialChildSize: 0.5,
//       maxChildSize: 1,
//       minChildSize: 0,
//       expand: true,
//       snap: true,
//       snapSizes: const [0.5],
//       controller: _controller,
//       builder: (BuildContext context, ScrollController scrollController) {
//         return DecoratedBox(
//           decoration: const BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(12),
//               topRight: Radius.circular(12),
//             ),
//           ),
//           child: CustomScrollView(
//             controller: scrollController,
//             slivers: [
//               const SliverToBoxAdapter(
//                 child: Text('Title'),
//               ),
//               SliverList.list(
//                 children: const [
//                   Text('Content'),
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }