import 'package:flutter/material.dart';
import 'package:olearis_flutter/constants/app_constants.dart';

class ItemCard extends StatelessWidget {
  final String itemTitle;

  const ItemCard({
    super.key,
    required this.itemTitle,
  });

  double _widthHandler(BuildContext context) {
    final width = (MediaQuery.of(context).size.width -
                View.of(context).padding.right /
                    View.of(context).devicePixelRatio -
                View.of(context).padding.left /
                    View.of(context).devicePixelRatio) /
            AppConsts.listItemWidthDivider -
        AppConsts.listItemDividerCount;

    return width;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _widthHandler(context),
      height: _widthHandler(context) / AppConsts.listItemAspectRatio,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
      ),
      child: Center(
        child: Text(
          itemTitle,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
