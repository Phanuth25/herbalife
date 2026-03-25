// import 'package:flutter/material.dart';
// import 'package:project2/widget/btm_nav_widget.dart';
// void main() {
//
//   runApp(MaterialApp(home: Myhomepage(),));
// }
//
// class Myhomepage extends StatefulWidget {
//
//   const Myhomepage({super.key});
//
//   @override
//   State<Myhomepage> createState() => _MyhomepageState();
// }
//
// class _MyhomepageState extends State<Myhomepage> {
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(drawer: Drawer(backgroundColor: Colors.amber,
//       child:Builder(builder: (context) {
//         return ListView(
//
//           children: [
//             ListTile(
//               leading: Icon(Icons.home, color: Colors.white,),
//               title: Text('Menu', textAlign: TextAlign.center,
//                 style: TextStyle(color: Colors.white,
//                     fontSize: 25,
//                     fontWeight: FontWeight.bold),),
//               subtitle: Text('of our app', textAlign: TextAlign.center,
//                 style: TextStyle(color: Colors.white, fontSize: 20),),
//               trailing: Icon(Icons.arrow_forward_ios, color: Colors.white,),
//               onTap: () {
//                 Navigator.pop(context);
//               },
//             ),
//           ],
//         );
//
//       },
//       ),
//
//     ),
//
//       appBar: AppBar(
//
//         title: Text("My App4",style: TextStyle(color: Colors.white),),
//         centerTitle: true,
//         actions: [Icon(Icons.search,color: Colors.black),Icon(Icons.more_vert,color: Colors.black,)],
//
//       ),
//
//       floatingActionButton: Column(
//         mainAxisSize: MainAxisSize.min
//         ,children: [
//         FloatingActionButton(onPressed: (){
//           print('Floating Action Button Plus ');
//         },
//           child: Icon(Icons.add),),
//         SizedBox(height: 10,),
//         FloatingActionButton(onPressed: (){
//           print('Floating Action Button Minus');
//         },
//           child: Icon(Icons.remove),)
//       ],
//       ),
//       bottomNavigationBar: ButtomNav(),
//     );
//   }
// }
//
//
//

import 'package:flutter/material.dart';
import 'package:project2/public/view/widget_tree.dart';

void main(){
  runApp(const Main());
}
class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(debugShowCheckedModeBanner: false,theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.black,brightness: Brightness.dark)),home: WidgetTree(),);
  }
}
