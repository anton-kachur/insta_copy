import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:insta_copy/createHeader.dart';
import 'package:video_player/video_player.dart';

var img_formats = ['ico', 'jpeg', 'jpg', 'png'];


/* ********************************************************
Class, responsible for creating states of body
******************************************************** */
class Body extends StatefulWidget {
  @override
  createBody createState() => createBody();
}


/* ********************************************************
Class which represents the states of body
******************************************************** */
class createBody extends State<Body> {
  // Create story bar
  storyBar() => SingleChildScrollView (
      child: Container(
            height: 100,
            child: ListView(
              itemExtent: 105, 
              shrinkWrap: true,   
              scrollDirection: Axis.horizontal,
              
              children: [ 
                Story(['myacc', 'lib/assets/guitarist.jpg'], isMe: true, child: createStory()), 
                Story(['rocky_guy', 'lib/assets/rocks.jpg', ], child: createStory()),
                Story(['_noname_', 'lib/assets/no-avatar.png', ], child: createStory()),
                Story(['author_art', 'lib/assets/moon.jpg', ], child: createStory()),
                Story(['author_art', 'lib/assets/moon.jpg', ], child: createStory()),
                Story(['author_art', 'lib/assets/moon.jpg', ], child: createStory()),
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
              Publication('myacc', 'lib/assets/guitarist.jpg', {'lib/assets/coffee1.jpg'}, '22/09/2021', 0, ['Фу! Чай лучше']),
              Publication('myacc', 'lib/assets/guitarist.jpg', {'lib/assets/coffee2.jpg', 'lib/assets/coffee3.jpg'}, 
                          '22/09/2021', 1, ['Wow', 'Nice', 'I saw better(((']
              ),
              Publication('author_art', 'lib/assets/moon.jpg', {'lib/assets/coffee3.jpg'}, '22/09/2021', 12, []),
              Publication('author_art', 'lib/assets/moon.jpg',
                          {'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'}, '22/09/2021', 12, []
              ),
            ],
        ),
      )
    );
}


/* ********************************************************
Class, responsible for creating states of publication buttons
******************************************************** */
class Publication extends StatefulWidget {
  var acc_name;
  var img;
  var content;
  var date;
  var likes;
  var comments;

  Publication(this.acc_name, this.img, this.content, this.date, [this.likes=0, this.comments]);

  @override
  createPublication createState() => createPublication();
}

/* ********************************************************
Class which represents the states of publication buttons
******************************************************** */
class createPublication extends State<Publication>{
  var icon_size = 25.0;
  var indexes = [false, false];
  var _controller;


  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        upperBar(widget.img), 
        (contentType() == 'image')? addPhoto(): addVideo(),
        SizedBox(height: 9), 
        lowerBar()
      ]
    );
  }
  
  
  contentType() {
    var len = widget.content.elementAt(0).length;
    var format = (widget.content.elementAt(0)).substring(len-3, len);
    if (img_formats.contains(format))
      return 'image';
    return 'video';
  }

  // Adding a set of photos, videos, etc. to  publication
  addVideo() => SingleChildScrollView (
      child:Container(
        height: 350,
        child: ListView(
          physics: ClampingScrollPhysics(),
          itemExtent: 360, 
          shrinkWrap: true,   
          scrollDirection: Axis.horizontal,
          children: [ 
            Scaffold(
              body: Center(
                child: _controller.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      )
                    : Container(),
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
              floatingActionButton: FloatingActionButton(
                elevation: 0.0,
                backgroundColor: Colors.transparent,
                splashColor: Colors.transparent,

                onPressed: () {
                  setState(() {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  });
                },
                child: Icon(
                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                ),
              ),
              
              
            ),  
          ],
        ),
      ),
    );

  
  addPhoto() => SingleChildScrollView (
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