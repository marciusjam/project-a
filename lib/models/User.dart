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


/** This is an auto generated class representing the User type in your schema. */
class User extends amplify_core.Model {
  static const classType = const _UserModelType();
  final String id;
  final String? _userId;
  final String? _username;
  final String? _email;
  final String? _phoneNumber;
  final String? _bio;
  final String? _profilePicture;
  final String? _backgroundContent;
  final List<FollowLink>? _followers;
  final List<FollowLink>? _following;
  final List<Post>? _posts;
  final List<Comment>? _comments;
  final List<LikeLink>? _likes;
  final List<UsersGroups>? _groups;
  final List<Message>? _messages;
  final amplify_core.TemporalDateTime? _createdOn;
  final amplify_core.TemporalDateTime? _updatedOn;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  UserModelIdentifier get modelIdentifier {
      return UserModelIdentifier(
        id: id
      );
  }
  
  String get userId {
    try {
      return _userId!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get username {
    try {
      return _username!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get email {
    return _email;
  }
  
  String? get phoneNumber {
    return _phoneNumber;
  }
  
  String? get bio {
    return _bio;
  }
  
  String? get profilePicture {
    return _profilePicture;
  }
  
  String? get backgroundContent {
    return _backgroundContent;
  }
  
  List<FollowLink>? get followers {
    return _followers;
  }
  
  List<FollowLink>? get following {
    return _following;
  }
  
  List<Post>? get posts {
    return _posts;
  }
  
  List<Comment>? get comments {
    return _comments;
  }
  
  List<LikeLink>? get likes {
    return _likes;
  }
  
  List<UsersGroups>? get groups {
    return _groups;
  }
  
  List<Message>? get messages {
    return _messages;
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
  
  const User._internal({required this.id, required userId, required username, email, phoneNumber, bio, profilePicture, backgroundContent, followers, following, posts, comments, likes, groups, messages, createdOn, updatedOn, createdAt, updatedAt}): _userId = userId, _username = username, _email = email, _phoneNumber = phoneNumber, _bio = bio, _profilePicture = profilePicture, _backgroundContent = backgroundContent, _followers = followers, _following = following, _posts = posts, _comments = comments, _likes = likes, _groups = groups, _messages = messages, _createdOn = createdOn, _updatedOn = updatedOn, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory User({String? id, required String userId, required String username, String? email, String? phoneNumber, String? bio, String? profilePicture, String? backgroundContent, List<FollowLink>? followers, List<FollowLink>? following, List<Post>? posts, List<Comment>? comments, List<LikeLink>? likes, List<UsersGroups>? groups, List<Message>? messages, amplify_core.TemporalDateTime? createdOn, amplify_core.TemporalDateTime? updatedOn}) {
    return User._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      userId: userId,
      username: username,
      email: email,
      phoneNumber: phoneNumber,
      bio: bio,
      profilePicture: profilePicture,
      backgroundContent: backgroundContent,
      followers: followers != null ? List<FollowLink>.unmodifiable(followers) : followers,
      following: following != null ? List<FollowLink>.unmodifiable(following) : following,
      posts: posts != null ? List<Post>.unmodifiable(posts) : posts,
      comments: comments != null ? List<Comment>.unmodifiable(comments) : comments,
      likes: likes != null ? List<LikeLink>.unmodifiable(likes) : likes,
      groups: groups != null ? List<UsersGroups>.unmodifiable(groups) : groups,
      messages: messages != null ? List<Message>.unmodifiable(messages) : messages,
      createdOn: createdOn,
      updatedOn: updatedOn);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is User &&
      id == other.id &&
      _userId == other._userId &&
      _username == other._username &&
      _email == other._email &&
      _phoneNumber == other._phoneNumber &&
      _bio == other._bio &&
      _profilePicture == other._profilePicture &&
      _backgroundContent == other._backgroundContent &&
      DeepCollectionEquality().equals(_followers, other._followers) &&
      DeepCollectionEquality().equals(_following, other._following) &&
      DeepCollectionEquality().equals(_posts, other._posts) &&
      DeepCollectionEquality().equals(_comments, other._comments) &&
      DeepCollectionEquality().equals(_likes, other._likes) &&
      DeepCollectionEquality().equals(_groups, other._groups) &&
      DeepCollectionEquality().equals(_messages, other._messages) &&
      _createdOn == other._createdOn &&
      _updatedOn == other._updatedOn;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("User {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("userId=" + "$_userId" + ", ");
    buffer.write("username=" + "$_username" + ", ");
    buffer.write("email=" + "$_email" + ", ");
    buffer.write("phoneNumber=" + "$_phoneNumber" + ", ");
    buffer.write("bio=" + "$_bio" + ", ");
    buffer.write("profilePicture=" + "$_profilePicture" + ", ");
    buffer.write("backgroundContent=" + "$_backgroundContent" + ", ");
    buffer.write("createdOn=" + (_createdOn != null ? _createdOn!.format() : "null") + ", ");
    buffer.write("updatedOn=" + (_updatedOn != null ? _updatedOn!.format() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  User copyWith({String? userId, String? username, String? email, String? phoneNumber, String? bio, String? profilePicture, String? backgroundContent, List<FollowLink>? followers, List<FollowLink>? following, List<Post>? posts, List<Comment>? comments, List<LikeLink>? likes, List<UsersGroups>? groups, List<Message>? messages, amplify_core.TemporalDateTime? createdOn, amplify_core.TemporalDateTime? updatedOn}) {
    return User._internal(
      id: id,
      userId: userId ?? this.userId,
      username: username ?? this.username,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      bio: bio ?? this.bio,
      profilePicture: profilePicture ?? this.profilePicture,
      backgroundContent: backgroundContent ?? this.backgroundContent,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      posts: posts ?? this.posts,
      comments: comments ?? this.comments,
      likes: likes ?? this.likes,
      groups: groups ?? this.groups,
      messages: messages ?? this.messages,
      createdOn: createdOn ?? this.createdOn,
      updatedOn: updatedOn ?? this.updatedOn);
  }
  
  User copyWithModelFieldValues({
    ModelFieldValue<String>? userId,
    ModelFieldValue<String>? username,
    ModelFieldValue<String?>? email,
    ModelFieldValue<String?>? phoneNumber,
    ModelFieldValue<String?>? bio,
    ModelFieldValue<String?>? profilePicture,
    ModelFieldValue<String?>? backgroundContent,
    ModelFieldValue<List<FollowLink>?>? followers,
    ModelFieldValue<List<FollowLink>?>? following,
    ModelFieldValue<List<Post>?>? posts,
    ModelFieldValue<List<Comment>?>? comments,
    ModelFieldValue<List<LikeLink>?>? likes,
    ModelFieldValue<List<UsersGroups>?>? groups,
    ModelFieldValue<List<Message>?>? messages,
    ModelFieldValue<amplify_core.TemporalDateTime?>? createdOn,
    ModelFieldValue<amplify_core.TemporalDateTime?>? updatedOn
  }) {
    return User._internal(
      id: id,
      userId: userId == null ? this.userId : userId.value,
      username: username == null ? this.username : username.value,
      email: email == null ? this.email : email.value,
      phoneNumber: phoneNumber == null ? this.phoneNumber : phoneNumber.value,
      bio: bio == null ? this.bio : bio.value,
      profilePicture: profilePicture == null ? this.profilePicture : profilePicture.value,
      backgroundContent: backgroundContent == null ? this.backgroundContent : backgroundContent.value,
      followers: followers == null ? this.followers : followers.value,
      following: following == null ? this.following : following.value,
      posts: posts == null ? this.posts : posts.value,
      comments: comments == null ? this.comments : comments.value,
      likes: likes == null ? this.likes : likes.value,
      groups: groups == null ? this.groups : groups.value,
      messages: messages == null ? this.messages : messages.value,
      createdOn: createdOn == null ? this.createdOn : createdOn.value,
      updatedOn: updatedOn == null ? this.updatedOn : updatedOn.value
    );
  }
  
  User.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _userId = json['userId'],
      _username = json['username'],
      _email = json['email'],
      _phoneNumber = json['phoneNumber'],
      _bio = json['bio'],
      _profilePicture = json['profilePicture'],
      _backgroundContent = json['backgroundContent'],
      _followers = json['followers']  is Map
        ? (json['followers']['items'] is List
          ? (json['followers']['items'] as List)
              .where((e) => e != null)
              .map((e) => FollowLink.fromJson(new Map<String, dynamic>.from(e)))
              .toList()
          : null)
        : (json['followers'] is List
          ? (json['followers'] as List)
              .where((e) => e?['serializedData'] != null)
              .map((e) => FollowLink.fromJson(new Map<String, dynamic>.from(e?['serializedData'])))
              .toList()
          : null),
      _following = json['following']  is Map
        ? (json['following']['items'] is List
          ? (json['following']['items'] as List)
              .where((e) => e != null)
              .map((e) => FollowLink.fromJson(new Map<String, dynamic>.from(e)))
              .toList()
          : null)
        : (json['following'] is List
          ? (json['following'] as List)
              .where((e) => e?['serializedData'] != null)
              .map((e) => FollowLink.fromJson(new Map<String, dynamic>.from(e?['serializedData'])))
              .toList()
          : null),
      _posts = json['posts']  is Map
        ? (json['posts']['items'] is List
          ? (json['posts']['items'] as List)
              .where((e) => e != null)
              .map((e) => Post.fromJson(new Map<String, dynamic>.from(e)))
              .toList()
          : null)
        : (json['posts'] is List
          ? (json['posts'] as List)
              .where((e) => e?['serializedData'] != null)
              .map((e) => Post.fromJson(new Map<String, dynamic>.from(e?['serializedData'])))
              .toList()
          : null),
      _comments = json['comments']  is Map
        ? (json['comments']['items'] is List
          ? (json['comments']['items'] as List)
              .where((e) => e != null)
              .map((e) => Comment.fromJson(new Map<String, dynamic>.from(e)))
              .toList()
          : null)
        : (json['comments'] is List
          ? (json['comments'] as List)
              .where((e) => e?['serializedData'] != null)
              .map((e) => Comment.fromJson(new Map<String, dynamic>.from(e?['serializedData'])))
              .toList()
          : null),
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
      _groups = json['groups']  is Map
        ? (json['groups']['items'] is List
          ? (json['groups']['items'] as List)
              .where((e) => e != null)
              .map((e) => UsersGroups.fromJson(new Map<String, dynamic>.from(e)))
              .toList()
          : null)
        : (json['groups'] is List
          ? (json['groups'] as List)
              .where((e) => e?['serializedData'] != null)
              .map((e) => UsersGroups.fromJson(new Map<String, dynamic>.from(e?['serializedData'])))
              .toList()
          : null),
      _messages = json['messages']  is Map
        ? (json['messages']['items'] is List
          ? (json['messages']['items'] as List)
              .where((e) => e != null)
              .map((e) => Message.fromJson(new Map<String, dynamic>.from(e)))
              .toList()
          : null)
        : (json['messages'] is List
          ? (json['messages'] as List)
              .where((e) => e?['serializedData'] != null)
              .map((e) => Message.fromJson(new Map<String, dynamic>.from(e?['serializedData'])))
              .toList()
          : null),
      _createdOn = json['createdOn'] != null ? amplify_core.TemporalDateTime.fromString(json['createdOn']) : null,
      _updatedOn = json['updatedOn'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedOn']) : null,
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'userId': _userId, 'username': _username, 'email': _email, 'phoneNumber': _phoneNumber, 'bio': _bio, 'profilePicture': _profilePicture, 'backgroundContent': _backgroundContent, 'followers': _followers?.map((FollowLink? e) => e?.toJson()).toList(), 'following': _following?.map((FollowLink? e) => e?.toJson()).toList(), 'posts': _posts?.map((Post? e) => e?.toJson()).toList(), 'comments': _comments?.map((Comment? e) => e?.toJson()).toList(), 'likes': _likes?.map((LikeLink? e) => e?.toJson()).toList(), 'groups': _groups?.map((UsersGroups? e) => e?.toJson()).toList(), 'messages': _messages?.map((Message? e) => e?.toJson()).toList(), 'createdOn': _createdOn?.format(), 'updatedOn': _updatedOn?.format(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'userId': _userId,
    'username': _username,
    'email': _email,
    'phoneNumber': _phoneNumber,
    'bio': _bio,
    'profilePicture': _profilePicture,
    'backgroundContent': _backgroundContent,
    'followers': _followers,
    'following': _following,
    'posts': _posts,
    'comments': _comments,
    'likes': _likes,
    'groups': _groups,
    'messages': _messages,
    'createdOn': _createdOn,
    'updatedOn': _updatedOn,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<UserModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<UserModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final USERID = amplify_core.QueryField(fieldName: "userId");
  static final USERNAME = amplify_core.QueryField(fieldName: "username");
  static final EMAIL = amplify_core.QueryField(fieldName: "email");
  static final PHONENUMBER = amplify_core.QueryField(fieldName: "phoneNumber");
  static final BIO = amplify_core.QueryField(fieldName: "bio");
  static final PROFILEPICTURE = amplify_core.QueryField(fieldName: "profilePicture");
  static final BACKGROUNDCONTENT = amplify_core.QueryField(fieldName: "backgroundContent");
  static final FOLLOWERS = amplify_core.QueryField(
    fieldName: "followers",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'FollowLink'));
  static final FOLLOWING = amplify_core.QueryField(
    fieldName: "following",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'FollowLink'));
  static final POSTS = amplify_core.QueryField(
    fieldName: "posts",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Post'));
  static final COMMENTS = amplify_core.QueryField(
    fieldName: "comments",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Comment'));
  static final LIKES = amplify_core.QueryField(
    fieldName: "likes",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'LikeLink'));
  static final GROUPS = amplify_core.QueryField(
    fieldName: "groups",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'UsersGroups'));
  static final MESSAGES = amplify_core.QueryField(
    fieldName: "messages",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Message'));
  static final CREATEDON = amplify_core.QueryField(fieldName: "createdOn");
  static final UPDATEDON = amplify_core.QueryField(fieldName: "updatedOn");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "User";
    modelSchemaDefinition.pluralName = "Users";
    
    modelSchemaDefinition.authRules = [
      amplify_core.AuthRule(
        authStrategy: amplify_core.AuthStrategy.PRIVATE,
        operations: const [
          amplify_core.ModelOperation.CREATE,
          amplify_core.ModelOperation.UPDATE,
          amplify_core.ModelOperation.DELETE,
          amplify_core.ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.indexes = [
      amplify_core.ModelIndex(fields: const ["id"], name: null),
      amplify_core.ModelIndex(fields: const ["userId"], name: "usersByUserId"),
      amplify_core.ModelIndex(fields: const ["username"], name: "usersByUsername")
    ];
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: User.USERID,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: User.USERNAME,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: User.EMAIL,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: User.PHONENUMBER,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: User.BIO,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: User.PROFILEPICTURE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: User.BACKGROUNDCONTENT,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: User.FOLLOWERS,
      isRequired: false,
      ofModelName: 'FollowLink',
      associatedKey: FollowLink.FOLLOWER
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: User.FOLLOWING,
      isRequired: false,
      ofModelName: 'FollowLink',
      associatedKey: FollowLink.FOLLOWING
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: User.POSTS,
      isRequired: false,
      ofModelName: 'Post',
      associatedKey: Post.USER
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: User.COMMENTS,
      isRequired: false,
      ofModelName: 'Comment',
      associatedKey: Comment.USER
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: User.LIKES,
      isRequired: false,
      ofModelName: 'LikeLink',
      associatedKey: LikeLink.USER
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: User.GROUPS,
      isRequired: false,
      ofModelName: 'UsersGroups',
      associatedKey: UsersGroups.USER
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: User.MESSAGES,
      isRequired: false,
      ofModelName: 'Message',
      associatedKey: Message.SENDER
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: User.CREATEDON,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: User.UPDATEDON,
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

class _UserModelType extends amplify_core.ModelType<User> {
  const _UserModelType();
  
  @override
  User fromJson(Map<String, dynamic> jsonData) {
    return User.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'User';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [User] in your schema.
 */
class UserModelIdentifier implements amplify_core.ModelIdentifier<User> {
  final String id;

  /** Create an instance of UserModelIdentifier using [id] the primary key. */
  const UserModelIdentifier({
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
  String toString() => 'UserModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is UserModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}