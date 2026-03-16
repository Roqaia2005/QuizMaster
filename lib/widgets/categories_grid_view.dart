import 'package:flutter/material.dart';

import 'package:quiz_master/data/question.dart';
import 'package:quiz_master/widgets/category_item.dart';

class CategoriesGridView extends StatelessWidget {
  const CategoriesGridView({super.key, required this.categories});

  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemBuilder: (context, index) {
          return CategoryItem(category: categories[index]);
        },
        itemCount: categories.length,
      ),
    );
  }
}
