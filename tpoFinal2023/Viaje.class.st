Class {
	#name : #Viaje,
	#superclass : #Object,
	#instVars : [
		'nombreViaje',
		'costoPorPersona',
		'valorImpuestos'
	],
	#category : #tpoFinal2023
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
rta := 'Viaje: ', nombreViaje, ' con un costo de $', costoPorPersona, ' por persona y con un valor de impuestos de $', valorImpuestos.
^ rta.
]

{ #category : #queries }
Viaje >> buscarInfo: fecha1 conFecha: fecha2 [
  | rta |
  rta := nil.
  rta := 'Viaje: ' , nombreViaje asString, ' con un costo de $' , costoPorPersona asString, ' por persona y con un valor de impuestos de $' , valorImpuestos asString, '.'.
  ^ rta.
]

{ #category : #queries }
Viaje >> buscarPrecio [
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

{ #category : #queries }
Viaje >> inicializar: unNombre conCosto: unCosto conValorImpuestos: unosImpuestos [
nombreViaje := unNombre.
costoPorPersona := unCosto.
valorImpuestos := unosImpuestos.
]

{ #category : #queries }
Viaje >> modificar: opcion2 conCosto: unCosto conValorImpuestos: unosImpuestos conCiudad: unaCiudad conFechaSalida: fecha1 conFechaRegreso: fecha2 conDisponibilidad: unaDisponibilidad conDias: unosDias conEtapas: unasEtapas conExcursiones: unasExcursiones conFechas: unasFechas [
self subclassResponsibility.
]

{ #category : #queries }
Viaje >> recuperarViaje: unNombre [
|retorno|
retorno := false.
(nombreViaje = unNombre) ifTrue:[retorno := true].
^ retorno.
]
