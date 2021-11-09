import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insta_copy/createBody.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:mdi/mdi.dart';

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


/* ********************************************************
Class, responsible for saving data for story 
******************************************************** */
class Story extends InheritedWidget {
  var isMe;
  
  Story(dataset, {this.isMe=false, required Widget child}): 
                        assert(child!=null),
                        assert(dataset!=null), 
                        super(child: child) {
                          for (int i=0; i<dataset.length; i++) {
                             data[data.keys.elementAt(i)] = dataset[i];
                           }
                        }
  final data = {
    'acc_name': '',
    'img': ''  
  };

  static Story? of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<Story>();
  @override
  bool updateShouldNotify(covariant Story oldWidget) => oldWidget.data != data;  
}


/* ******************************************************** 
Class, responsible for creating story 
******************************************************** */ 
class createStory extends StatelessWidget{
  late final story;
  late final gradientDecoration;

  @override
  Widget build(BuildContext context) {
    story = Story.of(context); // get data from Story class

    // Create gradient colors for decoration
    gradientDecoration = BoxDecoration(
      gradient: LinearGradient(colors: [Colors.black, Colors.redAccent]),
      border: Border.all(width: 2, color: story.isMe ? Colors.white : Colors.redAccent),
      borderRadius: BorderRadius.circular(50)
    );

    // Creates story page with account name, publication and the time passed since the story was posted
    return Column( 
        children: [
          FlatButton(
            onPressed: () { 
              // When the story widget is pressed, the page with story is creating
              Navigator.push( context, 
                MaterialPageRoute(
                    builder: (context) => StoryPage(
                                    story.data['acc_name'], story.data['img'],
                                    {'lib/assets/coffee2.jpg', 'lib/assets/coffee3.jpg'},
                                    DateTime(2021, 11, 4, 17, 58),
                                  )
                )
              );
            }, 

            child: Container(
              child: Container(
                width: 70.0,
                height: 70.0,
                
                child: story.isMe? addStory(): Text(''), // you can add new story if only that account belongs you
                  
                // Create decorative borders for a story
                decoration: BoxDecoration(
                  color: const Color(0xff7c94b6),
                  image: DecorationImage( image: AssetImage(story.data['img']), fit: BoxFit.cover),
                  border: Border.all( color: Colors.white, width: 3),
                  borderRadius: BorderRadius.all( Radius.circular(50.0)),
                  gradient: LinearGradient(colors: [Colors.black, Colors.redAccent]),
                ),
              ),
              
              decoration: gradientDecoration,
            ), 
          ),
          
          SizedBox(height: 7),
          Text(story.data['acc_name'], style: TextStyle( color: Colors.grey[800], fontSize: 12)),
        ],
      );
  }
    
  // Button to add your story
  addStory() =>
    Container(
      height: 9, width: 9,
      child: Image.asset('lib/assets/add_blue_rounded.png', width: 20, height: 20,),
      alignment: Alignment.bottomRight,
  );
}


/* ********************************************************
Class, responsible for creating the content of story
******************************************************** */
class StoryPage extends StatelessWidget {
  var icon_size = 25.0;
  var indexes = [false, false];
  var acc_name;
  var img;
  var content;
  var date;

