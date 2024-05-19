import 'package:voguevoyage/utils/image_data.dart';
import 'package:voguevoyage/utils/product.dart';
import 'package:voguevoyage/utils/selection.dart';
import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:provider/provider.dart';
import 'package:voguevoyage/utils/adjustments.dart';

List<Product> allProducts = [
  Product('assets/images/dataset/shoe1.png', 'other', 'casual', 'Sneakers',
      'white'),
  Product('assets/images/dataset/shoe2.png', 'other', 'casual', 'Sneakers',
      'black'),
  Product('assets/images/dataset/shoe3.png', 'other', 'casual', 'Sneakers',
      'beige'),
  Product(
      'assets/images/dataset/shoe4.png', 'other', 'other', 'Sneakers', 'brown'),
  Product(
      'assets/images/dataset/shoe5.png', 'other', 'casual', 'Sneakers', 'blue'),
  Product(
      'assets/images/dataset/shoe6.png', 'other', 'other', 'Boots', 'black'),
  Product(
      'assets/images/dataset/shoe7.png', 'other', 'other', 'Boots', 'brown'),
  Product(
      'assets/images/dataset/ring1.png', 'other', 'other', 'Rings', 'black'),
  Product(
      'assets/images/dataset/ring2.png', 'other', 'other', 'Rings', 'silver'),
  Product('assets/images/dataset/ring3.png', 'other', 'other', 'Rings', 'gold'),
  Product(
      'assets/images/dataset/shirt1.png', 'other', 'casual', 'Shirts', 'black'),
  Product(
      'assets/images/dataset/shirt2.png', 'other', 'casual', 'Shirts', 'white'),
  Product('assets/images/dataset/shirt3.png', 'other', 'casual', 'Shirts',
      'orange'),
  Product(
      'assets/images/dataset/shirt4.png', 'other', 'casual', 'Shirts', 'pink'),
  Product('assets/images/dataset/shirt5.png', 'other', 'casual', 'Shirts',
      'yellow'),
  Product(
      'assets/images/dataset/shorts1.png', 'male', 'casual', 'Shorts', 'black'),
  Product(
      'assets/images/dataset/shorts2.png', 'male', 'casual', 'Shorts', 'white'),
  Product(
      'assets/images/dataset/shorts3.png', 'male', 'casual', 'Shorts', 'beige'),
  Product('assets/images/dataset/shorts4.png', 'female', 'casual', 'Shorts',
      'white'),
  Product('assets/images/dataset/shorts5.png', 'female', 'casual', 'Shorts',
      'black'),
  Product('assets/images/dataset/shorts6.png', 'female', 'casual', 'Shorts',
      'denim'),
  Product('assets/images/dataset/shorts7.png', 'female', 'casual', 'Shorts',
      'beige'),
  Product('assets/images/dataset/jacket1.png', 'other', 'casual', 'Jackets',
      'black'),
  Product(
      'assets/images/dataset/jacket2.png', 'other', 'casual', 'Jackets', 'red'),
  Product('assets/images/dataset/jacket3.png', 'other', 'casual', 'Jackets',
      'white'),
  Product('assets/images/dataset/jacket4.png', 'other', 'casual', 'Jackets',
      'gray'),
  Product('assets/images/dataset/jacket5.png', 'other', 'casual', 'Jackets',
      'blue'),
  Product('assets/images/dataset/sweatshirt1.png', 'other', 'casual',
      'Sweatshirts', 'black'),
  Product('assets/images/dataset/sweatshirt2.png', 'other', 'casual',
      'Sweatshirts', 'blue'),
  Product('assets/images/dataset/sweatshirt3.png', 'other', 'casual',
      'Sweatshirts', 'yellow'),
  Product('assets/images/dataset/sweatshirt4.png', 'other', 'casual',
      'Sweatshirts', 'red'),
  Product('assets/images/dataset/sweatshirt5.png', 'other', 'casual',
      'Sweatshirts', 'white'),
  Product(
      'assets/images/dataset/skirt1.png', 'female', 'casual', 'Skirts', 'pink'),
  Product(
      'assets/images/dataset/skirt2.png', 'female', 'casual', 'Skirts', 'red'),
  Product(
      'assets/images/dataset/skirt3.png', 'female', 'casual', 'Skirts', 'blue'),
  Product('assets/images/dataset/skirt4.png', 'female', 'casual', 'Skirts',
      'mauve'),
  Product('assets/images/dataset/skirt5.png', 'female', 'casual', 'Skirts',
      'yellow'),
  Product('assets/images/dataset/hat1.png', 'other', 'casual', 'Hats', 'black'),
  Product('assets/images/dataset/hat2.png', 'other', 'casual', 'Hats', 'white'),
  Product('assets/images/dataset/hat3.png', 'other', 'casual', 'Hats', 'beige'),
  Product('assets/images/dataset/baggyjeans1.png', 'other', 'casual', 'Jeans',
      'blue'),
  Product('assets/images/dataset/baggyjeans2.png', 'other', 'casual', 'Jeans',
      'blue'),
  Product('assets/images/dataset/baggyjeans3.png', 'other', 'casual', 'Jeans',
      'black'),
  Product('assets/images/dataset/baggyjeans4.png', 'other', 'casual', 'Jeans',
      'blue'),
  Product('assets/images/dataset/baggyjeans5.png', 'other', 'casual', 'Jeans',
      'blue'),
  Product('assets/images/dataset/bootcut1.png', 'other', 'casual', 'Jeans',
      'black'),
  Product(
      'assets/images/dataset/bootcut2.png', 'other', 'casual', 'Jeans', 'blue'),
  Product(
      'assets/images/dataset/bootcut3.png', 'other', 'casual', 'Jeans', 'blue'),
  Product('assets/images/dataset/bootcut4.png', 'other', 'casual', 'Jeans',
      'white'),
  Product('assets/images/dataset/loosefit1.png', 'other', 'casual', 'Jeans',
      'black'),
  Product('assets/images/dataset/loosefit2.png', 'other', 'casual', 'Jeans',
      'blue'),
  Product('assets/images/dataset/loosefit3.png', 'other', 'casual', 'Jeans',
      'blue'),
  Product('assets/images/dataset/loosefit4.png', 'other', 'casual', 'Jeans',
      'white'),
  Product('assets/images/dataset/regularfit1.png', 'other', 'casual', 'Jeans',
      'black'),
  Product('assets/images/dataset/regularfit2.png', 'other', 'casual', 'Jeans',
      'blue'),
  Product('assets/images/dataset/regularfit3.png', 'other', 'casual', 'Jeans',
      'white'),
  Product('assets/images/dataset/regularfit4.png', 'other', 'casual', 'Jeans',
      'blue'),
  Product(
      'assets/images/dataset/skinny1.png', 'other', 'casual', 'Jeans', 'blue'),
  Product(
      'assets/images/dataset/skinny2.png', 'other', 'casual', 'Jeans', 'black'),
  Product(
      'assets/images/dataset/skinny3.png', 'other', 'casual', 'Jeans', 'blue'),
  Product('assets/images/dataset/skinny4.png', 'other', 'casual', 'Jeans',
      'faded black'),
  Product('assets/images/dataset/pant1.png', 'other', 'casual', 'Pants', 'red'),
  Product(
      'assets/images/dataset/pant2.png', 'other', 'casual', 'Pants', 'yellow'),
  Product(
      'assets/images/dataset/pant3.png', 'other', 'other', 'Pants', 'black'),
  Product('assets/images/dataset/pant4.png', 'other', 'other', 'Pants', 'blue'),
  Product('assets/images/dataset/pant5.png', 'other', 'other', 'Pants', 'gray'),
  Product(
      'assets/images/dataset/tshirt1.png', 'other', 'casual', 'Tshirts', 'red'),
  Product('assets/images/dataset/tshirt2.png', 'other', 'casual', 'Tshirts',
      'orange'),
  Product('assets/images/dataset/tshirt3.png', 'other', 'casual', 'Tshirts',
      'yellow'),
  Product('assets/images/dataset/tshirt4.png', 'other', 'casual', 'Tshirts',
      'blue'),
  Product('assets/images/dataset/tshirt5.png', 'other', 'casual', 'Tshirts',
      'olive'),
  Product('assets/images/dataset/tshirt6.png', 'other', 'casual', 'Tshirts',
      'white'),
  Product('assets/images/dataset/tshirt7.png', 'other', 'casual', 'Tshirts',
      'black'),
  Product('assets/images/dataset/tshirt8.png', 'other', 'casual', 'Tshirts',
      'gray'),
  Product('assets/images/dataset/tshirt9.png', 'other', 'casual', 'Tshirts',
      'brown'),
  Product('assets/images/dataset/graphictee1.png', 'other', 'casual', 'Tshirts',
      'white'),
  Product('assets/images/dataset/graphictee2.png', 'other', 'casual', 'Tshirts',
      'black'),
  Product('assets/images/dataset/graphictee3.png', 'other', 'casual', 'Tshirts',
      'cream'),
  Product('assets/images/dataset/graphictee4.png', 'other', 'casual', 'Tshirts',
      'cream'),
  Product('assets/images/dataset/graphictee5.png', 'other', 'casual', 'Tshirts',
      'blue'),
  Product(
      'assets/images/dataset/hoodie1.png', 'other', 'casual', 'Hoodie', 'blue'),
  Product('assets/images/dataset/hoodie2.png', 'other', 'casual', 'Hoodie',
      'olive'),
  Product(
      'assets/images/dataset/hoodie3.png', 'other', 'casual', 'Hoodie', 'blue'),
  Product(
      'assets/images/dataset/hoodie4.png', 'other', 'casual', 'Hoodie', 'red'),
  Product('assets/images/dataset/hoodie5.png', 'other', 'casual', 'Hoodie',
      'yellow'),
  Product(
      'assets/images/dataset/shirt1.png', 'other', 'casual', 'Shirts', 'black'),
  Product(
      'assets/images/dataset/shirt2.png', 'other', 'casual', 'Shirts', 'white'),
  Product('assets/images/dataset/shirt3.png', 'other', 'casual', 'Shirts',
      'orange'),
  Product(
      'assets/images/dataset/shirt4.png', 'other', 'casual', 'Shirts', 'pink'),
  Product('assets/images/dataset/shirt5.png', 'other', 'casual', 'Shirts',
      'yellow'),
  Product('assets/images/dataset/stripshirt1.png', 'other', 'casual', 'Shirts',
      'blue'),
  Product('assets/images/dataset/stripshirt2.png', 'other', 'casual', 'Shirts',
      'black'),
  Product('assets/images/dataset/stripshirt3.png', 'other', 'casual', 'Shirts',
      'yellow'),
  Product('assets/images/dataset/stripshirt4.png', 'other', 'casual', 'Shirts',
      'pink'),
  Product('assets/images/dataset/stripshirt5.png', 'other', 'casual', 'Shirts',
      'white'),
  Product('assets/images/dataset/plainblazer1.png', 'male', 'casual', 'Blazers',
      'black'),
  Product('assets/images/dataset/plainblazer2.png', 'male', 'casual', 'Blazers',
      'gray'),
  Product('assets/images/dataset/plainblazer3.png', 'male', 'casual', 'Blazers',
      'blue'),
  Product('assets/images/dataset/plainblazer4.png', 'male', 'casual', 'Blazers',
      'red'),
  Product('assets/images/dataset/plainblazer5.png', 'male', 'casual', 'Blazers',
      'white'),
  Product('assets/images/dataset/printedblazer1.png', 'male', 'other',
      'Blazers', 'black'),
  Product('assets/images/dataset/printedblazer2.png', 'male', 'other',
      'Blazers', 'white'),
  Product('assets/images/dataset/printedblazer3.png', 'male', 'other',
      'Blazers', 'blue'),
  Product('assets/images/dataset/printedblazer4.png', 'male', 'other',
      'Blazers', 'red'),
  Product('assets/images/dataset/printedblazer5.png', 'male', 'other',
      'Blazers', 'gray'),
  Product('assets/images/dataset/cargo1.png', 'other', 'casual', 'Casual Pants',
      'black'),
  Product('assets/images/dataset/cargo2.png', 'other', 'casual', 'Casual Pants',
      'blue'),
  Product('assets/images/dataset/cargo3.png', 'other', 'casual', 'Casual Pants',
      'gray'),
  Product('assets/images/dataset/cargo4.png', 'other', 'casual', 'Casual Pants',
      'olive'),
  Product('assets/images/dataset/cargo5.png', 'other', 'casual', 'Casual Pants',
      'cream')
];

