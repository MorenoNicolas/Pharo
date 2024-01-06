Class {
	#name : #ViajeroFrecuente,
	#superclass : #Cliente,
	#instVars : [
		'millas'
	],
	#category : #SistemaAgencia
}

{ #category : #constructor }
ViajeroFrecuente class >> crear: unDni conApellido: unApellido conCiudad: unaCiudad conDatos: unosDatos conMillas: unasMillas [
|nuevoViajeroFrecuente|
nuevoViajeroFrecuente := self crear: unDni conApellido: unApellido conCiudad: unaCiudad conDatos: unosDatos.
nuevoViajeroFrecuente inicializar: unasMillas.
^ nuevoViajeroFrecuente.
]

{ #category : #queries }
ViajeroFrecuente >> efectivizacionEnCliente: numContrato [
(super efectivizacionEnCliente: numContrato)ifTrue: [ millas := millas + 10 ] .




]

{ #category : #queries }
ViajeroFrecuente >> inicializar: unasMillas [
millas := unasMillas.
]

{ #category : #queries }
ViajeroFrecuente >> modificacionEnCliente: numContrato deseaCancelar: cancelar conNuevaFecha: nuevaFecha [
|montoT|
montoT:= super modificacionEnCliente: numContrato deseaCancelar: cancelar conNuevaFecha: nuevaFecha.
millas = millas + montoT.
]
