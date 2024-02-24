Class {
	#name : #Viaje,
	#superclass : #Object,
	#instVars : [
		'nombreViaje',
		'costoPorPersona',
		'valorImpuestos'
	],
	#category : #'SistemaAgencia-Modelo'
}

{ #category : #constructor }
Viaje class >> crear: unNombre conCosto: unCosto conValorImpuestos: unosImpuestos [
|nuevoViaje|
nuevoViaje := self new.
nuevoViaje inicializar: unNombre conCosto: unCosto conValorImpuestos: unosImpuestos.
^ nuevoViaje.
]

{ #category : #queries }
Viaje >> buscarInfo [
|rta|
rta := nombreViaje, ' - Costo: $', costoPorPersona asString, ' - Impuestos: $', valorImpuestos asString.
^ rta.
]

{ #category : #queries }
Viaje >> buscarInfo: fecha1 conFecha: fecha2 [
  | rta |
  rta := nil.
  rta := nombreViaje asString, ' - Costo: $' , costoPorPersona asString, ' - Impuestos: $' , valorImpuestos asString.
  ^ rta.
]

{ #category : #queries }
Viaje >> buscarPrecio [
^ costoPorPersona + valorImpuestos.
]

{ #category : #'as yet unclassified' }
Viaje >> buscarValorTotal [
^ costoPorPersona + valorImpuestos.
]

{ #category : #queries }
Viaje >> buscarViaje: unNombre [
|rta|
rta := false.
(nombreViaje = unNombre) ifTrue: [rta := true].
^ rta.
]

{ #category : #queries }
Viaje >> calcularReembolso:cantPersonas reembolso: unReembolso [
|montoT|
montoT:= cantPersonas * costoPorPersona.
montoT :=(unReembolso * montoT)/100.
^montoT 
]

{ #category : #'as yet unclassified' }
Viaje >> getCostoPersona [
^costoPorPersona
]

{ #category : #queries }
Viaje >> getNombre [
^nombreViaje.
]

{ #category : #queries }
Viaje >> getValorImpuesto [
^valorImpuestos
]

{ #category : #queries }
Viaje >> inicializar: unNombre conCosto: unCosto conValorImpuestos: unosImpuestos [
nombreViaje := unNombre.
costoPorPersona := unCosto.
valorImpuestos := unosImpuestos.
]

{ #category : #queries }
Viaje >> recuperarViaje: unNombre [
|retorno|
retorno := false.
(nombreViaje = unNombre) ifTrue:[retorno := true].
^ retorno.
]
