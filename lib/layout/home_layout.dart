import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/modules/search/search.dart';
import 'package:shopapp/shared/componant/componant.dart';
import 'package:shopapp/shared/cubit/app_cubit/shop_cubit/cubit.dart';
import 'package:shopapp/shared/cubit/app_cubit/shop_cubit/satates.dart';


class HomeLayOut extends StatelessWidget {
  const HomeLayOut({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(listener: (context, state) {},builder: (context, state){
        var cubit = ShopCubit.get(context);
      
      return Scaffold(
        appBar: AppBar(
          title: const Text("Cesta"),
          actions: [
            IconButton(
              onPressed: () {
                navigatTo(context, Search());
              },
              icon: const Icon(Icons.search_outlined),
            ),
          ],
        ),
        body: cubit.bottomnavItem[cubit.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.apps_outlined,
              ),
              label: "categories",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite_outline,
              ),
              label: "favrites",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
              ),
              label: "settings",
            ),
        ],
        currentIndex: cubit.currentIndex,
        onTap: (index) =>  cubit.changeIndex(index),
      ),
    );
    },);
  }
}
