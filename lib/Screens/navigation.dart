import 'package:custom_navigator/custom_navigation.dart';
import 'package:easyride_app/Screens/about.dart';
import 'package:easyride_app/Screens/notifications.dart';
import 'package:easyride_app/Screens/profile.dart';
import 'package:easyride_app/Screens/ridebook.dart';
import 'package:flutter/material.dart';
import 'package:easyride_app/ui/splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:custom_navigator/custom_navigator.dart';



// class cusNav extends StatelessWidget {
//   const cusNav({ Key? key }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return CupertinoTabScaffold(
//       tabBar: CupertinoTabBar(
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.map_rounded,
//               color: Colors.blue,
//             ),
//             label: "Book Ride",
//           ), BottomNavigationBarItem(
//             icon: new Icon(
//               Icons.person,
//               color: Colors.blue,
//             ),
//             label: "Profile",            
//           ),
//           BottomNavigationBarItem(
//             icon: new Icon(
//               Icons.notifications,
//               color: Colors.blue,
//             ),
//             label:"Notifications",
          
//           ),
//           BottomNavigationBarItem(
//             icon: new Icon(
//               Icons.list,
//               color: Colors.blue,
//             ),
//             label: "More",            
//           ),         
          
          
//         ],
//       ),
//       tabBuilder: (context, index){
//         switch(index){
//           case 0:
//             return CupertinoTabView(builder: (context){
//               return CupertinoPageScaffold(child: const Splash(),);
//             }
//             );
//             case 1:
//             return CupertinoTabView(builder: (context){
//               return CupertinoPageScaffold(child: const Splash(),);
//             }
              
//             );
//             case 2:
//             return CupertinoTabView(builder: (context){
//               return CupertinoPageScaffold(child: const Splash(),);
//             }
              
//             );
//             case 3:
//             return CupertinoTabView(builder: (context){
//               return CupertinoPageScaffold(child: const Splash(),);
//             }
              
//             );
//            }
//       },

//     );
//   }
// }

class cusNav extends StatefulWidget {
  const cusNav({ Key? key }) : super(key: key);

  @override
  State<cusNav> createState() => _cusNavState();
}

class _cusNavState extends State<cusNav> {
  
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: CustomScaffold(
        scaffold: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            showUnselectedLabels: true,
            showSelectedLabels: true,
            
            // selectedItemColor: Colors.red,
            unselectedLabelStyle: TextStyle(color: Colors.blue),
        
            
            items: [
              const BottomNavigationBarItem(
              icon: Icon(
                Icons.map_rounded,
                color: Colors.blue,
              ),
              label: "Book Ride",
            ),
            BottomNavigationBarItem(
              icon: new Icon(
                Icons.person,
                color: Colors.blue,
              ),
              label: "Profile",            
            ),
            BottomNavigationBarItem(
              icon: new Icon(
                Icons.notifications,
                color: Colors.blue,
              ),
              label:"Notifications",
            
            ),
            BottomNavigationBarItem(
              icon: new Icon(
                Icons.list,
                color: Colors.blue,
              ),
              label: "More",            
            ),
    
            ],
            
          ),
        ),
    
        // Children are the pages that will be shown by every click
        // They should placed in order such as
        // `page 0` will be presented when `item 0` in the [BottomNavigationBar] clicked.
        children: <Widget>[
          const Splash(),
      Profile(),
      NotificationPage(),
      About(),
        ],
    
        // Called when one of the [items] is tapped.
        onItemTap: (index) {},
    
      ),
    );
  }
}



// class EasBottomNavigationBar extends StatefulWidget {
//   const EasBottomNavigationBar({Key? key}) : super(key: key);

//   @override
//   _NavigationBarState createState() => _NavigationBarState();
// }

// class _NavigationBarState extends State<EasBottomNavigationBar> {
//   int _currentIndex = 0;
//   final List<Widget> _children = [
//     const Splash(),
//     Profile(),
//     NotificationPage(),
//     About(),
//   ];

//   void onTappedBar(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _children[_currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         onTap: onTappedBar,
//         currentIndex: _currentIndex,
//         items: [
//           const BottomNavigationBarItem(
//             icon: Icon(
//               Icons.map_rounded,
//               color: Colors.blue,
//             ),
//             label: "Book Ride",
//           ),
//           BottomNavigationBarItem(
//             icon: new Icon(
//               Icons.person,
//               color: Colors.blue,
//             ),
//             label: "Profile",            
//           ),
//           BottomNavigationBarItem(
//             icon: new Icon(
//               Icons.notifications,
//               color: Colors.blue,
//             ),
//             label:"Notifications",
          
//           ),
//           BottomNavigationBarItem(
//             icon: new Icon(
//               Icons.list,
//               color: Colors.blue,
//             ),
//             label: "More",            
//           ),
//         ],
//       ),
//     );
//   }
// }
