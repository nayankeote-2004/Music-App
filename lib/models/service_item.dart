class ServiceItem {
  final String title;
  final String subtitle;
  final String iconAsset;

  ServiceItem({
    required this.title,
    required this.subtitle,
    required this.iconAsset,
  });

  factory ServiceItem.fromMap(Map<String, dynamic> map) {
    return ServiceItem(
      title: map['title'] ?? '',
      subtitle: map['subtitle'] ?? '',
      iconAsset: map['iconAsset'] ?? '',
    );
  }
}
