Class {
	#name : #Interfaz,
	#superclass : #Morph,
	#instVars : [
		'nombre',
		'datosEmpresa'
	],
	#category : #'SistemaAgencia-GUI'
}

{ #category : #constructor }
Interfaz class >> crear: empresaIn [
|temporal|
temporal := self new.
temporal iniciar: empresaIn.
^temporal.
]

{ #category : #constructor }
Interfaz class >> crear: empresaIn conUsuario: usuarioIn [
|temporal|
temporal := self new.
temporal iniciar: empresaIn  dniUsuario: usuarioIn.
^temporal.
]

{ #category : #constructor }
Interfaz class >> crear: empresaIn conUsuario: usuarioIn x:x y:y [
|temporal|
temporal := self new.
temporal iniciar: empresaIn  dniUsuario: usuarioIn x:x y:y.
^temporal.
]

{ #category : #constructor }
Interfaz class >> crear: empresaIn x:x y:y [
|temporal|
temporal := self new.
temporal iniciar: empresaIn  x:x  y:y .
^temporal.
]

{ #category : #initialization }
Interfaz >> añadirUnMorph: morphIn alLado: otroMorph [
morphIn position: otroMorph position + (otroMorph width + 10@0).
self addMorph: morphIn behind: otroMorph

]

{ #category : #initialization }
Interfaz >> añadirUnMorph: unMorph conMargen: unMargen [
unMorph position: (10@(self lastSubmorph bottom + unMargen)).
self addMorphBack: unMorph. 
]

{ #category : #initialization }
Interfaz >> añadirUnMorphCentrado: unMorph conMargen: unMargen [
unMorph position: (((self width - unMorph width) / 2)@(self lastSubmorph bottom + unMargen)).
self addMorphBack: unMorph.
]

{ #category : #initialization }
Interfaz >> borrarMorphs [
self submorphs do: [ :each | each delete ].

]

{ #category : #'as yet unclassified' }
Interfaz >> iniciar: empresaIn [
|boton|
datosEmpresa := empresaIn.
self extent: 660@454.
self borderWidth: 2;useRoundedCorners .
self color: Color gray.
self borderColor: Color black.
boton := BotonCerrar crear: 'X'.
self addMorphFront: boton.
boton position: self topRight-(boton width@0).
boton mouseAction: [ self delete ].
]

{ #category : #'as yet unclassified' }
Interfaz >> iniciar: empresaIn x:x y:y [
|boton|
datosEmpresa := empresaIn.
self extent: x@y.
self borderWidth: 2;useRoundedCorners .
self color: Color gray.
self borderColor: Color black.
boton := BotonCerrar crear: 'X'.
self addMorphFront: boton.
boton position: self topRight-(boton width@0).
boton mouseAction: [ self delete ].
]

{ #category : #'as yet unclassified' }
Interfaz >> mostrarTabla: coleccion [
|objetoMorph posicion tabla|
posicion := '' asMorph.
posicion position: (20@(self lastSubmorph bottom + 0)).
tabla := ScrollMorph crear: 900 y: 250 cabecera: 'Viajes disponibles'.
coleccion do: [ :objeto | 
	objetoMorph := objeto asMorph.
	objetoMorph position: posicion position + (0 @ 20).
	posicion position: posicion position + (0 @ 20).
	tabla agregarTexto: objeto.
].
^tabla.
]

{ #category : #'as yet unclassified' }
Interfaz >> mostrarTabla: coleccion tituloCabecera: tituloIn [
|objetoMorph posicion tabla|
posicion := '' asMorph.
posicion position: (20@(self lastSubmorph bottom + 0)).
tabla := ScrollMorph crear: 900 y: 250 cabecera: tituloIn.
coleccion do: [ :objeto | 
	objetoMorph := objeto asMorph.
	objetoMorph position: posicion position + (0 @ 20).
	posicion position: posicion position + (0 @ 20).
	tabla agregarTexto: objeto.
].
^tabla.
]

{ #category : #'as yet unclassified' }
Interfaz >> mostrarTabla: coleccion tituloCabecera: tituloIn x:x y:y [
|objetoMorph posicion tabla|
posicion := '' asMorph.
posicion position: (20@(self lastSubmorph bottom + 0)).
tabla := ScrollMorph crear: x y: y cabecera: tituloIn.
coleccion do: [ :objeto | 
	objetoMorph := objeto asMorph.
	objetoMorph position: posicion position + (0 @ 20).
	posicion position: posicion position + (0 @ 20).
	tabla agregarTexto: objeto.
].
^tabla.
]
