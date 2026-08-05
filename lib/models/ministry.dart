class Ministry {
  final String id;
  final String name;

  const Ministry({required this.id, required this.name});

  static const List<Ministry> all = [
    Ministry(id: 'youth', name: 'Youth'),
    Ministry(id: 'teens', name: 'Teens'),
    Ministry(id: 'band', name: 'Band'),
    Ministry(id: 'media', name: 'Media'),
    Ministry(id: 'pastoral', name: 'Pastoral'),
    Ministry(id: 'evangelism', name: 'Evangelism'),
    Ministry(id: 'support', name: 'Support'),
    Ministry(id: 'service', name: 'Service'),
    Ministry(id: 'administration', name: 'Administration'),
  ];
}