Map<String, Map<String, List<String>>> complementaryColors = {
  'black': {
    'cool': ['navy', 'gray', 'white', 'black'],
    'warm': ['olive', 'brown', 'white', 'black']
  },
  'white': {
    'cool': ['blue', 'gray', 'black', 'white'],
    'warm': ['beige', 'pink', 'black', 'white']
  },
  'red': {
    'cool': ['gray', 'blue', 'white', 'black'],
    'warm': ['brown', 'beige', 'white', 'black']
  },
  'blue': {
    'cool': ['gray', 'olive', 'white', 'black'],
    'warm': ['beige', 'olive', 'white', 'black']
  },
  'olive': {
    'cool': ['blue', 'gray', 'black', 'white'],
    'warm': ['olive', 'beige', 'white', 'black']
  },
  'yellow': {
    'cool': ['beige', 'gray', 'black', 'white'],
    'warm': ['brown', 'olive', 'black', 'white']
  },
  'orange': {
    'cool': ['mauve', 'blue', 'black', 'white'],
    'warm': ['brown', 'pink', 'black', 'white']
  },
  'mauve': {
    'cool': ['gray', 'olive', 'black', 'white'],
    'warm': ['mauve', 'beige', 'black', 'white']
  },
  'pink': {
    'cool': ['blue', 'gray', 'black', 'white'],
    'warm': ['beige', 'gray', 'black', 'white']
  },
  'gray': {
    'cool': ['blue', 'olive', 'black', 'white'],
    'warm': ['navy', 'olive', 'black', 'white']
  },
  'brown': {
    'cool': ['gray', 'pink', 'black', 'white'],
    'warm': ['olive', 'pink', 'black', 'white']
  },
  'turquoise': {
    'cool': ['gray', 'beige', 'black', 'white'],
    'warm': ['navy', 'olive', 'black', 'white']
  },
  'lavender': {
    'cool': ['gray', 'pink', 'black', 'white'],
    'warm': ['olive', 'blue', 'black', 'white']
  },
  'teal': {
    'cool': ['gray', 'beige', 'black', 'white'],
    'warm': ['navy', 'olive', 'black', 'white']
  },
  'coral': {
    'cool': ['blue', 'beige', 'black', 'white'],
    'warm': ['pink', 'beige', 'black', 'white']
  },
  'navy': {
    'cool': ['gray', 'silver', 'black', 'white'],
    'warm': ['olive', 'beige', 'black', 'white']
  },
  'mint': {
    'cool': ['navy', 'gray', 'black', 'white'],
    'warm': ['beige', 'blue', 'black', 'white']
  },
  'maroon': {
    'cool': ['gray', 'pink', 'black', 'white'],
    'warm': ['beige', 'pink', 'black', 'white']
  },
  'gold': {
    'cool': ['navy', 'gray', 'black', 'white'],
    'warm': ['beige', 'navy', 'black', 'white']
  },
  'silver': {
    'cool': ['gray', 'navy', 'black', 'white'],
    'warm': ['navy', 'pink', 'black', 'white']
  },
  'peach': {
    'cool': ['gray', 'blue', 'black', 'white'],
    'warm': ['beige', 'blue', 'black', 'white']
  },
  'magenta': {
    'cool': ['gray', 'navy', 'black', 'white'],
    'warm': ['navy', 'beige', 'black', 'white']
  },
  'beige': {
    'cool': ['navy', 'gray', 'black', 'white'],
    'warm': ['gray', 'pink', 'black', 'white']
  },
  'indigo': {
    'cool': ['navy', 'gray', 'black', 'white'],
    'warm': ['beige', 'pink', 'black', 'white']
  }
};

