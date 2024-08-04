import 'package:book_library/screens/book_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/home_cubit.dart';
import '../logic/home_states.dart';

class FreeScreen extends StatelessWidget {
  const FreeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Free Books')),
      body: BlocProvider(
        create: (context)=>HomeCubit()..getFree(),
        child: SafeArea(
          child: BlocBuilder<HomeCubit,HomeState>(
            builder: (context,state){
              if(state is HomeLoading){
                return const Center(child: CircularProgressIndicator());
              }else if(state is HomeSuccess){
                return ListView.separated(
                    padding: EdgeInsets.all(10),
                    itemBuilder: (context,index){
                      var cubit = HomeCubit.get(context); // ---------------
                      // ----------------------------------------------------------------------------------------------
                      return InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>BookDetails(id: cubit.free_books[index].id!)));
                        },
                        child: Container(
                          child: Expanded(
                            child: Column(
                              children: [
                                Image.network(cubit.free_books[index].image!,height: 250, fit: BoxFit.cover,),
                                const SizedBox(height: 10),
                                Text(cubit.free_books[index].name!),
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
                      return SizedBox(
                        height: 25,
                      );
                    },
                    itemCount: HomeCubit.get(context).free_books.length
                );
              }else {
                return Text('no data');
              }
            },
          ),
        ),
      ),
    );
  }
}