  StoryPage(this.acc_name, this.img, this.content, this.date);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: upperBar(this.img), 
      body: Column(
        children: [
          Container(
            child: addPhoto(),//(contentType() == 'image')? addPhoto(): addVideo(),
          ), 
          lowerBar()
        ]
      ),
    );
  }
  
  // Gets the type of content (image or video)
  contentType() {
    var len = this.content.elementAt(0).length;
    var format = (this.content.elementAt(0)).substring(len-3, len);
    if (img_formats.contains(format))
      return 'image';
    return 'video';
  }
  
  // Add photo if the content type is 'image'
  addPhoto() => SingleChildScrollView (
      child:Container(
        height: 550,
        child: ListView(
          physics: ClampingScrollPhysics(),
          itemExtent: 360, 
          shrinkWrap: true,   
          scrollDirection: Axis.horizontal,
          children: [ 
            for (String e in this.content)
              Image.asset(e, fit: BoxFit.cover, height: 350, width: 440), 
          ],
        ),
      ),
    );

  // Function that compares date of publication and date now and returns the time passed
  convertDate() {
    var diff = DateTime.now().difference(this.date);
    
    if (diff.inDays >= 7) {
      return (DateTime.now().difference(this.date).inDays ~/ 7).toString() + ' нед.';  
    } else if (diff.inDays > 0) {
      return DateTime.now().difference(this.date).inDays.toString() + ' дн.';  
    } else if (diff.inHours > 0) {
      return DateTime.now().difference(this.date).inHours.toString() + ' ч.';
    } else if (diff.inMinutes > 0) {
      return DateTime.now().difference(this.date).inMinutes.toString() + ' мин.';  
    } 
    
    return DateTime.now().difference(this.date).inSeconds.toString() + ' с.';      
  }

  // Create progress bar at the top of the story
  createProgressBar() => Container(
        height: 10,
        child: ListView( 
          scrollDirection: Axis.horizontal,
          children: [ 
            LinearPercentIndicator(
              width: 340,
              lineHeight: 1.5,
              percent: 0.5,
              progressColor: Colors.white10,
              animation: true,
              animationDuration: 1,
              linearStrokeCap: LinearStrokeCap.roundAll,
            ),          
          ],
        ),
    );

  // Create border for text field in bottom bar
  createBorder() => OutlineInputBorder(
      borderRadius: BorderRadius.circular(60),
      borderSide: BorderSide(
                    width: 1, 
                    color: Colors.white,
                    style: BorderStyle.solid
                  ),
    );

  // Function to create upper bar of story with progress bar, 
  //account name and settings button on it 
  upperBar(var img) => 
    AppBar(
      shadowColor: Colors.transparent,
      toolbarHeight: 80,
      backgroundColor: Colors.white12,
      automaticallyImplyLeading: false,
      title: Column(
        children: [
          createProgressBar(),
          SizedBox(height: 7.0),
          Row(
            children: [
              SizedBox(width: 2),
              Container(
                width: 35.0,
                height: 35.0,
                decoration: BoxDecoration(
                  color: const Color(0xff7c94b6),
                  image: DecorationImage(image: AssetImage(this.img), fit: BoxFit.cover),
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  border: Border.all(color: Colors.redAccent, width: 1.5),
                ),
              ),
              
              SizedBox(width: 10),
              Text(this.acc_name, style: TextStyle(color: Colors.white, fontSize: 14)),
              
              SizedBox(width: 7),
              Text(convertDate(), style: TextStyle(color: Colors.white60, fontSize: 12)), 
              
              SizedBox(width: 118),
              TextButton(
                  child: Icon(
                    Icons.more_vert_rounded,
                    color: Colors.white,
                  ),
                  onPressed: () { },
              ),
            ],
          ),
        ],
      ),
  );

  // Function to create lower bar of story with text field in it 
  lowerBar() => Container(
      width: 400,
      height: 106,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 14),
          
          // First child is for text input
          Expanded(
            child: TextField(
              cursorColor: Colors.white,
              style: TextStyle(color: Colors.white,),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.text,

              decoration: InputDecoration(
                hintText: 'Отправить сообщение',
                hintStyle: TextStyle(fontSize: 12, color: Colors.white),
                contentPadding: EdgeInsets.all(8),
                fillColor: Colors.black,
                filled: true,
              
                focusedBorder: createBorder(),
                enabledBorder: createBorder(),
              ),
            ),
          ),
              
          // Message button
          TextButton(
            style: TextButton.styleFrom( backgroundColor: Colors.white, shape: CircleBorder()),
            child: Icon( Mdi.send, color: Colors.black),
            onPressed: () {},
          ),
        ]
      )
    );
}