class Contacts {
  final int id;
  final String name;
  final String phone;
  final String email;

  Contacts(this.id, this.name, this.phone, this.email);

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email' : email
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Contacts {id: $id, name: $name, phone: $phone}';
  }
}
