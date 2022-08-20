import 'package:alan_voice/alan_voice.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:negozio_store/Providers/prov_product_info.dart';
import 'package:negozio_store/Screens/Home_page.dart';
import 'package:negozio_store/network/Network/Carts.dart';
import 'package:negozio_store/styles/Local_Styles.dart';
import 'package:negozio_store/widgets/Motion_toast.dart';
import 'package:negozio_store/widgets/circular_progress.dart';
import 'package:negozio_store/widgets/material_button.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:expandable/expandable.dart';


import '../network/Network/Product_data.dart';
import '../network/models/product_model.dart';
import '../styles/icons.dart';
class Product_info extends StatefulWidget {

  Product_info({Key? key}) : super(key: key);
  static const scid="product_info";

  @override
  State<Product_info> createState() => _Product_infoState();
}

class _Product_infoState extends State<Product_info> {
  @override
    ScrollController? _scrollController;
  bool lastStatus = true;
  double height = 200;

  void _scrollListener() {
    if (_isShrink != lastStatus) {
      setState(() {
        lastStatus = _isShrink;
      });
    }
  }

  bool get _isShrink {
    return _scrollController != null &&
        _scrollController!.hasClients &&
        _scrollController!.offset > (height - kToolbarHeight);
  }

  @override
  void initState() {
    super.initState();
    AlanVoice.hideButton();
    //AlanVoice.addButton("e8655324bfc003d8959794f6683b755c2e956eca572e1d8b807a3e2338fdd0dc/stage",topMargin: 5);
    _scrollController = ScrollController()..addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
       Provider.of<prov_product_info>(context, listen: false).active_point=0;
    });
  }

  @override
  void dispose() {
    _scrollController?.removeListener(_scrollListener);
    _scrollController?.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    var productid=ModalRoute.of(context)!.settings.arguments as int;
    var size=MediaQuery.of(context).size;
    var height=size.height;
    var width=size.width;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Consumer<Carts_prov>(
        builder:(context,prov,ch)=> StreamBuilder(
            stream: Provider.of<Products_prov>(context,listen: false).get_product_details(productid).asStream(),

            builder:(BuildContext context, AsyncSnapshot<product_model> snapshot)=>
            !snapshot.hasData?Scaffold(body: Center(child: progress_indicator(),)): Scaffold(
            body:
                  NestedScrollView(
                controller: _scrollController,
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor:  _isShrink?local_green.withOpacity(.2):Colors.white,
                        statusBarIconBrightness: _isShrink?Brightness.light:Brightness.dark,
                      ),
                      elevation: 0,
                      backgroundColor: local_green,
                      pinned: true,
                      expandedHeight: height/2,
                      leading: _isShrink
                          ? GestureDetector(
                        onTap: (){
                          Navigator.of(context, rootNavigator: true).pop(context);
                        },
                            child: const Icon(
                        IconBroken.Arrow___Left
                      ),
                          )
                          : Container(),
                      flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.parallax,
                        title: _isShrink
                            ? Container(
                          width: width/1.8,
                              child: Text(
                          snapshot.data!.name.toString(),
                          maxLines: 1,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          textDirection: TextDirection.ltr,

                        ),
                            )
                            : null,
                        background: SafeArea(
                          child: Scaffold(
                            floatingActionButton: FloatingActionButton(

                                child: Icon(
                                  IconBroken.Heart,
                                  color:snapshot.data!.inFavorites!?Colors.red: Colors.grey,
                                  size: 25,
                                ),
                                backgroundColor: Colors.white,
                                onPressed: () async{
                                 await Provider.of<Products_prov>(context,listen: false).Add_delete_fav(snapshot.data!.id.toString());
                                  setState(() {
                                  });
                                }),

                            body: Stack(
                              children: [
                                CarouselSlider.builder(
                                  itemCount: snapshot.data!.images!.length,
                                  itemBuilder: (context, index, n) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: CachedNetworkImage(
                                        imageUrl: snapshot.data!.images![index],
                                        fit: BoxFit.cover,
                                        progressIndicatorBuilder:
                                            (context, url, downloadProgress) => Center(
                                          child: CircularProgressIndicator(
                                            value: downloadProgress.progress,
                                            color: local_green,
                                            strokeWidth: 3,
                                          ),
                                        ),
                                        errorWidget: (context, url, error) => Icon(
                                          Icons.error,
                                        ),
                                      ),
                                    );
                                  },
                                  options: CarouselOptions(
                                    onPageChanged: (index, reason) {
                                      Provider.of<prov_product_info>(context,listen:false).change_active(index);
                                    },
                                    //autoPlay: true,
                                    height: MediaQuery.of(context).size.height / 2,
                                    viewportFraction: 1,
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    enableInfiniteScroll: true,
                                  ),
                                ),
                                Consumer<prov_product_info>(
                                  builder:(context,prov,ch)=> Align(
                                    alignment: Alignment.topCenter,
                                    child: ShaderMask(
                                      shaderCallback: (bounds) {
                                        return RadialGradient(
                                          center: Alignment.topLeft,
                                          radius: 1,
                                          colors: [Color.fromRGBO(50, 130, 96, 1), Color.fromRGBO(70 ,167 ,119, 1),Color.fromRGBO(85 ,195 ,136, 1)],
                                          tileMode: TileMode.repeated,
                                        ).createShader(bounds);
                                      },
                                      child: Padding(
                                        padding:  EdgeInsets.only(top: height/2.255),
                                        child: AnimatedSmoothIndicator(
                                          count: snapshot.data!.images!.length,
                                          activeIndex: prov.active_point,
                                          effect: ExpandingDotsEffect(
                                            dotColor: Colors.white38,
                                            dotHeight: 10,
                                            dotWidth: 10,
                                            expansionFactor: 4,
                                            spacing: 5,
                                            activeDotColor:Colors.white ,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0, top: 10.0),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.black.withOpacity(0.3),
                                    radius: 20,
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.of(context, rootNavigator: true).pop(context);
                                      },
                                      icon: Icon(
                                        IconBroken.Arrow___Left_2,
                                        color: Colors.white,
                                        size: 25,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      actions: _isShrink
                          ? [
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 12),
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.only(left: 8, right: 8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [

                                  ],
                                ),
                              ),
                              IconButton(onPressed: ()async{
                                await Provider.of<Products_prov>(context,listen: false).Add_delete_fav(snapshot.data!.id.toString());
                                setState(() {
                                });
                              }, icon: Icon(IconBroken.Heart,color: snapshot.data!.inFavorites!?Colors.red:Colors.grey,))
                            ],
                          ),
                        ),
                      ]
                          : null,
                    ),
                  ];
                },
                body:Container(
                  child: ListView(
                    children: [
                      Text(
                        snapshot.data!.name.toString(),
                        style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto'
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                  SizedBox(height: 25,),
                  ExpandablePanel(
                  header: Text("About",style: TextStyle(fontWeight: FontWeight.bold,color: local_green)),
                  collapsed: Text( snapshot.data!.description.toString(), overflow: TextOverflow.ellipsis,maxLines: (height/55).toInt(),),
                  expanded: Text(snapshot.data!.description.toString(), softWrap: true, ),

              ),
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(vertical: 15.0),
                        child: Text(
                          'Other offers',
                          style: TextStyle(fontWeight: FontWeight.bold,color: local_green),
                        ),
                      ),
                      FutureBuilder(
                          future: Provider.of<Products_prov>(context,listen: false).get_products(),

                          builder:(BuildContext context, AsyncSnapshot<List<product_model>> snapshot)=>
                              !snapshot.hasData?Center(child:progress_indicator(),):
                              Container(
                          color: Colors.grey.withOpacity(.02),
                          height: height/3,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.where((element) =>element.price!=element.oldPrice ).length,
                              itemBuilder: (context,index)=>snapshot.data![index].oldPrice!=snapshot.data![index].price? InkWell(
                              onTap: (){
                                Navigator.of(context).pushNamed(Product_info.scid,arguments: snapshot.data![index].id);
                              },
                              child:
                              Stack(
                                children: [

                                  Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Container(
                                      margin: EdgeInsets.all(width/150),
                                      width: width/2,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8.0),
                                        color: Colors.grey[50],
                                      ),
                                      child: Padding(
                                        padding:  EdgeInsets.all(width/90),
                                        child: Column(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                width: MediaQuery.of(context).size.width/2,
                                                height: height/5,
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(8.0),
                                                ),
                                                child: CachedNetworkImage(
                                                  fit: BoxFit.cover,
                                                  imageUrl: snapshot.data![index].image.toString(),

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
                                            Padding(
                                              padding:  EdgeInsets.symmetric(vertical:0),
                                              child: Container(
                                                width: width/2.5,
                                                child: Text(
                                                  softWrap: true,
                                                  overflow: TextOverflow.ellipsis,
                                                  snapshot.data![index].name.toString(),
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                    //overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    //if(pr[index].oldPrice!=pr[index].price)
                                                      Container(
                                                        alignment: Alignment.centerLeft,
                                                        width: width/5,
                                                        child: Text(
                                                          textAlign: TextAlign.left,
                                                          textDirection: TextDirection.ltr,

                                                          softWrap: true,
                                                          overflow: TextOverflow.ellipsis,

                                                          '${snapshot.data![index].oldPrice} EGP',
                                                          style: TextStyle(
                                                            decoration: TextDecoration.lineThrough,
                                                            color: local_green,
                                                            fontSize: width/35,
                                                          ),
                                                        ),
                                                      ),
                                                    Container(
                                                      width: width/5,
                                                      child: Text(

                                                        softWrap: true,
                                                        overflow: TextOverflow.ellipsis,

                                                        '${snapshot.data![index].price} EGP',
                                                        style: TextStyle(
                                                          color: local_green,
                                                          fontSize: width/32,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                InkWell(
                                                  onTap: ()async{
                                                    await Provider.of<Products_prov>(context,listen: false).Add_delete_fav(snapshot.data![index].id.toString());
                                                    setState(() {
                                                    });
                                                  },
                                                  child: Icon(
                                                    IconBroken.Heart,
                                                    color: snapshot.data![index].inFavorites!?Colors.red:Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                      child: Image.asset("assets/img/sale.png",height: 30,)

                                  ),
                                ],
                              ),
                            ):Container(),


                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                /*CustomScrollView(

                  slivers: [
                    SliverList(
                      delegate:SliverChildBuilderDelegate(

                      ),
                      /*SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(child: Text("Item: $index")),
                          );
                        },
                        childCount: 50,
                      ),*/
                    ),
                  ],
                ),*/
              ),

            bottomNavigationBar: Container(
              alignment: Alignment.center,
              color: Colors.transparent,
              height: height/12,
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Price' ,style: TextStyle(fontSize: 15),),
                      Text('${snapshot.data!.price} EPG' ,style: TextStyle(fontSize: 18,color: local_green),),

                    ],
                  ),
                  Expanded(child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width/150),
                    child: Mbutton(width: width, height: height, colors: [ Color.fromRGBO(59, 221, 175, 1.0),

                      local_green,],
                        txt: snapshot.data!.inCart.toString()=="true"?"in Cart":"Add to cart", wid: Icon(IconBroken.Buy,color: Colors.white,), func: ()=>()async{
                          await prov.add_delete_cart(snapshot.data!.id.toString(), 1);
                          print( snapshot.data!.inCart.toString());
                      setState(() {

                      });
                         await snapshot.data!.inCart.toString()=="true"?Fail_toast(ctx: context,title: "success", height: height, width: width, desc: "Deleted from cart"):MY_toast(ctx: context, height: height, width: width, desc: "Added to cart");

                        }),
                  )),
                ],

              ),
            ),
          ),
        ),
      );
  }

}

