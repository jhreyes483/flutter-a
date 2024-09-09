part of 'helpers.dart';

mostrarLoading( BuildContext context ){
  showDialog(
    context: context, 
    barrierDismissible: false, // hace que no se pueda cerrar si se toca afuera
    builder: (_) => AlertDialog(
      title: Text('espere...'),
      content: LinearProgressIndicator(),
    )
    );
}

mostrarAlerta( BuildContext context, String titulo, String mensaje){
  showDialog(
    context: context, 
    barrierDismissible: false, // hace que no se pueda cerrar si se toca afuera
    builder: ( _ ) => AlertDialog(
      title: Text(titulo),
      content: Text(mensaje),
      actions: [
        MaterialButton(
          child: const Text('OK'),
          onPressed: ()  => Navigator.of(context).pop(), // cierra la alerta

        )
      ],
    )
    );

}