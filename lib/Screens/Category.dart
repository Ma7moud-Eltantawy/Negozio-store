import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:negozio_store/Providers/Shared_pref.dart';
import 'package:negozio_store/Screens/All_products.dart';
import 'package:negozio_store/Screens/Search_Screen.dart';
import 'package:negozio_store/Screens/profile_screen.dart';
import 'package:negozio_store/network/Network/Categories.dart';
import 'package:negozio_store/network/Network/Product_data.dart';
import 'package:negozio_store/network/models/Categories.dart';
import 'package:negozio_store/network/models/product_model.dart';
import 'package:negozio_store/referense.dart';
import 'package:negozio_store/widgets/circular_progress.dart';
import 'package:provider/provider.dart';

import '../styles/Local_Styles.dart';
import '../styles/icons.dart';
class Categories_Screen extends StatefulWidget {
  const Categories_Screen({Key? key}) : super(key: key);

  @override
  State<Categories_Screen> createState() => _Categories_ScreenState();
  static const scid="Categories_Screen";
}

class _Categories_ScreenState extends State<Categories_Screen> {
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    var height=size.height;
    var width=size.width;
    return Consumer<shared_pref_prov>(
      builder:(context,prov,ch)=> Scaffold(
        backgroundColor: Colors.white,
        appBar:  AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon:  Icon(
              IconBroken.Arrow___Left_2,
              size: 35,
              color: local_green,
            ),
            onPressed: () {
              Navigator.of(context).pop();

            },
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(Myprofile_screen.scid);

              },
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 10,
                ),
                child: CircleAvatar(
                  radius: 24,
                  backgroundColor: local_green,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 22.5,
                    child: CachedNetworkImage(
                      imageUrl:
                      Provider.of<shared_pref_prov>(context,listen: false).user_data!.data!.image.toString(),
                      placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(
                            color: local_green,
                            strokeWidth: 1.5,
                          )),
                      errorWidget: (context, url, error) => Icon(
                        Icons.error,
                        color: local_green,
                      ),
                      imageBuilder: (context, imageProvider) =>
                          CircleAvatar(
                            backgroundImage: imageProvider,
                            radius: 21,
                          ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(width/50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'miscellaneous categories',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  'Select Category',
                  style: TextStyle(fontSize: 20, color: local_green),
                ),
                SizedBox(
                  height: 15.0,
                ),
                InkWell(
                  onTap: (){
                    Navigator.of(context).pushNamed(Search_screen.scid);
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Search...',
                            style: TextStyle(color: Colors.grey),
                          ),


                          Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.circular(6.0),
                            ),
                            child: Icon(
                              IconBroken.Search,
                              color: local_green,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding:
                   EdgeInsets.symmetric(vertical: width/50),
                  child: Text(
                    'Categories:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                FutureBuilder(
                  future: Provider.of<Category_prov>(context,listen: false).get_categories(),
                  builder:(context,AsyncSnapshot<Categories_model>snapshot)=>
                      !snapshot.hasData?Container(
                          height: height/2,
                          child: Center(child: progress_indicator())):GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 7 / 10,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10
                  ) , itemBuilder: (context,index)=>InkWell(

                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context){
                            return products_grid(getdatafunc:()=> Provider.of<Products_prov>(context,listen: false).get_category_product(snapshot.data!.data!.data![index].id!.toInt()));
                          }));

                        },
                    child: Container(

                      decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(8)
                      ),

                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,

                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: snapshot.data!.data!.data![index].image.toString(),

                                  placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 1.5,
                                      )),
                                  errorWidget: (context, url, error) => Icon(
                                    Icons.error,
                                    color: local_green,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex:1 ,

                              child: Container(
                                alignment: Alignment.center,
                                width: width/2.5,
                                child: Text(
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  snapshot.data!.data!.data![index].name.toString(),
                                  maxLines: 2,
                                  style: TextStyle(
                                    //overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ),

                          ],

                        ),
                      ),
                    ),
                  ),
                    itemCount: snapshot.data!.data!.data!.length,
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
