import 'package:flutter/material.dart';


class TagPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                  [
                    Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [Container(width: 30,height: 30,color: Colors.black,)],
                      ),
                    )
                  ]
              ),
            ),

            // other sliver widgets
          ],
        )
    );
  }
}
