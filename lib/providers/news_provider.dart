import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NewsViewModel with ChangeNotifier {
  NewsViewModel() {
    updateGreeting();
    fetchNews();
  }

  String _greeting = '';
  String get greeting => _greeting;

  void updateGreeting() {
    final now = DateTime.now();
    final hour = now.hour;

    if (hour >= 5 && hour < 12) {
      _greeting = 'Good morning';
    } else if (hour >= 12 && hour < 17) {
      _greeting = 'Good afternoon';
    } else if (hour >= 17 && hour < 22) {
      _greeting = 'Good evening';
    } else {
      _greeting = 'Good night';
    }
  }

  final String newsApiUrl =
      'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=';
  final String apiKey = 'cb0b1558eb764f6bb6dfdf9eb815ef7c';

  List articles = [];
  List get article => articles;

  Future<dynamic> fetchNews() async {
    try {
      final response = await http.get(Uri.parse(newsApiUrl + apiKey));
      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        articles = json['articles'];
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      throw Exception("Failed to load data");
    }
    notifyListeners();
  }
}
