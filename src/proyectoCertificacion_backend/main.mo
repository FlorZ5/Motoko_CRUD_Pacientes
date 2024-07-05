import Text "mo:base/Text";
import HashMap "mo:base/HashMap";
import Nat32 "mo:base/Nat32";
import Nat64 "mo:base/Nat64";
import Debug "mo:base/Debug";
import Iter "mo:base/Iter";
import Nat8 "mo:base/Nat8";

actor Pacientes {

  type Id = Nat32;

  type PacienteInfo = {
    nombre : Text;
    apellidoMaterno : Text;
    apellidoPaterno : Text;
    edad: Nat8;
    direccion : Text;
    telefono : Nat64;
    correo : Text;
  };

  stable var ID: Id = 0;

  let IDGenerate = HashMap.HashMap<Text, PacienteInfo>(0, Text.equal, Text.hash);

  private func generaID() : Nat32 {
    ID += 1;
    return ID;
  };

  public query func getID() : async Nat32 {
    return ID;
  };

  public shared func crearRegistro(
    nombre : Text,
    apellidoMaterno : Text,
    apellidoPaterno : Text,
    edad: Nat8,
    direccion : Text,
    telefono : Nat64,
    correo: Text
  ) : async Bool {
    if (nombre.size() == 0 or apellidoMaterno.size() == 0 or apellidoPaterno.size() == 0 or direccion.size() == 0 or correo.size() == 0) {
      Debug.print("Error: Todos los campos son obligatorios.");
      return false;
    };

    if (nombre.size() < 3 or nombre.size() > 50) {
      Debug.print("Error: El nombre debe tener entre 3 y 50 caracteres.");
      return false;
    };

    if (apellidoPaterno.size() < 3 or apellidoPaterno.size() > 50) {
      Debug.print("Error: El apellido paterno debe tener entre 3 y 50 caracteres.");
      return false;
    };

    if (apellidoMaterno.size() < 3 or apellidoMaterno.size() > 50) {
      Debug.print("Error: El apellido materno debe tener entre 3 y 50 caracteres.");
      return false;
    };

    if (edad < 0 or edad > 110) {
      Debug.print("Error: La edad debe estar entre 0 y 120.");
      return false;
    };

    if (direccion.size() < 10 or direccion.size() > 100) {
      Debug.print("Error: La dirección debe tener entre 10 y 100 caracteres.");
      return false;
    };

    if (telefono < 1000000000 or telefono > 9999999999) {
      Debug.print("Error: El teléfono debe ser un número de 10 dígitos.");
      return false;
    };

    //Esta es la que no jalaba, ya la arregle con mucho cariño para ti :) <3
    if (
      correo.size() < 13 or correo.size() > 100 or
      not Text.contains(correo, #text "@") or
      not Text.contains(correo, #text ".")
    ) {
      Debug.print("Error: El formato para el correo debe contener los simbolos '@' y '.' y tener entre 13 y 100 caracteres ");
      return false;
    };

    let register = { 
      nombre = nombre; 
      apellidoMaterno = apellidoMaterno; 
      apellidoPaterno = apellidoPaterno; 
      edad = edad; 
      direccion = direccion; 
      telefono = telefono; 
      correo = correo
    };

    IDGenerate.put(Nat32.toText(generaID()), register);

    Debug.print("Paciente registrado correctamente, ID: " # Nat32.toText(ID));
    return true;
  };

  public query func getPaciente(id: Text) : async ?PacienteInfo {
    let paciente: ?PacienteInfo = IDGenerate.get(id);
    return paciente;
  };

  public query func getPacientes() : async [(Text, PacienteInfo)] {
    let pacienteIter: Iter.Iter<(Text, PacienteInfo)> = IDGenerate.entries();
    let pacienteArray: [(Text, PacienteInfo)] = Iter.toArray(pacienteIter);
    return pacienteArray;
  };

public shared func updatePaciente(
  id: Text,
  nombre : Text,
  apellidoMaterno : Text,
  apellidoPaterno : Text,
  edad: Nat8,
  direccion : Text,
  telefono : Nat64,
  correo: Text
) : async Bool {
  if (nombre.size() == 0 or apellidoMaterno.size() == 0 or apellidoPaterno.size() == 0 or direccion.size() == 0 or correo.size() == 0) {
    Debug.print("Error: Todos los campos son obligatorios.");
    return false;
  };

  if (nombre.size() < 3 or nombre.size() > 50) {
    Debug.print("Error: El nombre debe tener entre 3 y 50 caracteres.");
    return false;
  };

  if (apellidoPaterno.size() < 3 or apellidoPaterno.size() > 50) {
    Debug.print("Error: El apellido paterno debe tener entre 3 y 50 caracteres.");
    return false;
  };

  if (apellidoMaterno.size() < 3 or apellidoMaterno.size() > 50) {
    Debug.print("Error: El apellido materno debe tener entre 3 y 50 caracteres.");
    return false;
  };

  if (edad < 0 or edad > 110) {
    Debug.print("Error: La edad debe estar entre 0 y 120.");
    return false;
  };

  if (direccion.size() < 10 or direccion.size() > 100) {
    Debug.print("Error: La dirección debe tener entre 10 y 100 caracteres.");
    return false;
  };

  if (telefono < 1000000000 or telefono > 9999999999) {
    Debug.print("Error: El teléfono debe ser un número de 10 dígitos.");
    return false;
  };

  if (
    correo.size() < 13 or correo.size() > 100 or
    not Text.contains(correo, #text "@") or
    not Text.contains(correo, #text ".")
  ) {
    Debug.print("Error: El formato para el correo debe contener los simbolos '@' y '.' y tener entre 13 y 100 caracteres ");
    return false;
  };

  let paciente: ?PacienteInfo = IDGenerate.get(id);

  switch (paciente) {
    case (null) {
	Debug.print("El paciente con el ID: " # id # " no se ha encontrado");
      return false;
    };
    case (?currentPacient) {
      let newData: PacienteInfo = {
        nombre = nombre; 
        apellidoMaterno = apellidoMaterno; 
        apellidoPaterno = apellidoPaterno; 
        edad = edad; 
        direccion = direccion; 
        telefono = telefono; 
        correo = correo
      };
      IDGenerate.put(id, newData);
      Debug.print("Se actualizó la información del paciente con el ID: " # id);
      return true;
    };
  };
};

  public func deletePaciente(id: Text) : async Bool {
    let paciente: ?PacienteInfo = IDGenerate.get(id);
    switch (paciente) {
      case (null) {
		Debug.print("El paciente con el ID: " # id # " no se ha encontrado");
        return false;
      };
      case (_) {
        ignore IDGenerate.remove(id);
        Debug.print("Paciente con ID: " # id # " eliminado correctamente.");
        return true;
      };
    };
  };

};
