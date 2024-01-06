Class {
	#name : #Fecha,
	#superclass : #Object,
	#instVars : [
		'fechaSalida',
		'cupoCorrespondiente'
	],
	#category : #SistemaAgencia
}

{ #category : #constructor }
Fecha class >> crear: unaFecha conCupo: unCupo [
|nuevaFecha|
nuevaFecha := self new.
nuevaFecha inicializar: unaFecha conCupo: unCupo.
^ nuevaFecha.
]

{ #category : #queries }
Fecha >> inicializar: unaFecha conCupo: unCupo [
fechaSalida := unaFecha.
cupoCorrespondiente := unCupo.
]

{ #category : #queries }
Fecha >> verificarFecha [
|retorno|
retorno := false.
(cupoCorrespondiente > 0) ifTrue:[retorno := true].
^ retorno.
]

{ #category : #queries }
Fecha >> verificarFecha: fecha1 conFecha: fecha2 [
|retorno|
retorno := false.
((cupoCorrespondiente > 0) & (fechaSalida >= fecha1) & (fechaSalida <= fecha2)) ifTrue:[retorno := true].
^ retorno.
]
