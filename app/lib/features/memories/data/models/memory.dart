import 'package:equatable/equatable.dart';

/// The longest title and note the server accepts.
const int memoryTitleMaxLength = 160;
const int memoryBodyMaxLength = 3000;

/// The longest place name the server accepts.
const int memoryPlaceMaxLength = 120;

/// Whether [place] reads like a street address rather than a place name.
///
/// Places keep only a name, so the form nudges away from numbers and street words.
bool looksLikeAddress(String place) {
  final text = place.toLowerCase();
  final hasNumber = RegExp(r'\d').hasMatch(text);
  final hasStreetWord = RegExp(
    r'\b(rua|av|avenida|alameda|travessa|rodovia|street|st|road|rd|avenue|ave)\b\.?',
  ).hasMatch(text);

  return hasNumber || hasStreetWord;
}

/// A memory the couple keeps.
final class const Memory({
  required final String id,
  required final String title,
  required final DateTime happenedOn,
  final String? body,
  final String? place,
}) with Equatable {
  /// A skeleton placeholder, never shown as a real record.
  factory fake() => Memory(id: 'fake', title: 'Nosso primeiro jantar', happenedOn: DateTime(2026));

  @override
  List<Object?> get props => [id, title, happenedOn, body, place];
}
