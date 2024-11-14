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

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, override_on_non_overriding_member, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart' as amplify_core;
import 'package:collection/collection.dart';


/** This is an auto generated class representing the Comment type in your schema. */
class Comment extends amplify_core.Model {
  static const classType = const _CommentModelType();
  final String id;
  final String? _commentId;
  final List<LikeLink>? _likes;
  final String? _content;
  final User? _user;
  final Post? _post;
  final amplify_core.TemporalDateTime? _createdOn;
  final amplify_core.TemporalDateTime? _updatedOn;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  CommentModelIdentifier get modelIdentifier {
      return CommentModelIdentifier(
        id: id
      );
  }
  
  String get commentId {
    try {
      return _commentId!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  List<LikeLink>? get likes {
    return _likes;
  }
  
  String get content {
    try {
      return _content!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  User? get user {
    return _user;
  }
  
  Post? get post {
    return _post;
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
  
  const Comment._internal({required this.id, required commentId, likes, required content, user, post, createdOn, updatedOn, createdAt, updatedAt}): _commentId = commentId, _likes = likes, _content = content, _user = user, _post = post, _createdOn = createdOn, _updatedOn = updatedOn, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Comment({String? id, required String commentId, List<LikeLink>? likes, required String content, User? user, Post? post, amplify_core.TemporalDateTime? createdOn, amplify_core.TemporalDateTime? updatedOn}) {
    return Comment._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      commentId: commentId,
      likes: likes != null ? List<LikeLink>.unmodifiable(likes) : likes,
      content: content,
      user: user,
      post: post,
      createdOn: createdOn,
      updatedOn: updatedOn);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Comment &&
      id == other.id &&
      _commentId == other._commentId &&
      DeepCollectionEquality().equals(_likes, other._likes) &&
      _content == other._content &&
      _user == other._user &&
      _post == other._post &&
      _createdOn == other._createdOn &&
      _updatedOn == other._updatedOn;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Comment {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("commentId=" + "$_commentId" + ", ");
    buffer.write("content=" + "$_content" + ", ");
    buffer.write("user=" + (_user != null ? _user!.toString() : "null") + ", ");
    buffer.write("post=" + (_post != null ? _post!.toString() : "null") + ", ");
    buffer.write("createdOn=" + (_createdOn != null ? _createdOn!.format() : "null") + ", ");
    buffer.write("updatedOn=" + (_updatedOn != null ? _updatedOn!.format() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Comment copyWith({String? commentId, List<LikeLink>? likes, String? content, User? user, Post? post, amplify_core.TemporalDateTime? createdOn, amplify_core.TemporalDateTime? updatedOn}) {
    return Comment._internal(
      id: id,
      commentId: commentId ?? this.commentId,
      likes: likes ?? this.likes,
      content: content ?? this.content,
      user: user ?? this.user,
      post: post ?? this.post,
      createdOn: createdOn ?? this.createdOn,
      updatedOn: updatedOn ?? this.updatedOn);
  }
  
  Comment copyWithModelFieldValues({
    ModelFieldValue<String>? commentId,
    ModelFieldValue<List<LikeLink>?>? likes,
    ModelFieldValue<String>? content,
    ModelFieldValue<User?>? user,
    ModelFieldValue<Post?>? post,
    ModelFieldValue<amplify_core.TemporalDateTime?>? createdOn,
    ModelFieldValue<amplify_core.TemporalDateTime?>? updatedOn
  }) {
    return Comment._internal(
      id: id,
      commentId: commentId == null ? this.commentId : commentId.value,
      likes: likes == null ? this.likes : likes.value,
      content: content == null ? this.content : content.value,
      user: user == null ? this.user : user.value,
      post: post == null ? this.post : post.value,
      createdOn: createdOn == null ? this.createdOn : createdOn.value,
      updatedOn: updatedOn == null ? this.updatedOn : updatedOn.value
    );
  }
  
  Comment.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _commentId = json['commentId'],
      _likes = json['likes']  is Map
        ? (json['likes']['items'] is List
          ? (json['likes']['items'] as List)
              .where((e) => e != null)
              .map((e) => LikeLink.fromJson(new Map<String, dynamic>.from(e)))
              .toList()
          : null)
        : (json['likes'] is List
          ? (json['likes'] as List)
              .where((e) => e?['serializedData'] != null)
              .map((e) => LikeLink.fromJson(new Map<String, dynamic>.from(e?['serializedData'])))
              .toList()
          : null),
      _content = json['content'],
      _user = json['user'] != null
        ? json['user']['serializedData'] != null
          ? User.fromJson(new Map<String, dynamic>.from(json['user']['serializedData']))
          : User.fromJson(new Map<String, dynamic>.from(json['user']))
        : null,
      _post = json['post'] != null
        ? json['post']['serializedData'] != null
          ? Post.fromJson(new Map<String, dynamic>.from(json['post']['serializedData']))
          : Post.fromJson(new Map<String, dynamic>.from(json['post']))
        : null,
      _createdOn = json['createdOn'] != null ? amplify_core.TemporalDateTime.fromString(json['createdOn']) : null,
      _updatedOn = json['updatedOn'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedOn']) : null,
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'commentId': _commentId, 'likes': _likes?.map((LikeLink? e) => e?.toJson()).toList(), 'content': _content, 'user': _user?.toJson(), 'post': _post?.toJson(), 'createdOn': _createdOn?.format(), 'updatedOn': _updatedOn?.format(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'commentId': _commentId,
    'likes': _likes,
    'content': _content,
    'user': _user,
    'post': _post,
    'createdOn': _createdOn,
    'updatedOn': _updatedOn,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<CommentModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<CommentModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final COMMENTID = amplify_core.QueryField(fieldName: "commentId");
  static final LIKES = amplify_core.QueryField(
    fieldName: "likes",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'LikeLink'));
  static final CONTENT = amplify_core.QueryField(fieldName: "content");
  static final USER = amplify_core.QueryField(
    fieldName: "user",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'User'));
  static final POST = amplify_core.QueryField(
    fieldName: "post",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Post'));
  static final CREATEDON = amplify_core.QueryField(fieldName: "createdOn");
  static final UPDATEDON = amplify_core.QueryField(fieldName: "updatedOn");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Comment";
    modelSchemaDefinition.pluralName = "Comments";
    
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
      amplify_core.ModelIndex(fields: const ["commentId"], name: "commentsByCommentId"),
      amplify_core.ModelIndex(fields: const ["userId"], name: "byUserComment"),
      amplify_core.ModelIndex(fields: const ["postId"], name: "byPost")
    ];
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Comment.COMMENTID,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: Comment.LIKES,
      isRequired: false,
      ofModelName: 'LikeLink',
      associatedKey: LikeLink.COMMENT
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Comment.CONTENT,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.belongsTo(
      key: Comment.USER,
      isRequired: false,
      targetNames: ['userId'],
      ofModelName: 'User'
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.belongsTo(
      key: Comment.POST,
      isRequired: false,
      targetNames: ['postId'],
      ofModelName: 'Post'
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Comment.CREATEDON,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Comment.UPDATEDON,
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

class _CommentModelType extends amplify_core.ModelType<Comment> {
  const _CommentModelType();
  
  @override
  Comment fromJson(Map<String, dynamic> jsonData) {
    return Comment.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Comment';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Comment] in your schema.
 */
class CommentModelIdentifier implements amplify_core.ModelIdentifier<Comment> {
  final String id;

  /** Create an instance of CommentModelIdentifier using [id] the primary key. */
  const CommentModelIdentifier({
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
  String toString() => 'CommentModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is CommentModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}