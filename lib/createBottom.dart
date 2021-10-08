import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Class, responsible for creating states of bottom bar
class Bottom extends StatefulWidget {
  @override
  _createBottom createState() => _createBottom();
}

// Class which represents the states of bottom bar
class _createBottom extends State<Bottom>{
  int i = 0;

  @override 
  Widget build(BuildContext context) => BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.black,
      items: [
        BottomNavigationBarItem(
          title: Text(''),
          icon: IconButton(
            splashColor: Colors.transparent,
            icon: Image.asset(i==1? 'lib/assets/home1.png': 'lib/assets/home0.png', height: 22, width: 22),
            onPressed: () { setState(() { i=1; }); },
          ),
        ),
        
        BottomNavigationBarItem(
          title: Text(''),
          icon: IconButton(
            splashColor: Colors.transparent,
            icon: Image.asset( i==2? 'lib/assets/search0.png': 'lib/assets/search1.png', height: 22, width: 22),
            onPressed: () { setState(() { i=2; }); },
          ),
        ),
        
        BottomNavigationBarItem(
          title: Text(''),
          icon: IconButton(
            splashColor: Colors.transparent,
            icon: Image.asset('lib/assets/more.png', height: 22, width: 22),
            onPressed: () { setState(() {  }); },
          ),
        ),

        BottomNavigationBarItem(
          title: Text(''),
          icon: IconButton(
            splashColor: Colors.transparent,
            icon: Image.asset(i==3? 'lib/assets/heart1.png': 'lib/assets/heart0.png', height: 22, width: 22),
            onPressed: () { setState(() { i=3; }); },
          ),
        ),

        BottomNavigationBarItem(
          title: Text(''),
          icon: IconButton(
            splashColor: Colors.transparent,
            icon: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset('lib/assets/guitarist.jpg', height: 24, width: 24, fit: BoxFit.cover),
            ),
            onPressed: () { setState(() {  }); },
          ),
        )
      ],
  );
}