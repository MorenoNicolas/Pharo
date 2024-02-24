Class {
	#name : #VistaInicioSesion,
	#superclass : #Interfaz,
	#instVars : [
		'txtBienvenida',
		'campoDni',
		'campoContraseña',
		'botonRegistrar',
		'botonIniciarSesion',
		'botonAdmin',
		'usuario'
	],
	#category : #'SistemaAgencia-GUI'
}

{ #category : #'as yet unclassified' }
VistaInicioSesion class >> crearVistaInicio: empresaIn [
|vista|
vista:= self crear: empresaIn.
^empresaIn.
]

{ #category : #initialization }
VistaInicioSesion >> iniciar: empresaIn [

self iniciar: empresaIn x: 300 y: 335.

txtBienvenida := StringMorph new contents: 'Bienvenido a EMPRESA TURISMO N&F'; font: (LogicalFont familyName: 'Source Sans Pro' pointSize: 13).
self añadirUnMorphCentrado: txtBienvenida conMargen: 0.

campoDni := RubTextFieldMorph new extent: 275@20; ghostText:'Ingrese Dni'.
self añadirUnMorphCentrado: campoDni conMargen: 40.

campoContraseña := RubTextFieldMorph new extent: 275@20; ghostText:'Ingrese Contraseña'.
self añadirUnMorphCentrado: campoContraseña  conMargen: 20.

botonIniciarSesion := BotonGenerico crear: 'Iniciar Sesion' x:175 y:30.
self añadirUnMorphCentrado: botonIniciarSesion  conMargen: 30.
botonIniciarSesion mouseAction: [self iniciarSesion: campoDni conContraseña: campoContraseña].

botonRegistrar := BotonGenerico crear: 'Registrarse' x:175 y:30.
self añadirUnMorphCentrado: botonRegistrar  conMargen: 20.
botonRegistrar mouseAction:[self delete. VistaRegistro crearVistaRegistro: empresaIn].

botonAdmin := BotonGenerico crear: 'Modo Admin' x:100 y:30.
botonAdmin color: Color yellow.
self añadirUnMorphCentrado: botonAdmin  conMargen: 20.
botonAdmin mouseAction: [ self delete. VistaMenuAdministrador crearVistaMenuAdministrador: empresaIn ].

self openCenteredInWorld.
]

{ #category : #'as yet unclassified' }
VistaInicioSesion >> iniciarSesion: unCampoDni conContraseña: unCampoContraseña [
|dniNumero cliente contraNumero|

((unCampoDni text isEmpty)or:(unCampoContraseña text isEmpty)) ifTrue: [ 
	CartelError new iniciarError: 'No se Ingreso un Dni o Contraseña' x:200  y:40
] ifFalse: [ 
	dniNumero := unCampoDni getText asNumber.
	contraNumero := unCampoContraseña getText asNumber.
	cliente:=datosEmpresa buscarClienteDesdeEmpresa: dniNumero.
	(cliente)ifNotNil: [
		(cliente getContraseña = contraNumero) ifTrue: [ 
			self delete.
			(VistaMenuUsuario) crearVistaMenuUsuario: datosEmpresa conDni: dniNumero. 
		] ifFalse: [ 
			CartelError new iniciarError: 'Contraseña Incorrecta' x:200  y:40.
		]
	] ifNil: [
		CartelError new iniciarError: 'Usuario no encontrado' x:200  y:40.
	] 
].
]
