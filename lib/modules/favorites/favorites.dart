import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/model/favorites_model.dart';
import 'package:shopapp/shared/constant.dart';
import 'package:shopapp/shared/cubit/app_cubit/shop_cubit/cubit.dart';
import 'package:shopapp/shared/cubit/app_cubit/shop_cubit/satates.dart';

class Favorites extends StatelessWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilderRec(
            condition: state is! FavoritesDataLoadingState,
            builder: (context) => ListView.separated(
                itemBuilder: (context, index) => favoritsBuildItem(
                    ShopCubit.get(context).favoritesModel!.data.data[index],
                    context),
                separatorBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Container(
                        height: 1.0,
                        color: Colors.grey,
                      ),
                    ),
                itemCount:
                    ShopCubit.get(context).favoritesModel!.data.data.length),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }

  Widget favoritsBuildItem(Data model, context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        height: 120.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(
                    model.product.image,
                  ),
                  fit: BoxFit.cover,
                  width: 150.0,
                  height: 150.0,
                ),
                if (model.product.discount != 0)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    color: mainColor,
                    child: const Text(
                      "DISCOUNT",
                      style: TextStyle(color: Colors.white, fontSize: 8.0),
                    ),
                  ),
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.product.name,
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
                        '${model.product.price}',
                        style:
                            const TextStyle(color: mainColor, fontSize: 12.0),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      if (model.product.discount != 0)
                        Text(
                          '${model.product.oldPrice}',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12.0,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const Spacer(),
                      CircleAvatar(
                        radius: 20.0,
                        backgroundColor: ShopCubit.get(context)
                                .favoritesProduct[model.product.id]
                            ? mainColor
                            : Colors.grey,
                        child: IconButton(
                          onPressed: () {
                            ShopCubit.get(context)
                                .changeFavorites(model.product.id);
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
