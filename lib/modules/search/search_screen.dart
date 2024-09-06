import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/components.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var searchController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          SearchCubit cubit = SearchCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultFormField(
                      textInputAction: TextInputAction.search,
                      controller: searchController,
                      textInputType: TextInputType.text,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Enter text to search';
                        }
                        return null;
                      },
                      onSubmit: (String text) {
                        cubit.search(text);
                      },
                      labelText: 'SEARCH',
                      prefixIcon: Icons.search,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (state is SearchLoadingState)
                      const LinearProgressIndicator(),
                    const SizedBox(
                      height: 10,
                    ),
                    if (state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => buildListProducts(
                              cubit.model.data.data[index], context,
                              isOldPrice: false),
                          separatorBuilder: (context, index) => myDivider(),
                          itemCount: cubit.model.data.data.length,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
