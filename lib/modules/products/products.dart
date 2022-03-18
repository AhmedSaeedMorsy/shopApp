// ignore_for_file: unnecessary_null_comparison, unnecessary_string_interpolations, sized_box_for_whitespace


import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/model/categories_model.dart';
import 'package:shopapp/model/home_model.dart';
import 'package:shopapp/shared/constant.dart';
import 'package:shopapp/shared/cubit/app_cubit/shop_cubit/cubit.dart';
import 'package:shopapp/shared/cubit/app_cubit/shop_cubit/satates.dart';

class Products extends StatelessWidget {
  const Products({Key? key}) : super(key: key);
  //var cubit = ShopCubit.get(context);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: ConditionalBuilderRec(
              condition: ShopCubit.get(context).homeModel != null &&
                  ShopCubit.get(context).categoriesModel != null,
              builder: (context) => productBuilder(
                  ShopCubit.get(context).homeModel,
                  ShopCubit.get(context).categoriesModel,context),
              fallback: (context) => const Center(
                    child: CircularProgressIndicator(),
                  )),
        );
      },
    );
  }


Widget productBuilder(HomeModel? model, CategoriesModel? categoriesModel,context) {
  return SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: model!.data.banners
                .map(
                  (e) => Image(
                    image: NetworkImage(e.image),
                    fit: BoxFit.cover,
                  ),
                )
                .toList(),
            options: CarouselOptions(
              height: 180,
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          const Text(
            "Categories",
            style: TextStyle(
                color: mainColor, fontWeight: FontWeight.bold, fontSize: 25.0),
          ),
          Container(
            height: 100.0,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) =>
                  buildCategoriesItem(categoriesModel!.data.data[index]),
              separatorBuilder: (context, index) => const SizedBox(
                width: 10.0,
              ),
              itemCount: categoriesModel!.data.data.length,
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          const Text(
            "New Products",
            style: TextStyle(
                color: mainColor, fontWeight: FontWeight.bold, fontSize: 25.0),
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
              childAspectRatio: 1 / 1.7,
              children: List.generate(model.data.products.length,
                  (index) => buildGridItem(model.data.products[index],context)),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildGridItem(ProductModel ? model ,context ) {
  return Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(
                model!.image,
              ),
              width: double.infinity,
              height: 150.0,
            ),
            if (model.discount != 0)
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
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${model.name}",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14.0,
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              Row(
                children: [
                  Text(
                    '${model.price}',
                    style: const TextStyle(color: mainColor, fontSize: 12.0),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  if (model.discount != 0)
                    Text(
                      '${model.oldPrice}',
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12.0,
                          decoration: TextDecoration.lineThrough),
                    ),
                  const Spacer(),
                  
                  CircleAvatar(
                    radius: 20.0,
                    backgroundColor: ShopCubit.get(context).favoritesProduct[model.id]  ? mainColor : Colors.grey,
                    child: IconButton(
                      onPressed: () {
                        
                        ShopCubit.get(context).changeFavorites(model.id);
                        
                      },
                      icon: const Icon(
                        Icons.favorite_border_outlined,color: Colors.white,
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
  );
}

  Widget buildCategoriesItem(DataModel model) {
  return Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Image(
        image: NetworkImage(model.image),
        width: 100.0,
        height: 100.0,
      ),
      Container(
        width: 100.0,
        color: Colors.black.withOpacity(0.6),
        child: Text(
          model.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ],
  );
 }
}