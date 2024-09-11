import "package:flutter/material.dart";

/// Tipos de animaciones
enum AnimationType {
  normal,
  fadeIn
}

/// Main class
class RouteTransitions {
  final BuildContext context;
  final Widget child;
  final AnimationType animation;
  final Duration duration;
  final bool replacement;


  RouteTransitions( {
    this.duration =  const Duration(seconds: 2),
    required this.context, 
    required this.child, 
    this.replacement = false, 
    this.animation = AnimationType.normal
  }) {
    switch (this.animation) {
      case AnimationType.normal:
      this._nomrmalTransition();
        break;
      case AnimationType.fadeIn:
      this._fadeInTransition();
        break;
    }


    
  }


  void _pushPage(Route route) => Navigator.push(context, route);

  void _pushReplacementPage(Route route) =>  Navigator.pushReplacement(context, route);

  void _nomrmalTransition(){
    final route = MaterialPageRoute(builder: ( _ ) => this.child);
    
    (this.replacement)
      ? this._pushReplacementPage(route)
      : this._pushReplacementPage(route);
  }

  void _fadeInTransition(){
    final route = PageRouteBuilder(
      pageBuilder: (_,__,___) =>this.child,
      transitionDuration: duration,
      transitionsBuilder: (_,animation,__, child){
        return FadeTransition(
          child: child,
          opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeOut)
          )

        );
      }
    );

    (this.replacement)
      ? this._pushReplacementPage(route)
      : this._pushReplacementPage(route);
  }
}