class Carousels extends StatefulWidget {
  @override
  _CarouselsState createState() => _CarouselsState();
}

class _CarouselsState extends State<Carousels> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Outfit Builder'),
      ),
      body: ListView.builder(
        itemCount: 5, // Assuming you have 5 carousels
        itemBuilder: (context, index) => CarouselWidget(boxNumber: index + 1),
      ),
    );
  }
}

// Individual Carousel Widget
class CarouselWidget extends StatefulWidget {
  final int boxNumber;

  CarouselWidget({required this.boxNumber});

  @override
  _CarouselWidgetState createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  String? selectedType;
  List<Product> displayedProducts = allProducts;

  @override
  void initState() {
    super.initState();
    displayedProducts = allProducts;

    filterByComplementaryColors(displayedProducts, "white", "neutral");
    filterProducts(); // Initial filtering based on boxNumber
  }

  void filterProducts({String? apparelType, String? occasionType}) {
    final selectionModel = Provider.of<SelectionModel>(context, listen: false);
    final boxToApparelTypeMapProvider =
        Provider.of<BoxToApparelTypeMap>(context, listen: false);
    final List<String> allowedTypes =
        boxToApparelTypeMapProvider.boxToApparelTypeMap[widget.boxNumber] ?? [];
    final homeModel = Provider.of<HomeModel>(context, listen: false);
    occasionType = homeModel.occasion;
    print(allowedTypes);
    // Filter products based on the allowed types for the box number
    List<Product> filteredProducts = allProducts
        .where((product) => allowedTypes.contains(product.appareltype))
        .toList();

    // Further filter by the selected apparel type, if any
    if (apparelType != null) {
      filteredProducts = filteredProducts
          .where((product) => product.appareltype == apparelType)
          .toList();
    }
    if (occasionType != null) {
      filteredProducts = filteredProducts
          .where((product) => product.occasion == occasionType)
          .toList();
    }

    // Apply color filter based on skin color option and complementary colors
    if (homeModel.apparelColor.isNotEmpty &&
        selectionModel.skinColorOption.isNotEmpty) {
      filteredProducts = filterByComplementaryColors(filteredProducts,
          homeModel.apparelColor, selectionModel.skinColorOption);
    }

    setState(() {
      displayedProducts = filteredProducts;
    });
  }

