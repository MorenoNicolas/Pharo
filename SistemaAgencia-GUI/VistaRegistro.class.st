Class {
	#name : #VistaRegistro,
	#superclass : #Interfaz,
	#instVars : [
		'txtBienvenida',
		'campoApellido',
		'campoDni',
		'campoCiudad',
		'campoTelefono',
		'botonRegistrar',
		'campoContra',
		'botonVolver'
	],
	#category : #'SistemaAgencia-GUI'
}

{ #category : #'as yet unclassified' }
VistaRegistro class >> crearVistaRegistro: empresaIn [
|vista|
vista:= self crear: empresaIn .
^empresaIn.
]

{ #category : #initialization }
VistaRegistro >> iniciar: empresaIn [
self iniciar: empresaIn x: 325 y: 390.

txtBienvenida := TextMorph new contents: 'Bienvenido a EMPRESA TURISMO N&F'.
self añadirUnMorphCentrado: txtBienvenida  conMargen:5. 

campoApellido := RubTextFieldMorph new extent: 300@20; ghostText:'Ingrese su Apellido'.
self añadirUnMorphCentrado: campoApellido conMargen: 30.

campoDni := RubTextFieldMorph new extent: 300@20; ghostText:'Ingrese su DNI'.
self añadirUnMorphCentrado: campoDni  conMargen: 20.

campoCiudad := RubTextFieldMorph new extent: 300@20; ghostText:'Ingrese su Ciudad'.
self añadirUnMorphCentrado: campoCiudad  conMargen: 20.

campoTelefono := RubTextFieldMorph new extent: 300@20; ghostText:'Ingrese su Numero de Telefono'.
self añadirUnMorphCentrado: campoTelefono  conMargen: 20.

campoContra  := RubTextFieldMorph new extent: 300@20; ghostText:'Ingrese Contraseña'.
self añadirUnMorphCentrado: campoContra  conMargen: 20.

botonRegistrar := BotonGenerico crear: 'Registrarse' x:175 y:30.
self añadirUnMorphCentrado: botonRegistrar conMargen: 30.
botonRegistrar  color: Color paleGreen.
botonRegistrar mouseAction:[self registrarUsuario: empresaIn conApellido: campoApellido conDni: campoDni conCiudad: campoCiudad conTelefono: campoTelefono conContra: campoContra].

botonVolver := BotonGenerico crear: 'Volver Atras' x:175 y:30.
self añadirUnMorphCentrado: botonVolver conMargen: 10.
botonVolver color: Color paleOrange.
botonVolver mouseAction:[self delete. (VistaInicioSesion) crearVistaInicio: empresaIn].

self openCenteredInWorld.
]

{ #category : #'as yet unclassified' }
VistaRegistro >> registrarUsuario: empresaIn conApellido: unCampoApellido conDni: unCampoDni conCiudad: unCampoCiudad conTelefono: unCampoTelefono conContra: unaContra [
|unCliente nuevoCliente|

((unCampoApellido text isEmpty) | (unCampoDni text isEmpty) | (unCampoCiudad text isEmpty) | (unCampoTelefono text isEmpty) | (unaContra text isEmpty)) ifTrue: [ 
	CartelError new iniciarError: 'Uno de los campos esta vacio. Ingrese correctamente los datos' x:400  y:60.
] ifFalse: [ 
	unCliente := datosEmpresa buscarClienteDesdeEmpresa: (unCampoDni getText) asNumber.
	(unCliente)ifNotNil: [
		CartelError new iniciarError: 'Ya existe un Cliente con el DNI ', (unCampoDni getText) asString x:200  y:60.	
	] ifNil: [
		nuevoCliente := (Cliente) crear: (unCampoDni getText) asNumber conApellido: (unCampoApellido getText) asString conCiudad: (unCampoCiudad getText) asString conDatos: (unCampoTelefono  getText) asNumber conContra: (unaContra getText) asNumber.
	datosEmpresa agregarCliente: nuevoCliente.
	self delete.
	VistaInicioSesion crear: datosEmpresa.
	CartelError new iniciarError: 'El Cliente se registro correctamente' x:300  y:60. "CAMBIAR ESTO"
	]
]
]
