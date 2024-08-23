import 'package:flutter/material.dart';

class SeeAllPage extends StatelessWidget {
  const SeeAllPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> imageUrls = [
      "assets/cat2.png", "assets/cat5.png",
      "assets/cat3.png", "assets/cat6.png",
      "assets/cat4.png", "assets/cat7.png",
      "assets/cat2.png", "assets/cat5.png",
      "assets/cat3.png", "assets/cat6.png",
      "assets/cat4.png", "assets/cat7.png",
    ];

    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.green.shade800,
          title: Text('See All'),

        ),
        body: Column(
          children: [
            Container(
              color: Colors.white,
              child: TabBar(
                indicatorColor: Colors.green.shade800,
                tabs: [
                  Tab(text: 'Tab 1'),
                  Tab(text: 'Tab 2'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // First tab content
                  GridView.builder(
                    padding: EdgeInsets.all(8.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of columns in the grid
                      crossAxisSpacing: 20.0, // Space between columns
                      mainAxisSpacing: 40.0, // Space between rows
                      mainAxisExtent: 200
                    ),
                    itemCount: imageUrls.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            height: 200, // Container height
                            width: 160,  // Container width
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 4.0,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(Icons.favorite_border, color: Colors.green),
                                      Icon(Icons.info_outline, color: Colors.green),
                                    ],
                                  ),
                                ),
                                Center(
                                  child: Image.asset(
                                    imageUrls[index],
                                    fit: BoxFit.cover,
                                    height: 100, // Image height
                                    width: 100,  // Image width
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  // Second tab content
                  GridView.builder(
                    padding: EdgeInsets.all(8.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of columns in the grid
                      crossAxisSpacing: 20.0, // Space between columns
                      mainAxisSpacing: 40.0, // Space between rows
                    ),
                    itemCount: imageUrls.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            height: 200, // Container height
                            width: 160,  // Container width
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 4.0,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(Icons.favorite_border, color: Colors.green),
                                      Icon(Icons.info_outline, color: Colors.green),
                                    ],
                                  ),
                                ),
                                Center(
                                  child: Image.asset(
                                    imageUrls[index],
                                    fit: BoxFit.cover,
                                    height: 100, // Image height
                                    width: 100,  // Image width
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
