import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/modules/search/search.dart';
import 'package:shopapp/shared/componant/componant.dart';
import 'package:shopapp/shared/constant.dart';
import 'package:shopapp/shared/cubit/app_cubit/shop_cubit/cubit.dart';
import 'package:shopapp/shared/cubit/app_cubit/shop_cubit/satates.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomeLayOut extends StatelessWidget {
  const HomeLayOut({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
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
          bottomNavigationBar: CurvedNavigationBar(
            color: mainColor,
            backgroundColor: Colors.white12,
            items: const [
              Icon(Icons.home_outlined, size: 30,color: Colors.white,),
              Icon(
                Icons.apps_outlined,
                color: Colors.white,
                size: 30,
              ),
              Icon(
                Icons.favorite_outline,
                color: Colors.white,
                size: 30,
              ),
              Icon(
                Icons.settings,
                color: Colors.white,
                size: 30,
              ),
            ],
            onTap: (index) => cubit.changeIndex(index),
          ),
        );
      },
    );
  }
}
