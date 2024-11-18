//Al implementar esta clase se tiene que parsar en los genericos
// el typo que es el que devolverá, y el tipo de dato que es el que le va
//a pasar por parametro

abstract class UseCase<Type,Params>{
  Future<Type> call({Params params});
}