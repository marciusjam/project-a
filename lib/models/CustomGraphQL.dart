

  import 'package:Makulay/models/Post.dart';
import 'package:Makulay/models/User.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';


Future<GraphQLResponse<Post>> getPostByPostId(String id) async {
    
    final getPostRequest = GraphQLRequest<Post>(
    document: '''query GetPost(\$id: ID!) {
    getPost(id: \$id) {
      id
      description
    }
  }''',
    modelType: Post.classType,
    variables: <String, String>{'id': id},
    decodePath: 'getPost',
  );
    
    final response = await Amplify.API.query(request: getPostRequest).response;
    safePrint('getPostRequest Response: $response');
    return response;
    
  }

Future<String> getAllPosts() async {
    
    final getPostRequest = GraphQLRequest<PaginatedResult<Post>>(
    document: '''query GetAllPosts {
  listPosts {
    items {
      content
      description
      contenttype
      createdAt
      id
      likes
      orientation
      status
      updatedAt
    }
  }
}''',
    modelType: const PaginatedModelType(Post.classType),
    decodePath: 'listPosts',
  );
    
    final response = await Amplify.API.query(request: getPostRequest).response;
    safePrint('getPostRequest Response: $response');
    return response.toString();
    
  }

Future<String?> getUserByUserId(String userId) async {
    safePrint('getUserByUserId userId: $userId');

    final getUserRequest = GraphQLRequest<User>(
    document: '''query GetUsersByUserId(\$userId: ID!) {
  usersByUserId(userId: \$userId) {
    items {
      id,
      userId,
      username,
      email
    }
  }
}''',
    modelType: const PaginatedModelType(User.classType),
    variables: <String, dynamic>{'userId': userId},
    decodePath: 'usersByUserId',
  );
    
    final response = await Amplify.API.query(request: getUserRequest).response;
    safePrint('getUserRequest Response: $response');
    return response.toString() ?? 'null';
    
  }



Future<GraphQLResponse<User>> getUserById(String id) async {
    safePrint('getUserByUserId id: $id');

    final getUserRequest = GraphQLRequest<User>(
    document: '''query GetUsersById(\$id: ID!) {
  getUser(id: \$id) {
      id,
      userId,
      username,
      email,
      profilePicture
  }
}''',
    modelType: User.classType,
    variables: <String, dynamic>{'id': id},
    decodePath: 'getUser',
  );
    
    final response = await Amplify.API.query(request: getUserRequest).response;
    safePrint('getUserRequest Response: $response');
    return response;
    
  }


Future<GraphQLResponse<dynamic>> getPostsByUserId(String userId) async {
    safePrint('getPostsByUserId userId: $userId');

    final getPostRequest = GraphQLRequest(
    document: '''query GetPostsByUserId(\$userId: ID!) {
  postsByUserId(userId: \$userId) {
    items {
      userId
      content
      contenttype
      description
      id
      postId
      orientation
      createdAt
    }
  }
}''',
    modelType: const PaginatedModelType(Post.classType),
    variables: <String, dynamic>{'userId': userId},
    decodePath: 'postsByUserId',
  );
    
    final response = await Amplify.API.query(request: getPostRequest).response;
    safePrint('GetPostsByUserId Response: $response');
    return response;
    
  }


