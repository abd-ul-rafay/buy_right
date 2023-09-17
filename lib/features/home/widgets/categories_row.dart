import 'package:flutter/material.dart';

class CategoriesRow extends StatelessWidget {
  final List<String> categories;
  final int selectedCategory;
  final Function(int) handleClick;

  const CategoriesRow({
    Key? key,
    required this.categories,
    required this.selectedCategory,
    required this.handleClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Categories',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        SizedBox(
          height: 35.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: categories.length,
            itemBuilder: (context, index) => Container(
              margin: const EdgeInsets.only(right: 8.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: selectedCategory == index
                      ? Colors.grey.shade500
                      : Colors.grey.shade300,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextButton(
                onPressed: () => handleClick(index),
                child: Text(categories[index]),
              ),
            ),
          ),
        )
      ],
    );
  }
}
