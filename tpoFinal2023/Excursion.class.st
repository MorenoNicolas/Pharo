Class {
	#name : #Excursion,
	#superclass : #Object,
	#instVars : [
		'nombreExcursion',
		'costoExcursion',
		'cantPersonasExcursion'
	],
	#category : #tpoFinal2023
}

{ #category : #constructor }
Excursion class >> crear: unNombre conCosto: unCosto conCantPersonas: unaCantidad [
|nuevaExcursion|
nuevaExcursion := self new.
nuevaExcursion inicializar: unNombre conCosto: unCosto conCantPersonas: unaCantidad.
^ nuevaExcursion.
]

{ #category : #queries }
Excursion >> buscarExcursiones [
|rta4|
rta4 := 'Nombre de la excursion ',nombreExcursion asString,', con un costo de $',costoExcursion asString,' con ',cantPersonasExcursion asString,' personas.'.
^ rta4.
]

{ #category : #queries }
Excursion >> inicializar: unNombre conCosto: unCosto conCantPersonas: unaCantidad [
nombreExcursion := unNombre.
costoExcursion := unCosto.
cantPersonasExcursion := unaCantidad.
]