  List<Product> filterByComplementaryColors(
      List<Product> products, String apparelColor, String skinColorOption) {
    Set<String> allowedColors = {};

    // Check if the apparelColor exists in the complementaryColors map
    if (complementaryColors.containsKey(apparelColor)) {
      Map<String, List<String>>? colorOptions =
          complementaryColors[apparelColor];

      if (skinColorOption == 'neutral') {
        // For 'neutral', combine both 'warm' and 'cool' colors without duplicates
        allowedColors.addAll(colorOptions?['cool'] ?? []);
        allowedColors.addAll(colorOptions?['warm'] ?? []);
      } else {
        // For 'warm' or 'cool', add only the relevant colors
        allowedColors.addAll(colorOptions?[skinColorOption] ?? []);
      }
    }

    // Filter products by the allowed colors
    print(allowedColors);
    return products
        .where((product) => allowedColors.contains(product.color))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final boxToApparelTypeMapProvider =
        Provider.of<BoxToApparelTypeMap>(context);
    final List<String> apparelTypes =
        boxToApparelTypeMapProvider.boxToApparelTypeMap[widget.boxNumber] ?? [];

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Carousel ${widget.boxNumber}'),
            buildPopupMenuButton(apparelTypes),
          ],
        ),
        buildCarousel(),
      ],
    );
  }

  PopupMenuButton<String> buildPopupMenuButton(List<String> apparelTypes) {
    return PopupMenuButton<String>(
      onSelected: (String newSelectedType) {
        filterProducts(
            apparelType:
                newSelectedType); // Filter products by the selected type
      },
      itemBuilder: (BuildContext context) {
        return apparelTypes.map((String type) {
          return PopupMenuItem<String>(
            value: type,
            child: Text(type),
          );
        }).toList();
      },
      icon: Icon(Icons.arrow_drop_down),
    );
  }

  Widget buildCarousel() {
    return Container(
      height: 150,
      child: ScrollSnapList(
        listController: ScrollController(),
        onItemFocus: (int index) {},
        dynamicItemSize: true,
        itemSize: 150, // Adjust size as needed
        itemBuilder: (BuildContext context, int index) {
          Product product = displayedProducts[index];
          return Card(
            child: Image.asset(product
                .imagePath), // Assuming imagePath is a property of Product
            // Add more product details here as needed
          );
        },
        itemCount: displayedProducts.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
