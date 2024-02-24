Class {
	#name : #CartelError,
	#superclass : #Morph,
	#instVars : [
		'cartel'
	],
	#classInstVars : [
		'cartel'
	],
	#category : #'SistemaAgencia-GUI'
}

{ #category : #'as yet unclassified' }
CartelError class >> errorTipo: string x:x y:y [
|error |
error  := self new.
error iniciarError:string  x:x  y:y.   
^error.
]

{ #category : #'as yet unclassified' }
CartelError >> iniciarError: tipo x:x y:y [
|boton|
self extent: x@y.
self borderWidth: 3.
self color: Color paleRed.
self borderColor: Color black.
boton := BotonGenerico crear:'Cerrar' x:40  y:15 .
boton color: Color red.
self addMorphFront: boton.
boton position: self topRight-(boton width@0).
boton mouseAction: [ self delete ].
cartel := TextMorph new contents: tipo.
self addMorphBack: cartel.
cartel position: ((self width - cartel width) / 2) @ ((self height - cartel height) / 2) .
self openCenteredInWorld.
]
