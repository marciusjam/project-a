/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart' as amplify_core;
import 'package:collection/collection.dart';


/** This is an auto generated class representing the Post type in your schema. */
class Post extends amplify_core.Model {
  static const classType = const _PostModelType();
  final String id;
  final String? _description;
  final String? _image;
  final String? _video;
  final List<Comment>? _comments;
  final User? _user;
  final String? _userId;
  final amplify_core.TemporalDateTime? _createdOn;
  final amplify_core.TemporalDateTime? _updatedOn;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get description {
    try {
      return _description!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get image {
    return _image;
  }
  
  String? get video {
    return _video;
  }
  
  List<Comment>? get comments {
    return _comments;
  }
  
  User? get user {
    return _user;
  }
  
  String? get userId {
    return _userId;
  }
  
  amplify_core.TemporalDateTime? get createdOn {
    return _createdOn;
  }
  
  amplify_core.TemporalDateTime? get updatedOn {
    return _updatedOn;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Post._internal({required this.id, required description, image, video, comments, user, userId, createdOn, updatedOn, createdAt, updatedAt}): _description = description, _image = image, _video = video, _comments = comments, _user = user, _userId = userId, _createdOn = createdOn, _updatedOn = updatedOn, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Post({String? id, required String description, String? image, String? video, List<Comment>? comments, User? user, String? userId, amplify_core.TemporalDateTime? createdOn, amplify_core.TemporalDateTime? updatedOn}) {
    return Post._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      description: description,
      image: image,
      video: video,
      comments: comments != null ? List<Comment>.unmodifiable(comments) : comments,
      user: user,
      userId: userId,
      createdOn: createdOn,
      updatedOn: updatedOn);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Post &&
      id == other.id &&
      _description == other._description &&
      _image == other._image &&
      _video == other._video &&
      DeepCollectionEquality().equals(_comments, other._comments) &&
      _user == other._user &&
      _userId == other._userId &&
      _createdOn == other._createdOn &&
      _updatedOn == other._updatedOn;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Post {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("description=" + "$_description" + ", ");
    buffer.write("image=" + "$_image" + ", ");
    buffer.write("video=" + "$_video" + ", ");
    buffer.write("userId=" + "$_userId" + ", ");
    buffer.write("createdOn=" + (_createdOn != null ? _createdOn!.format() : "null") + ", ");
    buffer.write("updatedOn=" + (_updatedOn != null ? _updatedOn!.format() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Post copyWith({String? id, String? description, String? image, String? video, List<Comment>? comments, User? user, String? userId, amplify_core.TemporalDateTime? createdOn, amplify_core.TemporalDateTime? updatedOn}) {
    return Post._internal(
      id: id ?? this.id,
      description: description ?? this.description,
      image: image ?? this.image,
      video: video ?? this.video,
      comments: comments ?? this.comments,
      user: user ?? this.user,
      userId: userId ?? this.userId,
      createdOn: createdOn ?? this.createdOn,
      updatedOn: updatedOn ?? this.updatedOn);
  }
  
  Post copyWithModelFieldValues({
    ModelFieldValue<String>? id,
    ModelFieldValue<String>? description,
    ModelFieldValue<String?>? image,
    ModelFieldValue<String?>? video,
    ModelFieldValue<List<Comment>?>? comments,
    ModelFieldValue<User?>? user,
    ModelFieldValue<String?>? userId,
    ModelFieldValue<amplify_core.TemporalDateTime?>? createdOn,
    ModelFieldValue<amplify_core.TemporalDateTime?>? updatedOn
  }) {
    return Post._internal(
      id: id == null ? this.id : id.value,
      description: description == null ? this.description : description.value,
      image: image == null ? this.image : image.value,
      video: video == null ? this.video : video.value,
      comments: comments == null ? this.comments : comments.value,
      user: user == null ? this.user : user.value,
      userId: userId == null ? this.userId : userId.value,
      createdOn: createdOn == null ? this.createdOn : createdOn.value,
      updatedOn: updatedOn == null ? this.updatedOn : updatedOn.value
    );
  }
  
  Post.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _description = json['description'],
      _image = json['image'],
      _video = json['video'],
      _comments = json['comments'] is List
        ? (json['comments'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Comment.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _user = json['user']?['serializedData'] != null
        ? User.fromJson(new Map<String, dynamic>.from(json['user']['serializedData']))
        : null,
      _userId = json['userId'],
      _createdOn = json['createdOn'] != null ? amplify_core.TemporalDateTime.fromString(json['createdOn']) : null,
      _updatedOn = json['updatedOn'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedOn']) : null,
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'description': _description, 'image': _image, 'video': _video, 'comments': _comments?.map((Comment? e) => e?.toJson()).toList(), 'user': _user?.toJson(), 'userId': _userId, 'createdOn': _createdOn?.format(), 'updatedOn': _updatedOn?.format(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'description': _description,
    'image': _image,
    'video': _video,
    'comments': _comments,
    'user': _user,
    'userId': _userId,
    'createdOn': _createdOn,
    'updatedOn': _updatedOn,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final ID = amplify_core.QueryField(fieldName: "id");
  static final DESCRIPTION = amplify_core.QueryField(fieldName: "description");
  static final IMAGE = amplify_core.QueryField(fieldName: "image");
  static final VIDEO = amplify_core.QueryField(fieldName: "video");
  static final COMMENTS = amplify_core.QueryField(
    fieldName: "comments",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Comment'));
  static final USER = amplify_core.QueryField(
    fieldName: "user",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'User'));
  static final USERID = amplify_core.QueryField(fieldName: "userId");
  static final CREATEDON = amplify_core.QueryField(fieldName: "createdOn");
  static final UPDATEDON = amplify_core.QueryField(fieldName: "updatedOn");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Post";
    modelSchemaDefinition.pluralName = "Posts";
    
    modelSchemaDefinition.indexes = [
      amplify_core.ModelIndex(fields: const ["userId", "createdOn"], name: "byUser")
    ];
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Post.DESCRIPTION,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Post.IMAGE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Post.VIDEO,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: Post.COMMENTS,
      isRequired: false,
      ofModelName: 'Comment',
      associatedKey: Comment.POST
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasOne(
      key: Post.USER,
      isRequired: false,
      ofModelName: 'User',
      associatedKey: User.POSTS
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Post.USERID,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Post.CREATEDON,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Post.UPDATEDON,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _PostModelType extends amplify_core.ModelType<Post> {
  const _PostModelType();
  
  @override
  Post fromJson(Map<String, dynamic> jsonData) {
    return Post.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Post';
  }
}