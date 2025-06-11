import 'package:flutter/material.dart';
import 'package:cve_app/auth_services.dart';
import 'package:provider/provider.dart';

class WebSiteView extends StatelessWidget {

  const WebSiteView(Key? key) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;        

    return Center(
      child: ChangeNotifierProvider(
        create: (_) => AuthService(),
        child: WebSiteViewSt(size: size),
      )        
    );
  }
}

class WebSiteViewSt extends StatelessWidget {
  const WebSiteViewSt({
    super.key,
    required this.size
  });

  final Size size;

  @override
  Widget build(BuildContext context) {

    return Container(
      width: size.width,
      height: size.height * 0.82,
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                        
              Container(
                width: size.width,
                height: size.height * 0.85,
                color: Colors.transparent,
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: <Widget>[
                    const SizedBox( height: 3, ),
                    ...itemMap,
                  ],
                ),
              ),
                        
              SizedBox(height: size.height * 0.07),
            
            ],
          ),
        ),
      ),
    );
            
  }
  
}
