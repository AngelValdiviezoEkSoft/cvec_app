import 'package:flutter/material.dart';

class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const LoadingOverlay(
    Key? key,
    {
    required this.isLoading,
    required this.child,
    }
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading) ...[
          ModalBarrier(
            dismissible: false,
            color: Colors.black.withOpacity(0.5), // fondo bloqueador
          ),
          const Center(
            child: CircularProgressIndicator(color: Colors.white,),
          ),
        ],
      ],
    );
  }
}
