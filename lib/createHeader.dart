import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class createHeader {
  runAppBar() => PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            elevation: 0.000001,
            backgroundColor: Colors.white,
            title: Text('Instagram', style: TextStyle(color: Colors.black, fontFamily: 'Billabong', fontSize: 32)),
            actions: [
              IconButton(
                splashColor: Colors.transparent,
                icon: Image.asset('lib/assets/direct.jpg', height: 22, width: 22),
                onPressed: () => {}
              ),
            ],
          ),
      );
}


class Story extends StatelessWidget {
  var img;
  var name;
  var isMe;
  
  Story(this.img, this.name, [this.isMe = false]);

  // Add button to add your story
  addStory() =>
    Container(
      height: 9, width: 9,
      child: Image.asset('lib/assets/add_blue_rounded.png', width: 20, height: 20,),
      alignment: Alignment.bottomRight,
  );

  @override
  Widget build(BuildContext context) {
    // Create gradient colors for decoration
    final gradientDecoration = BoxDecoration(
      gradient: LinearGradient(colors: [Colors.black, Colors.redAccent]),
      border: Border.all(width: 2, color: isMe ? Colors.white : Colors.redAccent),
      borderRadius: BorderRadius.circular(50)
    );

    return Column( 
          children: [
            Container(
              child: Container(
                child: isMe? addStory(): Text(''), // you can add new story if only that account belongs you
                width: 70.0,
                height: 70.0,
                // Create decorative borders for a story
                decoration: BoxDecoration(
                  color: const Color(0xff7c94b6),
                  image: DecorationImage( image: AssetImage(img), fit: BoxFit.cover),
                  border: Border.all( color: Colors.white, width: 3),
                  borderRadius: BorderRadius.all( Radius.circular(50.0)),
                  gradient: LinearGradient(colors: [Colors.black, Colors.redAccent]),
                ),
              ),
              decoration: gradientDecoration,
            ),
            SizedBox(height: 7),
            Text( name, style: TextStyle( color: Colors.grey[800], fontSize: 12)),
          ],
        );
  }
}
