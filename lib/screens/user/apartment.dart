import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:vecinapp/core/models/apartment.dart';
import 'package:vecinapp/core/navigators/lobbyNavigator.dart';

import 'dart:math' as math;

import 'package:vecinapp/core/services/community.service.dart';
import 'package:vecinapp/widgets/homeImage.dart';

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;
  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => math.max(maxHeight, minHeight);
  @override
  Widget build(
      BuildContext context,
      double shrinkOffset,
      bool overlapsContent)
  {
    return new SizedBox.expand(child: child);
  }
  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

// ignore: must_be_immutable
class ApartmentWidget extends StatelessWidget {
  ApartmentWidget(this.apartmentsOwner, this.apartmentsRenter);
  final List<Apartment> apartmentsOwner;
  final List<Apartment> apartmentsRenter;

  @override
  Widget build(BuildContext context) {
    print(apartmentsOwner);
    return CustomScrollView(
      slivers: <Widget>[
        SliverPersistentHeader(
          pinned: true,
          delegate: _SliverAppBarDelegate(
            minHeight: 45.0,
            maxHeight: 70.0,
            child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.lightBlueAccent, Colors.blueAccent])),
                child:
                Center(
                    child: Text(
                        'Mis Viviendas',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        )
                    )
                )
            ),
          ),
        ),
        SliverPersistentHeader(
          pinned: true,
          delegate: _SliverAppBarDelegate(
            minHeight: 60.0,
            maxHeight: 120.0,
            child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.blueAccent, Colors.lightBlueAccent])),
                child:
                Center(
                    child: Text(
                        'Propietario',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        )
                    )
                )
            ),
          ),
        ),
        SliverFixedExtentList(
          itemExtent: 150.0,
          delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return Container(
                    child: ApartmentItemWidget(apartmentsOwner[index])
                );
              },
              childCount: apartmentsOwner.length),
        ),
        SliverPersistentHeader(
          pinned: true,
          delegate: _SliverAppBarDelegate(
            minHeight: 60.0,
            maxHeight: 120.0,
            child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.lightBlueAccent, Colors.blueAccent])),
                child:
                Center(
                    child: Text(
                        'Inquilino',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        )
                    )
                )
            ),
          ),
        ),
        SliverFixedExtentList(
          itemExtent: 150.0,
          delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return Container(
                    child: ApartmentItemWidget(apartmentsRenter[index])
                );
              },
              childCount: apartmentsRenter.length),
        ),
      ],
    );
  }
}

class ApartmentScreen extends StatelessWidget with NavigationStates {
  final int pk;
  ApartmentScreen(this.pk);
  Future<List<Apartment>> futureApartments;
  CommunityService communityService = CommunityService();
  List<Apartment> apartments;
  List<Apartment> apartmentsOwner;
  List<Apartment> apartmentsRenter;


  void _separateApartments() {
    apartmentsOwner = apartments.where((element) => element.owner.pk == pk).toList();
    apartmentsRenter = apartments.where((element) => !apartmentsOwner.contains(element)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Apartment>>(
        future: communityService.getApartmentsByUser(),
        builder: (context, snapshot) {
          print(snapshot.connectionState);
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [HomeImage(
                    photo: 'assets/images/logo.gif',
                    width: 150.0,
                    onTap: () {},
                  )]
              );
            case ConnectionState.done:
              apartments = snapshot.data;
              _separateApartments();
              return ApartmentWidget(apartmentsOwner, apartmentsRenter);
            default:
              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [HomeImage(
                    photo: 'assets/images/logo.gif',
                    width: 150.0,
                    onTap: () {},
                  )]
              );
          }
        },
      ),
    );
  }
}

class ApartmentItemWidget extends StatelessWidget {
  ApartmentItemWidget(this.apartment);
  final Apartment apartment;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 135,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 18.0, 8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white70,
              shape: BoxShape.rectangle,
              borderRadius: new BorderRadius.circular(8.0),
              boxShadow: <BoxShadow>[
                new BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.0,
                  offset: new Offset(0.0, 10.0),
                ),
              ],
          ),
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 5.0),
                child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                        apartment.community.name,
                      style: TextStyle(
                        fontSize: 18
                      ),
                    ))
                ,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: Row(

                    children: <Widget>[
                      Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Puerta'),
                              Text(
                                apartment.puerta,
                                textAlign: TextAlign.center,),
                            ],
                          )),
                      Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Piso'),
                              Text(
                                apartment.piso.toString(),
                                textAlign: TextAlign.center,),
                            ],
                          )),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/apartmentForm',
                              arguments: {"pk": apartment.pk});},
                          child: Icon(
                            Icons.edit,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}