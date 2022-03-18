import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/model/categories_model.dart';
import 'package:shopapp/shared/cubit/app_cubit/shop_cubit/cubit.dart';
import 'package:shopapp/shared/cubit/app_cubit/shop_cubit/satates.dart';

class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ListView.separated(
              itemBuilder: (context, index) => categoriesListItem(
                  ShopCubit.get(context).categoriesModel!.data.data[index]),
              separatorBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Container(
                      height: 1.0,
                      color: Colors.grey,
                    ),
                  ),
              itemCount:
                  ShopCubit.get(context).categoriesModel!.data.data.length);
        },
      ),
    );
  }
}

Widget categoriesListItem(DataModel model) {
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: Row(
      children: [
        Image(
          image: NetworkImage(model.image),
          height: 100.0,
          width: 100.0,
        ),
        const SizedBox(
          width: 10.0,
        ),
        Text(
          model.name,
        ),
        const Spacer(),
        const Icon(Icons.arrow_forward_outlined)
      ],
    ),
  );
}
