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
  final String? _postId;
  final String? _description;
  final String? _content;
  final String? _orientation;
  final String? _contenttype;
  final RecordStatus? _status;
  final List<Comment>? _comments;
  final List<LikeLink>? _likes;
  final User? _user;
  final amplify_core.TemporalDateTime? _createdOn;
  final amplify_core.TemporalDateTime? _updatedOn;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  PostModelIdentifier get modelIdentifier {
      return PostModelIdentifier(
        id: id
      );
  }
  
  String get postId {
    try {
      return _postId!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
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
  
  String? get content {
    return _content;
  }
  
  String? get orientation {
    return _orientation;
  }
  
  String? get contenttype {
    return _contenttype;
  }
  
  RecordStatus get status {
    try {
      return _status!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  List<Comment>? get comments {
    return _comments;
  }
  
  List<LikeLink>? get likes {
    return _likes;
  }
  
  User? get user {
    return _user;
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
  
  const Post._internal({required this.id, required postId, required description, content, orientation, contenttype, required status, comments, likes, user, createdOn, updatedOn, createdAt, updatedAt}): _postId = postId, _description = description, _content = content, _orientation = orientation, _contenttype = contenttype, _status = status, _comments = comments, _likes = likes, _user = user, _createdOn = createdOn, _updatedOn = updatedOn, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Post({String? id, required String postId, required String description, String? content, String? orientation, String? contenttype, required RecordStatus status, List<Comment>? comments, List<LikeLink>? likes, User? user, amplify_core.TemporalDateTime? createdOn, amplify_core.TemporalDateTime? updatedOn}) {
    return Post._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      postId: postId,
      description: description,
      content: content,
      orientation: orientation,
      contenttype: contenttype,
      status: status,
      comments: comments != null ? List<Comment>.unmodifiable(comments) : comments,
      likes: likes != null ? List<LikeLink>.unmodifiable(likes) : likes,
      user: user,
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
      _postId == other._postId &&
      _description == other._description &&
      _content == other._content &&
      _orientation == other._orientation &&
      _contenttype == other._contenttype &&
      _status == other._status &&
      DeepCollectionEquality().equals(_comments, other._comments) &&
      DeepCollectionEquality().equals(_likes, other._likes) &&
      _user == other._user &&
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
    buffer.write("postId=" + "$_postId" + ", ");
    buffer.write("description=" + "$_description" + ", ");
    buffer.write("content=" + "$_content" + ", ");
    buffer.write("orientation=" + "$_orientation" + ", ");
    buffer.write("contenttype=" + "$_contenttype" + ", ");
    buffer.write("status=" + (_status != null ? amplify_core.enumToString(_status)! : "null") + ", ");
    buffer.write("user=" + (_user != null ? _user!.toString() : "null") + ", ");
    buffer.write("createdOn=" + (_createdOn != null ? _createdOn!.format() : "null") + ", ");
    buffer.write("updatedOn=" + (_updatedOn != null ? _updatedOn!.format() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Post copyWith({String? postId, String? description, String? content, String? orientation, String? contenttype, RecordStatus? status, List<Comment>? comments, List<LikeLink>? likes, User? user, amplify_core.TemporalDateTime? createdOn, amplify_core.TemporalDateTime? updatedOn}) {
    return Post._internal(
      id: id,
      postId: postId ?? this.postId,
      description: description ?? this.description,
      content: content ?? this.content,
      orientation: orientation ?? this.orientation,
      contenttype: contenttype ?? this.contenttype,
      status: status ?? this.status,
      comments: comments ?? this.comments,
      likes: likes ?? this.likes,
      user: user ?? this.user,
      createdOn: createdOn ?? this.createdOn,
      updatedOn: updatedOn ?? this.updatedOn);
  }
  
  Post copyWithModelFieldValues({
    ModelFieldValue<String>? postId,
    ModelFieldValue<String>? description,
    ModelFieldValue<String?>? content,
    ModelFieldValue<String?>? orientation,
    ModelFieldValue<String?>? contenttype,
    ModelFieldValue<RecordStatus>? status,
    ModelFieldValue<List<Comment>?>? comments,
    ModelFieldValue<List<LikeLink>?>? likes,
    ModelFieldValue<User?>? user,
    ModelFieldValue<amplify_core.TemporalDateTime?>? createdOn,
    ModelFieldValue<amplify_core.TemporalDateTime?>? updatedOn
  }) {
    return Post._internal(
      id: id,
      postId: postId == null ? this.postId : postId.value,
      description: description == null ? this.description : description.value,
      content: content == null ? this.content : content.value,
      orientation: orientation == null ? this.orientation : orientation.value,
      contenttype: contenttype == null ? this.contenttype : contenttype.value,
      status: status == null ? this.status : status.value,
      comments: comments == null ? this.comments : comments.value,
      likes: likes == null ? this.likes : likes.value,
      user: user == null ? this.user : user.value,
      createdOn: createdOn == null ? this.createdOn : createdOn.value,
      updatedOn: updatedOn == null ? this.updatedOn : updatedOn.value
    );
  }
  
  Post.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _postId = json['postId'],
      _description = json['description'],
      _content = json['content'],
      _orientation = json['orientation'],
      _contenttype = json['contenttype'],
      _status = amplify_core.enumFromString<RecordStatus>(json['status'], RecordStatus.values),
      _comments = json['comments'] is List
        ? (json['comments'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Comment.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _likes = json['likes'] is List
        ? (json['likes'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => LikeLink.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _user = json['user']?['serializedData'] != null
        ? User.fromJson(new Map<String, dynamic>.from(json['user']['serializedData']))
        : null,
      _createdOn = json['createdOn'] != null ? amplify_core.TemporalDateTime.fromString(json['createdOn']) : null,
      _updatedOn = json['updatedOn'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedOn']) : null,
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'postId': _postId, 'description': _description, 'content': _content, 'orientation': _orientation, 'contenttype': _contenttype, 'status': amplify_core.enumToString(_status), 'comments': _comments?.map((Comment? e) => e?.toJson()).toList(), 'likes': _likes?.map((LikeLink? e) => e?.toJson()).toList(), 'user': _user?.toJson(), 'createdOn': _createdOn?.format(), 'updatedOn': _updatedOn?.format(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'postId': _postId,
    'description': _description,
    'content': _content,
    'orientation': _orientation,
    'contenttype': _contenttype,
    'status': _status,
    'comments': _comments,
    'likes': _likes,
    'user': _user,
    'createdOn': _createdOn,
    'updatedOn': _updatedOn,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<PostModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<PostModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final POSTID = amplify_core.QueryField(fieldName: "postId");
  static final DESCRIPTION = amplify_core.QueryField(fieldName: "description");
  static final CONTENT = amplify_core.QueryField(fieldName: "content");
  static final ORIENTATION = amplify_core.QueryField(fieldName: "orientation");
  static final CONTENTTYPE = amplify_core.QueryField(fieldName: "contenttype");
  static final STATUS = amplify_core.QueryField(fieldName: "status");
  static final COMMENTS = amplify_core.QueryField(
    fieldName: "comments",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Comment'));
  static final LIKES = amplify_core.QueryField(
    fieldName: "likes",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'LikeLink'));
  static final USER = amplify_core.QueryField(
    fieldName: "user",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'User'));
  static final CREATEDON = amplify_core.QueryField(fieldName: "createdOn");
  static final UPDATEDON = amplify_core.QueryField(fieldName: "updatedOn");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Post";
    modelSchemaDefinition.pluralName = "Posts";
    
    modelSchemaDefinition.authRules = [
      amplify_core.AuthRule(
        authStrategy: amplify_core.AuthStrategy.PUBLIC,
        operations: const [
          amplify_core.ModelOperation.CREATE,
          amplify_core.ModelOperation.UPDATE,
          amplify_core.ModelOperation.DELETE,
          amplify_core.ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.indexes = [
      amplify_core.ModelIndex(fields: const ["id"], name: null),
      amplify_core.ModelIndex(fields: const ["postId"], name: "postsByPostId"),
      amplify_core.ModelIndex(fields: const ["description"], name: "postsByDescription"),
      amplify_core.ModelIndex(fields: const ["userId"], name: "byUserPost")
    ];
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Post.POSTID,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Post.DESCRIPTION,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Post.CONTENT,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Post.ORIENTATION,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Post.CONTENTTYPE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Post.STATUS,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.enumeration)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: Post.COMMENTS,
      isRequired: false,
      ofModelName: 'Comment',
      associatedKey: Comment.POST
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: Post.LIKES,
      isRequired: false,
      ofModelName: 'LikeLink',
      associatedKey: LikeLink.POST
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.belongsTo(
      key: Post.USER,
      isRequired: false,
      targetNames: ['userId'],
      ofModelName: 'User'
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

/**
 * This is an auto generated class representing the model identifier
 * of [Post] in your schema.
 */
class PostModelIdentifier implements amplify_core.ModelIdentifier<Post> {
  final String id;

  /** Create an instance of PostModelIdentifier using [id] the primary key. */
  const PostModelIdentifier({
    required this.id});
  
  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{
    'id': id
  });
  
  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
    .entries
    .map((entry) => (<String, dynamic>{ entry.key: entry.value }))
    .toList();
  
  @override
  String serializeAsString() => serializeAsMap().values.join('#');
  
  @override
  String toString() => 'PostModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is PostModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}