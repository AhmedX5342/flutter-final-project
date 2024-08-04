import 'dart:convert';
import 'package:book_library/data/book_model.dart';
import 'package:http/http.dart' as http;
import 'package:book_library/logic/home_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState>{
  HomeCubit(): super(HomeInitial());
  static HomeCubit get(context)=>BlocProvider.of(context);

  // -------- get science
  List<BookModel> science_books = [];
  Future<void> getScience() async{
    emit(HomeLoading());
    var url = Uri.parse("https://www.googleapis.com/books/v1/volumes?q=science&key=AIzaSyDnxCIqV3FAFD5QwUMNngHNUYCzsQSreCE");

    try{
      final response = await http.get(url);

      var data = json.decode(response.body);
      if(response.statusCode==200){
        print('===============================================success ${data}');
        for (var element in data['items']) {
          science_books.add(BookModel.fromJson(element));
        }
        emit(HomeSuccess());
      }else{
        print('failed ${data}');
        emit(HomeError());
      }
    }
    catch(error){
      print(error);
    }
  }

  // -------- get business
  List<BookModel> business_books = [];
  Future<void> getBusiness() async{
    emit(HomeLoading());
    var url = Uri.parse("https://www.googleapis.com/books/v1/volumes?q=Business&key=AIzaSyDnxCIqV3FAFD5QwUMNngHNUYCzsQSreCE");

    try{
      final response = await http.get(url);

      var data = json.decode(response.body);
      if(response.statusCode==200){
        print('success ${data}');
        for (var element in data['items']) {
          business_books.add(BookModel.fromJson(element));
        }
        emit(HomeSuccess());
      }else{
        print('failed ${data}');
        emit(HomeError());
      }

    }
    catch(error){
      print(error);
    }
  }

  // -------- get programming
  List<BookModel> programming_books = [];
  Future<void> getProgramming() async{
    emit(HomeLoading());
    var url = Uri.parse("https://www.googleapis.com/books/v1/volumes?q=programming&key=AIzaSyDnxCIqV3FAFD5QwUMNngHNUYCzsQSreCE");

    try{
      final response = await http.get(url);

      var data = json.decode(response.body);
      if(response.statusCode==200){
        print('success ${data}');
        for (var element in data['items']) {
          programming_books.add(BookModel.fromJson(element));
        }
        emit(HomeSuccess());
      }else{
        print('failed ${data}');
        emit(HomeError());
      }
    }
    catch(error){
      print(error);
    }
  }

  // -------- get free books
  List<BookModel> free_books = [];
  Future<void> getFree() async{
    emit(HomeLoading());
    var url = Uri.parse("https://www.googleapis.com/books/v1/volumes?q=all?filter=free-ebooks&key=AIzaSyDnxCIqV3FAFD5QwUMNngHNUYCzsQSreCE");

    try{
      final response = await http.get(url);

      var data = json.decode(response.body);
      if(response.statusCode==200){
        print('success ${data}');
        for (var element in data['items']) {
          free_books.add(BookModel.fromJson(element));
        }
        emit(HomeSuccess());
      }else{
        print('failed ${data}');
        emit(HomeError());
      }
    }
    catch(error){
      print(error);
    }
  }

  // --------- get specific book
  var Book = {
    'title':'',
    'author':'',
    'description':'',
    'image':'',
    'language':'',
    'buyLink':'',
    'previewLink':'',
  };

  Future<void> getBook(String id) async{
    emit(HomeLoading());
    var url = Uri.parse("https://www.googleapis.com/books/v1/volumes/$id");

    try{
      final response = await http.get(url);

      var data = json.decode(response.body);
      if(response.statusCode==200){
        Book['title'] = data['volumeInfo']['title'];

        if(data['volumeInfo']['authors']!=null){
          Book['author'] = data['volumeInfo']['authors'][0];
        }

        if(data['volumeInfo']['imageLinks']['thumbnail']!=null){
          Book['image'] = data['volumeInfo']['imageLinks']['thumbnail'];
        }

        if(data['volumeInfo']['description']!=null){
          Book['description'] = data['volumeInfo']['description'];
        }
        if(data['volumeInfo']['language']!=null){
          Book['language'] = data['volumeInfo']['language'];
        }

        if(data['volumeInfo']['previewLink']!=null){
          Book['previewLink'] = data['volumeInfo']['previewLink'];
        }

        if(data['saleInfo']['buyLink']!=null){
          Book['buyLink'] = data['saleInfo']['buyLink'];
        }

        print('success book ========================================================= ${Book['image']}'); // this works
        emit(HomeSuccess());
      }else{
        print('failed ${data}');
        emit(HomeError());
      }
    }
    catch(error){
      print(error);
    }
  }
}