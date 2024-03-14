class ParticularProduct {
  final String id;
  final String Title;
  final String Description;
  final List<String> colors;


  final int oprice;
  final int nprice;
  final int discount;
  final String color;
  final String varid;

  final List<String> images;
  final int Quantity;
  final List<SizeInfo> sizes;
  final String DimensionalModle;


  ParticularProduct ({
    required this.id,
    required this.Title,
    required this.Description,
   required this.colors,

    required this.oprice,
    required this.nprice,
    required this.discount,
    required this.color,
    required this.varid,

    required this.Quantity,
    required this.images,
    required this.sizes,
    required this.DimensionalModle,

  });

}

class SizeInfo {
  final String size;
  final int availableItems;

  SizeInfo({
    required this.size,
    required this.availableItems,
  });
}








