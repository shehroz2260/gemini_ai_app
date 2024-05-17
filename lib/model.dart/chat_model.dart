import 'dart:typed_data';

class ChatModel {
  final String message;
  final Uint8List? image;
  ChatModel({
    required this.message,
    this.image,
  });

  ChatModel copyWith({
    String? message,
    Uint8List? image,
  }) {
    return ChatModel(
      message: message ?? this.message,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'image': image,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      message: map['message'] as String,
      image: map['image'],
    );
  }

  @override
  String toString() => 'ChatModel(message: $message, image: $image)';
}
