Class {
	#name : #Boton2,
	#superclass : #BotonBase,
	#category : #'SistemaAgencia-GUI'
}

{ #category : #'as yet unclassified' }
Boton2 >> iniciar: string [
nombre:= string.
self label: nombre.
self extent:30@30.
self color: Color red.
self borderWidth: 1.
self borderColor: Color gray.
self roundedCorners: 300.
]
