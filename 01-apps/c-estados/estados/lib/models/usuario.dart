class Usuario {
  String nombre;
  int edad;
  List<String>profesiones;


  Usuario({required this.nombre, required this.edad, required this.profesiones}){
    if (profesiones == null) {
      throw ArgumentError('profesiones no puede ser null');
    }
  }

  Usuario copyWith({ // copiarUsuario
    String ?nombre,
    int ?edad,
    List<String>?profesiones
  }) =>
    Usuario(
      nombre     : nombre ?? this.nombre, 
      edad       : edad ?? this.edad,
      profesiones: profesiones ?? this.profesiones
    );
}