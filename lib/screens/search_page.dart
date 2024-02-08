import 'package:Makulay/models/CustomGraphQL.dart';
import 'package:Makulay/models/User.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchPage extends StatefulWidget {
  final String username;
  const SearchPage(this.username, {Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = false;
  List<String> searchResult = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_performSearch);
    
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _performSearch() async {
    setState(() {
      _isLoading = true;
    });
    List<String> usernames = [];
    var usersData = await searchByUsername(_searchController.text);
      PaginatedResult<User>? gatheredUsers = usersData.data;
      //String? gatheredUsers = usersData.data?.items.toString().replaceAll("\n","");
      for (var eachPosts in gatheredUsers!.items) {
        debugPrint('eachPosts :' + eachPosts.toString());
        debugPrint('eachPosts username :' + eachPosts!.username);
        String dataUsername = eachPosts.username;
        usernames.add(dataUsername);
      }

    //Simulates waiting for an API call
    await Future.delayed(const Duration(milliseconds: 1000));

    setState(() {
      searchResult = usernames;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.transparent,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              //statusBarColor: Colors.black,
              statusBarIconBrightness:
                  Brightness.dark, // For Android (dark icons)
              statusBarBrightness: Brightness.light),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () => Navigator.pop(context, true),
              child: Icon(Icons.arrow_back_ios),
            ),
          ),
          title: TextField(
          controller: _searchController,
          style: const TextStyle(color: Colors.black),
          cursorColor: Colors.amber,
          decoration: const InputDecoration(
            hintText: 'Search...',
            hintStyle: TextStyle(color: Colors.black),
            border: InputBorder.none,
          ),
          onChanged: (value) {
            // Perform search functionality here
          },
        ),
      
        ),
      body: 
      //Center(child: Text('Search'),)
      _isLoading
            ? const Center(
                child: CircularProgressIndicator(color: Colors.white),
              )
            : ListView.builder(
                itemCount: searchResult.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(
                    searchResult[index],
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
    );
  }
}
