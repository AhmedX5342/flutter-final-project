import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/home_cubit.dart';
import '../logic/home_states.dart';

import 'package:url_launcher/url_launcher.dart';

class BookDetails extends StatelessWidget {
  const BookDetails({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getBook(id),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(title: const Text('Book Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ))),
          body: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              var cubit = HomeCubit.get(context); // ---------------
              if (state is HomeLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is HomeSuccess) {
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ---------------------------------- Image
                          Center(
                            child: (cubit.Book['image'] != null)
                                ? Image.network(
                                    cubit.Book['image']!, // Replace with your image URL
                                    height: 500.0, // Adjust height as needed
                                    fit: BoxFit.cover,
                                  )
                                : Text(''),
                          ),
                          SizedBox(height: 16.0),
                  
                          // ----------------------------- title
                          Text(
                            'Title: ${cubit.Book['title']!}',
                            style: const TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                  
                          // --------------------------- author (1)
                          (cubit.Book['author']! != null)
                              ? Text(
                                  'Author: ${cubit.Book['author']!}',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.grey[600],
                                  ),
                                )
                              : const Text(''),
                          const SizedBox(height: 8.0),
                  
                          // --------------------------------------------- Language
                          Text(
                            'Language: ${cubit.Book['language']!}',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 16.0),
                  
                          // ------------------------------------------- Description
                          (cubit.Book['description']! != null)
                              ? Text(
                            cubit.Book['description']!,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                  ),
                                )
                              : Text(''),
                          SizedBox(height: 16.0),
                  
                          // ----------------------------------------- Preview link
                          (cubit.Book['previewLink']! != null)
                              ? GestureDetector(
                                  onTap: () {
                                    // Handle preview link tap
                                    Uri url = Uri.parse(cubit.Book['previewLink']!);
                                    launchUrl(url);
                                  },
                                  child: const Text(
                                    'Preview here',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                )
                              : Text(''),
                          SizedBox(height: 8.0),
                  
                          // ----------------------------------- Buy link
                          (cubit.Book['buyLink']! != null)
                              ? GestureDetector(
                                  onTap: () {
                                    // Handle preview link tap
                                    Uri url = Uri.parse(cubit.Book['buyLink']!);
                                    launchUrl(url);
                                  },
                                  child: const Text(
                                    'Buy here',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                )
                              : Text(''),
                        ],
                      )),
                );
              } else {
                return Text(cubit.Book['title']!);
              }
            },
          ),
        ),
      ),
    );
  }
}
