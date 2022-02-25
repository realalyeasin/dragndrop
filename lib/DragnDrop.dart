import 'package:flutter/material.dart';

class DragnDrop extends StatefulWidget {
  const DragnDrop({Key? key}) : super(key: key);

  @override
  _DragnDropState createState() => _DragnDropState();
}

class _DragnDropState extends State<DragnDrop> {
  late List<ItemModel> items;
  late List<ItemModel> items2;
  late double score = 0;
  @override
  void initState() {
    InitMatch();
    super.initState();
    score = 0;
  }

  void InitMatch() {
    items = [
      ItemModel(
        image: 'images/dog.png',
        value: "Dog",
        name: "Dog",
      ),
      ItemModel(
        image: 'images/key.jpg',
        value: "Key",
        name: "Key",
      ),
      ItemModel(
        image: 'images/mountain.jpg',
        value: "Mountain",
        name: "Mountain",
      ),
      ItemModel(
        image: 'images/newspaper.jpg',
        value: "Newspaper",
        name: "Newspaper",
      ),
    ];
    items2 = List<ItemModel>.from(items);
    items2.shuffle();
    items.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Drag and Drop'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "Score : $score",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                    letterSpacing: 2
                  ),
                ),
              ),
            ),
            Divider(color: Colors.black,thickness: 3),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Center(
                    child: Column(
                      children: items.map((e) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Draggable<ItemModel>(
                            data: e,
                            childWhenDragging: Text(e.name,style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, backgroundColor: Colors.grey),),
                              feedback: Text(e.name,style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, backgroundColor: Colors.yellow),),
                              child: Text(e.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, backgroundColor: Colors.yellow),))
                      )).toList(),
                    ),
                  ),
                ),
                Spacer(),
                Column(
                  children: items2.map((e) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DragTarget<ItemModel>(
                      onAccept: (rcv){
                        if(e.value == rcv.value){
                          setState(() {
                            items.remove(rcv);
                            items2.remove(e);
                            score+=5;
                          });
                        } else{
                          setState(() {
                            score-=2.5 ;
                          });
                        }
                      },
                      onWillAccept: (rcv)=> true,
                        builder: (context, accepted, rejected) {
                          return Padding(padding: EdgeInsets.all(2),
                          child: Image.asset(e.image, fit: BoxFit.cover, height: 140 ));
                        },
                        ),
                  )).toList(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ItemModel {
  String name, value;
  String image;

  ItemModel({required this.name, required this.value, required this.image});
}