Future<GraphQLResponse<dynamic>> getUsersByUsername(String username) async {
    safePrint('getUsersByUsername username: $username');

    final getUsersRequest = GraphQLRequest(
    document: '''query GetUsersByUsername(\$username: String!) {
  usersByUsername(username: \$username) {
    items {
      profilePicture
      username
      userId
      id
    }
  }
}''',
    modelType: const PaginatedModelType(User.classType),
    variables: <String, dynamic>{'username': username},
    decodePath: 'usersByUsername',
  );
    
    final response = await Amplify.API.query(request: getUsersRequest).response;
    safePrint('GetUsersByUsername Response: $response');
    return response;
    
  }

  Future<GraphQLResponse<dynamic>> searchByUsername(String username) async {
    safePrint('searchByUsername username: $username');

    final searchUsersRequest = GraphQLRequest(
    document: '''query searchUsersByUsername(\$username: String!) {
  searchUsers(filter: {username: {matchPhrasePrefix: \$username}}) {
    items {
      id
      userId
      username
      profilePicture
    }
  }
}''',
    modelType: const PaginatedModelType(User.classType),
    variables: <String, dynamic>{'username': username},
    decodePath: 'searchUsers',
  );
    
    final response = await Amplify.API.query(request: searchUsersRequest).response;
    safePrint('searchByUsername Response: $response');
    return response;
    
  }

  Future<GraphQLResponse<dynamic>> searchPostsByUserId(String userId) async {
    safePrint('searchPostsByUserId userId: $userId');

    final searchPostsRequest = GraphQLRequest(
    document: '''query searchUsersByUsername(\$userId: ID!) {
  searchPosts(
    sort: {direction: desc, field: createdAt}
    filter: {userId: {eq: \$userId}}
  ) {
    items {
      id
      userId
      postId
      status
      contenttype
      description
      orientation
      content
      user {
        id
        userId
        profilePicture
        username
      }
      createdAt
    }
  }
}''',
    modelType: const PaginatedModelType(Post.classType),
    variables: <String, dynamic>{'userId': userId},
    decodePath: 'searchPosts',
  );
    
    final response = await Amplify.API.query(request: searchPostsRequest).response;
    //safePrint('searchPostsByUserId Response: $response');
    return response;
    
  }

  Future<GraphQLResponse<dynamic>> searchPostSortByDate() async {
    safePrint('searchPostSortByDate ');

    final searchPostsRequest = GraphQLRequest(
    document: '''query MyQuery {
  searchPosts(sort: {direction: desc, field: createdAt}) {
    items {
      id
      userId
      postId
      status
      contenttype
      description
      orientation
      content
      createdAt
      _version
      user {
        id
        profilePicture
        username
      }
    }
    total
  }
}
''',
    modelType: const PaginatedModelType(Post.classType),
    decodePath: 'searchPosts',
  );
    
    final response = await Amplify.API.query(request: searchPostsRequest).response;
    //safePrint('searchPostSortByDate Response: $response');
    return response;
    
  }

  Future<GraphQLResponse<dynamic>> listPostsByUserId() async {
    safePrint('listPostsByUserId ');

    final listPostsRequest = GraphQLRequest(
    document: '''query MyQuery {
  listPosts(filter: {userId: {contains: "4d2ffe48-8376-4d35-b061-1e6c68cb598e"}}) {
    items {
      id
      userId
      postId
      status
      contenttype
      description
      orientation
      content
      createdAt
      _version
      user {
        id
        profilePicture
        username
      }
    }
  }
}
''',
    modelType: const PaginatedModelType(Post.classType),
    decodePath: 'listPosts',
  );
    
    final response = await Amplify.API.query(request: listPostsRequest).response;
    //safePrint('searchPostSortByDate Response: $response');
    return response;
    
  }

  Future<GraphQLResponse<dynamic>> descendingByUserId() async {
    safePrint('descendingByUser ');

    final sortPostsRequest = GraphQLRequest(
    document: '''query MyQuery {
  byUserPost(userId: "4d2ffe48-8376-4d35-b061-1e6c68cb598e", sortDirection: DESC) {
    items {
      id
      userId
      postId
      status
      contenttype
      description
      orientation
      content
      createdAt
      _version
      user {
        id
        profilePicture
        username
      }
    }
  }
}
''',
    modelType: const PaginatedModelType(Post.classType),
    decodePath: 'byUserPost',
  );
    
    final response = await Amplify.API.query(request: sortPostsRequest).response;
    //safePrint('searchPostSortByDate Response: $response');
    return response;
    
  }


  


  Stream<GraphQLResponse<User>> subscribeToUser() {
  final subscriptionRequest = ModelSubscriptions.onCreate(User.classType);
  final Stream<GraphQLResponse<User>> operation = Amplify.API
      .subscribe(
        subscriptionRequest,
        onEstablished: () => safePrint('Subscription established'),
      )
      // Listens to only 5 elements
      .take(5)
      .handleError(
    (Object error) {
      safePrint('Error in subscription stream: $error');
    },
  );
  return operation;
}