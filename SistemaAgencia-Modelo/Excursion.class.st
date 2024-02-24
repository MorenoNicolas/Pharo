Class {
	#name : #Excursion,
	#superclass : #Object,
	#instVars : [
		'nombreExcursion',
		'costoExcursion',
		'cantPersonasExcursion'
	],
	#category : #'SistemaAgencia-Modelo'
}

{ #category : #constructor }
Excursion class >> crear: unNombre conCosto: unCosto conCantPersonas: unaCantidad [
|nuevaExcursion|
nuevaExcursion := self new.
nuevaExcursion inicializar: unNombre conCosto: unCosto conCantPersonas: unaCantidad.
^ nuevaExcursion.
]

{ #category : #'as yet unclassified' }
Excursion >> buscarExcursionConNombre: unNombre [
^ nombreExcursion = unNombre.
]

{ #category : #queries }
Excursion >> buscarExcursiones [
|rta4|
rta4 := nombreExcursion asString,' - Costo: $',costoExcursion asString,' - Cantidad de personas: ',cantPersonasExcursion asString.
^ rta4.
]

{ #category : #'as yet unclassified' }
Excursion >> getCantPersonasExcursion [
^cantPersonasExcursion.
]

{ #category : #'as yet unclassified' }
Excursion >> getCostoExcursion [
^ costoExcursion.
]

{ #category : #queries }
Excursion >> inicializar: unNombre conCosto: unCosto conCantPersonas: unaCantidad [
nombreExcursion := unNombre.
costoExcursion := unCosto.
cantPersonasExcursion := unaCantidad.
]

{ #category : #'as yet unclassified' }
Excursion >> restarPersonasDeExcursion: unaCantidad [.
cantPersonasExcursion := cantPersonasExcursion - unaCantidad.
]
