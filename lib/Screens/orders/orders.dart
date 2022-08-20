import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:negozio_store/Providers/Shared_pref.dart';
import 'package:negozio_store/network/Network/orders_prov.dart';
import 'package:negozio_store/network/models/orders_model.dart';
import 'package:negozio_store/styles/Local_Styles.dart';
import 'package:provider/provider.dart';

import '../../styles/icons.dart';
import '../../widgets/circular_progress.dart';
class Orders_screen extends StatefulWidget {
  const Orders_screen({Key? key}) : super(key: key);
  static const scid="orders";

  @override
  State<Orders_screen> createState() => _Orders_screen();
}

class _Orders_screen extends State<Orders_screen> {
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    var height=size.height;
    var width=size.width;
    return Consumer<shared_pref_prov>(
      builder:(context,prov,ch)=> Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Orders',
            style: TextStyle(
              color: local_green
            ),
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
                onTap: () {

                },
                child: CircleAvatar(
                  radius: 24,
                  backgroundColor: local_green,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 22.5,
                    child: CachedNetworkImage(
                      imageUrl: Provider.of<shared_pref_prov>(context,listen: false).user_data!.data!.image!.toString(),
                      placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(
                            color: local_green,
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
        body: StreamBuilder(
            stream: Provider.of<Orders_prov>(context,listen: false).get_orders().asStream(),
            builder:(BuildContext context, AsyncSnapshot<orders_model> snapshot)=> !snapshot.hasData?
                snapshot.connectionState==ConnectionState.waiting? Center(child: progress_indicator()):Container(
                  alignment: Alignment.center,
                  child: Text("Make order to see here..!",style: TextStyle(
                    color: local_green,fontSize: width/25
                  ),),
                )
                :snapshot.data!.data==null?Center(child: progress_indicator()):Consumer<Orders_prov>(
                  builder:(context,prov,ch) =>  ListView.separated(
              padding: const EdgeInsets.all(15.0),
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                    return Slidable(
                      key: ValueKey(index),
                      endActionPane: ActionPane(
                        motion: ScrollMotion(),
                        children: [
                          SlidableAction(
                            // An action can be bigger than the others.
                            onPressed: (context)async  {
                              await prov.cancel_order(snapshot.data!.data!.data![index].id!.toInt());
                              setState(() {

                              });

                            },
                            foregroundColor: Colors.red,
                            icon: IconBroken.Close_Square,
                            label: 'Cancel',
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ],
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.grey[50],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text('Date:'),
                                      SizedBox(width: 10.0,),
                                      Text(
                                      snapshot.data!.data!.data![index].date.toString(),

                                        style: TextStyle(color: local_green),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('Total:'),
                                      SizedBox(width: 10.0,),
                                      Text(
                                          snapshot.data!.data!.data![index].total.toString(),

                                        style: TextStyle(color: local_green),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Text(
                                snapshot.data!.data!.data![index].status.toString(),
                                style: TextStyle(color:snapshot.data!.data!.data![index].status.toString()!="New"? Colors.red:local_green),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
              },
              separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 10.0,
                    );
              },
              itemCount: 5,
            ),

                ),
          ),


      ),
    );
  }
}
