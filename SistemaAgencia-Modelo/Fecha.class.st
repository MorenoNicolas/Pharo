Class {
	#name : #Fecha,
	#superclass : #Object,
	#instVars : [
		'fechaSalida',
		'cupoCorrespondiente'
	],
	#category : #'SistemaAgencia-Modelo'
}

{ #category : #constructor }
Fecha class >> crear: unaFecha conCupo: unCupo [
|nuevaFecha|
nuevaFecha := self new.
nuevaFecha inicializar: unaFecha conCupo: unCupo.
^ nuevaFecha.
]

{ #category : #queries }
Fecha >> buscarFecha [
|rta4|
rta4 := fechaSalida asString, ' - Cupo: ', cupoCorrespondiente asString.
^ rta4.
]

{ #category : #'as yet unclassified' }
Fecha >> buscarFecha: fechaIn [
^fechaIn = fechaSalida. 
]

{ #category : #'as yet unclassified' }
Fecha >> devolverCupo: unaCantidad [
cupoCorrespondiente := cupoCorrespondiente + unaCantidad.
]

{ #category : #'as yet unclassified' }
Fecha >> getCupo [
^cupoCorrespondiente.
]

{ #category : #'as yet unclassified' }
Fecha >> getFechaSalida [
^fechaSalida.
]

{ #category : #queries }
Fecha >> inicializar: unaFecha conCupo: unCupo [
fechaSalida := unaFecha.
cupoCorrespondiente := unCupo.
]

{ #category : #'as yet unclassified' }
Fecha >> restarCupo: unaCantidad [
cupoCorrespondiente := cupoCorrespondiente - unaCantidad.
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
