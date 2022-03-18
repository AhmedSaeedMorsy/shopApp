// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/model/search_model.dart';
import 'package:shopapp/shared/componant/componant.dart';
import 'package:shopapp/shared/constant.dart';
import 'package:shopapp/shared/cubit/app_cubit/search_cubit/cubit.dart';
import 'package:shopapp/shared/cubit/app_cubit/search_cubit/states.dart';
import 'package:shopapp/shared/cubit/app_cubit/shop_cubit/cubit.dart';

class Search extends StatelessWidget {
  Search({Key? key}) : super(key: key);
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (BuildContext context) => SearchCubit(),
        child: BlocConsumer<SearchCubit, SearchStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  defaultTextFormField(
                    controller: searchController,
                    textInputType: TextInputType.text,
                    labelText: "Search",
                    prefixIcon: const Icon(Icons.search_outlined),
                    onChange: (value){
                      SearchCubit.get(context).searchData(text: searchController.text);
                    }
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  if(state is SearchLoadingState)
                  const RefreshProgressIndicator(),
                  if (state is SearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) => productSearchBuildItem(
                              SearchCubit.get(context)
                                  .searchModel
                                  .dataModel
                                  .data[index],
                              context),
                          separatorBuilder: (context, index) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12.0),
                                child: Container(
                                  height: 1.0,
                                  color: Colors.grey,
                                ),
                              ),
                          itemCount: SearchCubit.get(context)
                              .searchModel
                              .dataModel
                              .data
                              .length),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget productSearchBuildItem(Data model, context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        height: 120.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              image: NetworkImage(
                model.image,
              ),
              fit: BoxFit.cover,
              width: 150.0,
              height: 150.0,
            ),
            const SizedBox(width:10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        '${model.price}',
                        style:
                            const TextStyle(color: mainColor, fontSize: 12.0),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      const Spacer(),
                      CircleAvatar(
                        radius: 20.0,
                        backgroundColor:
                            ShopCubit.get(context).favoritesProduct[model.id]
                                ? mainColor
                                : Colors.grey,
                        child: IconButton(
                          onPressed: () {
                            ShopCubit.get(context).changeFavorites(model.id);
                          },
                          icon: const Icon(
                            Icons.favorite_border_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
