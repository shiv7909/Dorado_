

class PageTitle {
  final String title;

  PageTitle({
    required this.title,
  });

  factory PageTitle.fromJson(Map<String, dynamic> json) {
    return PageTitle(
      title: json['title'] ?? '',
    );
  }
}