Class {
	#name : #BotonBase,
	#superclass : #SimpleButtonMorph,
	#instVars : [
		'bloque',
		'nombre'
	],
	#category : #'SistemaAgencia-GUI'
}

{ #category : #constructor }
BotonBase class >> crear: string [
|button|
button:= self new.
button iniciar: string .
^button.
]

{ #category : #'as yet unclassified' }
BotonBase >> getNombre [
^nombre.
]

{ #category : #'as yet unclassified' }
BotonBase >> iniciar: unString [
nombre:= unString .

]

{ #category : #'as yet unclassified' }
BotonBase >> mouseAction: bloqueIn [
bloque:=bloqueIn .
]

{ #category : #'event handling' }
BotonBase >> mouseUp: evento [
super mouseUp: evento.
bloque value.
]
