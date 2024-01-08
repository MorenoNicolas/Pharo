Class {
	#name : #Interfaz,
	#superclass : #Morph,
	#instVars : [
		'nombre',
		'ventana'
	],
	#category : #'SistemaAgencia-GUI'
}

{ #category : #constructor }
Interfaz class >> crear: ventanaIn [
|temporal|
temporal := self new.
temporal iniciar.
temporal setVentana: ventanaIn .
^temporal.
]

{ #category : #'as yet unclassified' }
Interfaz >> comprobarNombre: nombreDato [
^nombreDato = nombre .
]

{ #category : #'as yet unclassified' }
Interfaz >> iniciar [
|boton|
self extent: 480@654.
self borderWidth: 2.
self color: Color gray.
self borderColor: Color black.
self iniciarInterfaz.
boton := Boton2 crear: 'X'.
self addMorphFront: boton.
boton position: 449@1.
boton mouseAction: [ self delete   ]
]

{ #category : #'as yet unclassified' }
Interfaz >> iniciarInterfaz [
"metodo sobreescrito"
]

{ #category : #initialization }
Interfaz >> setVentana: ventanaIn [
ventana:=ventanaIn .
]
