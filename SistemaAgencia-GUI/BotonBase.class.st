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
BotonBase class >> crear: unSistema conDni: unDni conContrasena: unaContrasena [
|button|
button:= self new.
button iniciar: unSistema conDni: unDni conContrasena: unaContrasena.
^button.
]

{ #category : #constructor }
BotonBase class >> crear: string x:x y:y [
|button|
button:= self new.
button iniciar: string x:x  y:y  .
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
BotonBase >> iniciar:unString x:x  y:y [
nombre:= unString .
self extent: x@y.

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
