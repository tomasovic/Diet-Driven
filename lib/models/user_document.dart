import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:diet_driven/models/models.dart';

part 'user_document.g.dart';

/// Read only user document
abstract class UserDocument implements Built<UserDocument, UserDocumentBuilder> {
  static Serializer<UserDocument> get serializer => _$userDocumentSerializer;

  String get currentSubscription; // TODO: subscription enum

  UserDocument._();
  factory UserDocument([updates(UserDocumentBuilder b)]) = _$UserDocument;
}
