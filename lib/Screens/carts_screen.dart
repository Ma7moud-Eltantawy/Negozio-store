import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:negozio_store/Providers/Shared_pref.dart';
import 'package:negozio_store/Screens/orders/Order_make.dart';
import 'package:negozio_store/Screens/profile_screen.dart';
import 'package:negozio_store/network/models/cart_model.dart';
import 'package:negozio_store/styles/Local_Styles.dart';
import 'package:negozio_store/styles/icons.dart';
import 'package:negozio_store/widgets/material_button.dart';
import 'package:provider/provider.dart';

import '../network/Network/Carts.dart';
import '../network/models/Carts_model.dart';
import '../widgets/Motion_toast.dart';
import '../widgets/circular_progress.dart';
class carts_screen extends StatefulWidget {
  const carts_screen({Key? key}) : super(key: key);
  static const scid="carts";

  @override
  State<carts_screen> createState() => _carts_screenState();
}

class _carts_screenState extends State<carts_screen> {
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    var height=size.height;
    var width=size.width;
    return Consumer<shared_pref_prov>(
      builder:(context,prov,ch)=> Scaffold(
        backgroundColor: Colors.white,
        body: StreamBuilder(
          stream: Provider.of<Carts_prov>(context,listen: false).get_Carts().asStream(),
          builder: (context,AsyncSnapshot<carts_model>snapshot)=>!snapshot.hasData?
          snapshot.connectionState==ConnectionState.waiting?
          Center(
            child: progress_indicator(),
          ):Container()
              :
          Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                "My Cart",
                style: TextStyle(color: local_green),
              ),
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: Icon(
                  IconBroken.Arrow___Left_2,
                  color: local_green,
                  size: 35,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(
                    right: 10,
                  ),
                  child: InkWell(
                    onTap: (){
                      Navigator.of(context).pushNamed(Myprofile_screen.scid);

                    },
                    child: CircleAvatar(
                      radius: 24,
                      backgroundColor: local_green,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 22.5,
                        child: CachedNetworkImage(
                          imageUrl: prov.user_data!.data!.image!.toString(),
                          placeholder: (context, url) => Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 1.5,
                              )),
                          errorWidget: (context, url, error) => Icon(
                            Icons.error,
                            color: local_green,
                          ),
                          imageBuilder: (context, imageProvider) => CircleAvatar(
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
            body: snapshot.data!.data!.cartItems!.length==0?
                Padding(
                  padding: EdgeInsets.all(width/5),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/img/cart.png',
                        ),
                        Text('Cart is empty!'),
                      ],
                    ),
                  ),
                )

                :ListView.builder(
          padding: const EdgeInsets.only(top: 15.0),
          physics: BouncingScrollPhysics(),
          itemCount: snapshot.data!.data!.cartItems!.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
            child: Slidable(
              key: ValueKey(index),
              endActionPane: ActionPane(
                motion: ScrollMotion(),
                children: [
                  SlidableAction(
                    // An action can be bigger than the others.
                    onPressed: (context) {
                      Provider.of<Carts_prov>(context,listen: false).add_delete_cart(snapshot.data!.data!.cartItems![index].id.toString(),snapshot.data!.data!.cartItems![index].quantity!.toInt());
                      setState(() {

                      });

                    },
                    foregroundColor: Colors.red,
                    icon: IconBroken.Delete,
                    label: 'Delete',
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ],
              ),
              child: Container(
                width: double.infinity,
                height: 105,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.grey[50],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        width: 90,
                        height: double.infinity,
                        child: CachedNetworkImage(
                          imageUrl:snapshot.data!.data!.cartItems![index].product!.image.toString(),
                          fit: BoxFit.cover,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 1.5,
                            ),
                          ),
                          errorWidget: (context, url, error) => Icon(
                            Icons.error,
                            color: local_green,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot.data!.data!.cartItems![index].product!.name.toString(),
                              style: TextStyle(fontSize: 14),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${snapshot.data!.data!.cartItems![index].product!.price.toString()} EGP',
                                  style: TextStyle(
                                    color: local_green,
                                    fontSize: 12,
                                  ),
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        if(snapshot.data!.data!.cartItems![index].quantity!.toInt()>1)
                                        Provider.of<Carts_prov>(context,listen: false).update_cart(snapshot.data!.data!.cartItems![index].id!.toInt(), snapshot.data!.data!.cartItems![index].quantity!.toInt()-1);
                                        setState(() {

                                        });
                                      },
                                      child: Icon(
                                        Icons.remove,
                                        color: Colors.red,
                                        size: 20,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      child: Text(
                                        '${
                                            snapshot.data!.data!.cartItems![index].quantity.toString()}',
                                        style:
                                        TextStyle(fontSize: 16, color: local_green),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {

                                        Provider.of<Carts_prov>(context,listen: false).update_cart(snapshot.data!.data!.cartItems![index].id!.toInt(), snapshot.data!.data!.cartItems![index].quantity!.toInt()+1);
                                        setState(() {

                                        });
                                      },
                                      child: ShaderMask(
                                        shaderCallback: (bounds) {
                                          return RadialGradient(
                                            center: Alignment.topLeft,
                                            radius: 1,
                                            colors: [Color.fromRGBO(24, 82, 66, 1),Color.fromRGBO(50, 130, 96, 1), Color.fromRGBO(85 ,195 ,136, 1)],
                                            tileMode: TileMode.repeated,
                                          ).createShader(bounds);
                                        },
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ), /* Padding(

              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/img/cart.png',
                    ),
                    Text('Cart is empty!'),
                  ],
                ),
              ),
            ),*/
            bottomNavigationBar: BottomAppBar(
              child: Container(
                height: 135,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Price:',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            '${snapshot.data!.data!.total.toString()} EGP',
                            style: TextStyle(
                              color: local_green,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                     Mbutton(width: width, height: height, colors: [ Color.fromRGBO(59, 221, 175, 1.0),

                       local_green,], txt: "CheckOut", wid: Icon(Icons.check_circle_outline_outlined,color: Colors.white,), func: ()=>(){

                       if(snapshot.data!.data!.total==0)
                         {
                           Fail_toast(ctx: context, title: "failed", height: height, width: width, desc: "no products in the cart to make check");
                         }
                       else{
                         Navigator.of(context).pushNamed(Make_order_screen.scid,arguments:snapshot.data!.data!.total.toString());

                       }
                     })
                    ],
                  ),
                ),
              ),
              elevation: 10,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  buildItem(List<CartItems> cart) {

  }
}
