import 'package:book_library/screens/book_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/home_cubit.dart';
import '../logic/home_states.dart';

class ScienceScreen extends StatelessWidget {
  const ScienceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Science Books',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ))),
      body: BlocProvider(
        create: (context)=>HomeCubit()..getScience(),
        child: SafeArea(
          child: BlocBuilder<HomeCubit,HomeState>(
            builder: (context,state){
              if(state is HomeLoading){
                return const Center(child: CircularProgressIndicator());
              }else if(state is HomeSuccess){
                return ListView.separated(
                    padding: const EdgeInsets.all(10),
                    itemBuilder: (context,index){
                      var cubit = HomeCubit.get(context); // ---------------
                      // ----------------------------------------------------------------------------------------------
                      return InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>BookDetails(id: cubit.science_books[index].id!)));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blueGrey[200],
                            borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                          child: Expanded(
                            child: Column(
                              children: [
                                Image.network(cubit.science_books[index].image!,height: 250,fit: BoxFit.cover,),
                                const SizedBox(height: 10),
                                Text(
                                    cubit.science_books[index].name!,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    )
                                ),
                                const SizedBox(
                                  height: 5,
                                )
                                // (cubit.science_books[index].author!=null)?
                                // Text('Author: ${cubit.science_books[index].author![0]}'):Text(''),
                                // Text('Description: ${cubit.science_books[index].description!}'),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context,index){
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: HomeCubit.get(context).science_books.length
                );
              }else {
                return const Text('no data');
              }
            },
          ),
        ),
      ),
    );
  }
}
