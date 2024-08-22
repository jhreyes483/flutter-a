class Usuario {
  String nombre;
  int edad;
  List<String>profesiones;


  Usuario({required this.nombre, required this.edad, required this.profesiones}){
      if (profesiones == null) {
      throw ArgumentError('profesiones no puede ser null');
    }
  }
}