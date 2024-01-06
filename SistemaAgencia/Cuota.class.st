Class {
	#name : #Cuota,
	#superclass : #Object,
	#instVars : [
		'monto',
		'fechaDePago'
	],
	#category : #SistemaAgencia
}

{ #category : #constructor }
Cuota class >> crear: unMonto [
|nuevaCuota|
nuevaCuota := self new.
nuevaCuota inicializar: unMonto.
^ nuevaCuota.
]

{ #category : #constructor }
Cuota class >> crear: unMonto unaFechaPago: conFechaPago [
|nuevaCuota|
nuevaCuota := self new.
nuevaCuota inicializar: unMonto conFechaPago: conFechaPago.
^ nuevaCuota.
]

{ #category : #queries }
Cuota >> inicializar: unMonto [
monto := unMonto.
fechaDePago := nil.
]

{ #category : #queries }
Cuota >> inicializar: unMonto conFechaPago:unaFechaPago [
monto := unMonto.
fechaDePago := unaFechaPago.
fechaDePago := nil.
]

{ #category : #queries }
Cuota >> registrarPago [
fechaDePago := Date today.
]
