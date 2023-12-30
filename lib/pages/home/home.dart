import 'package:flutter/material.dart';

import '../../constans/constans.dart';
import '../../constans/widgets/widgets.dart';
import '../../models/plants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    int selectedIndex = 0;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                          ),
                          width: size.width * .9,
                          decoration: BoxDecoration(
                            color: Constants.primaryColor.withOpacity(.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.search,
                                  color: Colors.black54.withOpacity(.6),
                                ),
                                const Expanded(
                                    child: TextField(
                                  showCursor: false,
                                  decoration: InputDecoration(
                                    hintText: 'Search Plant',
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                  ),
                                )),
                                Icon(
                                  Icons.mic,
                                  color: Colors.black54.withOpacity(.6),
                                )
                              ]))
                    ])),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                height: 50.0,
                width: size.width,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: plantTypes.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                });
                              },
                              child: Text(plantTypes[index],
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: selectedIndex == index
                                        ? FontWeight.bold
                                        : FontWeight.w300,
                                    color: selectedIndex == index
                                        ? Constants.primaryColor
                                        : Constants.blackColor,
                                  ))));
                    })),
            SizedBox(
              height: size.height * .3,
              child: ListView.builder(
                  itemCount: plantList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {},
                        child: Container(
                            width: 200,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: Constants.primaryColor.withOpacity(.8),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Stack(children: [
                              Positioned(
                                top: 10,
                                right: 20,
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        bool isFavorited = toggleIsFavorated(
                                            plantList[index].isFavorated);
                                        plantList[index].isFavorated =
                                            isFavorited;
                                      });
                                    },
                                    icon: Icon(
                                      plantList[index].isFavorated == true
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: Constants.primaryColor,
                                    ),
                                    iconSize: 30,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 50,
                                right: 50,
                                top: 50,
                                bottom: 50,
                                child: Image.asset(plantList[index].imageURL),
                              ),
                              Positioned(
                                  bottom: 15,
                                  left: 20,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          plantList[index].category,
                                          style: const TextStyle(
                                            color: Colors.white70,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(plantList[index].plantName,
                                            style: const TextStyle(
                                              color: Colors.white70,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ))
                                      ])),
                              Positioned(
                                  bottom: 15,
                                  right: 20,
                                  child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        r'$' +
                                            plantList[index].price.toString(),
                                        style: TextStyle(
                                            color: Constants.primaryColor,
                                            fontSize: 16),
                                      )))
                            ])));
                  }),
            ),
            Container(
              padding: const EdgeInsets.only(left: 16, bottom: 20, top: 20),
              child: const Text(
                'New Plants',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              height: size.height * .5,
              child: ListView.builder(
                  itemCount: plantList.length,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {},
                        child: PlantWidget(index: index, plantList: plantList));
                  }),
            ),
          ],
        ),
      ),
    ));
  }

  List<Plant> plantList = Plant.plantList;

  //Plants category
  List<String> plantTypes = [
    'Recommended',
    'Indoor',
    'Outdoor',
    'Garden',
    'Supplement',
  ];

  //Toggle Favorite button
  bool toggleIsFavorated(bool isFavorited) {
    return !isFavorited;
  }
}
