import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:insta_copy/createHeader.dart';
import 'package:url_launcher/url_launcher.dart';

// Class, responsible for creating states of body
class Body extends StatefulWidget {
  @override
  createBody createState() => createBody();
}

// Class which represents the states of body
class createBody extends State<Body> {
  // Creates story bar
  storyBar() => SingleChildScrollView (
      child: Container(
            height: 100,
            child: ListView(
              itemExtent: 90, 
              shrinkWrap: true,   
              scrollDirection: Axis.horizontal,
              children: [ 
                    Story('lib/assets/guitarist.jpg', 'myacc', true), 
                    Story('lib/assets/rocks.jpg', 'rocky_guy'), 
                    Story('lib/assets/no-avatar.png', '_noname_'), 
                    Story('lib/assets/moon.jpg', 'author_art'),
                    Story('lib/assets/moon.jpg', 'author_art'),
                    Story('lib/assets/moon.jpg', 'author_art'),
                    Story('lib/assets/moon.jpg', 'author_art'),
                    Story('lib/assets/moon.jpg', 'author_art'),
                    Story('lib/assets/moon.jpg', 'author_art'),
                  ],
              ),
          ),
    );

  @override
  Widget build(BuildContext context) => Center(
      child: SingleChildScrollView(
        child: Column( 
            children: [
              storyBar(),
              Divider(color: Colors.grey),
              Publication(
                "myacc",
                'lib/assets/guitarist.jpg',
                {'lib/assets/coffee1.jpg'}, 
                '22/09/2021', likes: 0, comments: ['Фу! Чай лучше'],
              ),
              Publication(
                "myacc",
                'lib/assets/guitarist.jpg',                
                {'lib/assets/coffee2.jpg', 'lib/assets/coffee3.jpg'}, //height: 350, width: 440), 
                '22/09/2021', likes: 1, comments: ['Wow', 'Nice', 'I saw better((('],
              ),
              Publication(
                "author_art",
                'lib/assets/moon.jpg',
                {'lib/assets/coffee3.jpg'},
                '22/09/2021', likes: 12,
              ),
            ],
        ),
      )
    );
}



// Class, responsible for creating states of publication buttons
class Publication extends StatefulWidget {
  var content;
  var likes;
  var date;
  var comments;
  var img;
  var acc_name;

  Publication(this.acc_name, this.img, this.content, this.date, {this.likes, this.comments = ''});

  @override
  createPublication createState() => createPublication();
}

// Class which represents the states of publication buttons
class createPublication extends State<Publication> {
  var icon_size = 25.0;
  var indexes = [false, false];

  @override
  Widget build(BuildContext context) => Column(
    children: [
      upperBar(widget.img), 
      addContent(),
      SizedBox(height: 9), 
      lowerBar()
    ]
  );
  
  // Adding a set of photos, videos, etc. to  publication
  addContent() => SingleChildScrollView (
      child:Container(
        height: 350,
        child: ListView(
          physics: ClampingScrollPhysics(),
          itemExtent: 360, 
          shrinkWrap: true,   
          scrollDirection: Axis.horizontal,
          children: [ 
            for (String e in widget.content)
              Image.asset(e, fit: BoxFit.cover, height: 350, width: 440), 
          ],
        ),
      ),
    );

  // Function that converts month in string date to a number
  convertDate() {
    var newDate = widget.date.split('/');
      
    getMonth() {
      switch(newDate[1]) {
        case '01': return 'января';
        case '02': return 'февраля';
        case '03': return 'марта';
        case '04': return 'апреля';
        case '05': return 'мая';
        case '06': return 'июня';
        case '07': return 'июля';
        case '08': return 'августа';
        case '09': return 'сентября';
        case '10': return 'октября';
        case '11': return 'ноября';
        case '12': return 'декабря'; 
      }
    }    
    return newDate[0] + ' ' + getMonth() + ' ' + newDate[2] + ' г.';      
  }

  // Function to create upper bar of publication  
  upperBar(var img) => AppBar(
      shadowColor: Colors.transparent,
      toolbarHeight: 56,
      backgroundColor: Colors.white,
      title: Row(
        children: [
          Container(
            width: 35.0,
            height: 35.0,
            decoration: BoxDecoration(
              color: const Color(0xff7c94b6),
              image: DecorationImage(image: AssetImage(img), fit: BoxFit.cover),
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
              border: Border.all(color: Colors.redAccent, width: 1.5),
            ),
          ),
          SizedBox(width: 7),
          Text(widget.acc_name, style: TextStyle(color: Colors.grey[800], fontSize: 12)),
        ],
      ),

      actions: [
        IconButton(
          //splashColor: Colors.transparent, 
          icon: Icon(Icons.more_vert, color: Colors.black), 
          onPressed: () => {}
        ),
      ],
  );

  // Function to create lower bar of publication  
  lowerBar() => Container(
      height: 110,
      width: 350,
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    splashColor: Colors.transparent,
                    icon: Image.asset(indexes[0]? 'lib/assets/heart2.png': 'lib/assets/heart0.png', height: icon_size, width: icon_size),
                    onPressed: () { setState(() { 
                      indexes[0] = !indexes[0]; 
                      indexes[0]? widget.likes++: widget.likes--;
                      });
                    },
                  ),
                  
                  IconButton(
                    splashColor: Colors.transparent,
                    icon: Image.asset('lib/assets/chat.png', height: icon_size, width: icon_size),
                    onPressed: () { setState(() {  }); },
                  ),
                  
                  IconButton(
                    splashColor: Colors.transparent,
                    icon: Image.asset('lib/assets/paper-plane.png', height: icon_size, width: icon_size),
                    onPressed: () { setState(() {  }); },
                  ),
                ],
              ),

              SizedBox(width: 100),

              Row(
                children: [
                  IconButton(
                    splashColor: Colors.transparent,
                    icon: Image.asset(indexes[1]? 'lib/assets/bookmark0.png': 'lib/assets/bookmark1.png', height: icon_size, width: icon_size),
                    onPressed: () { setState(() { indexes[1] = !indexes[1]; }); },
                  ),
                ],
              ),
            ],
          ),
                
          Align(
            child: Column(  
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Representing the number of likes
                SizedBox(height: 1),
                Text('    Нравится: ${widget.likes}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                SizedBox(height: 2),
                  
                // Conditions for comments' formatting. Depends on their amount
                if (widget.comments.length > 0)
                  Text('    ${widget.comments[0]}', style: TextStyle(fontSize: 12)),
                SizedBox(height: 2),

                if (widget.comments.length == 2)  
                  Text('    Посмотреть комментарий', 
                    style: TextStyle(color: Colors.grey[500], fontWeight: FontWeight.bold, fontSize: 12)
                  ), 
                if (widget.comments.length > 2)
                  Text('    Посмотреть все комментарии (${widget.comments.length-1})', 
                    style: TextStyle(color: Colors.grey[500], fontSize: 12)
                  ), 
                SizedBox(height: 2),
                Text('    ${convertDate()}', style: TextStyle(color: Colors.grey[500], fontSize: 9)),
              ],
            ),
          ),        
        ],
      ),
  );
}