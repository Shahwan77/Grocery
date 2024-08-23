class PopularItem {
  final String imagePath1;
  final String text;

  PopularItem({
    required this.imagePath1,
    required this.text,
  });

  factory PopularItem.fromJson(Map<String, dynamic> json) {
    return PopularItem(
      text: json['text'] as String,
      imagePath1: json['imagePath1'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'imagePath1': imagePath1,
    };
  }
}

final List<PopularItem> popularItems = [
  PopularItem(imagePath1: 'assets/cat13.jpg', text: 'LIP CARE'),
  PopularItem(imagePath1: 'assets/cat14.jpg', text: 'COTTON\nBUDS/PADS'),
  PopularItem(imagePath1: 'assets/cat15.jpg', text: 'FILIPINO\nCOSMETICS'),
  PopularItem(imagePath1: 'assets/cat4.png', text: 'Item 4'),
];
