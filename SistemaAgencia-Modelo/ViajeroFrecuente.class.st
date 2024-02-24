Class {
	#name : #ViajeroFrecuente,
	#superclass : #Cliente,
	#instVars : [
		'millas'
	],
	#category : #'SistemaAgencia-Modelo'
}

{ #category : #constructor }
ViajeroFrecuente class >> crear: unDni conApellido: unApellido conCiudad: unaCiudad conDatos: unosDatos conMillas: unasMillas conContra: unaContra [ 
|nuevoViajeroFrecuente|
nuevoViajeroFrecuente := self crear: unDni conApellido: unApellido conCiudad: unaCiudad conDatos: unosDatos conContra: unaContra .
nuevoViajeroFrecuente inicializar: unasMillas.
^ nuevoViajeroFrecuente.
]

{ #category : #'as yet unclassified' }
ViajeroFrecuente >> eliminaContrato: numeroContratoIn conMillas: unaCantidad [
colContratos remove: (self buscarContratoEnCliente: numeroContratoIn) ifAbsent: [^false].
millas := millas + unaCantidad.
^true
]

{ #category : #'as yet unclassified' }
ViajeroFrecuente >> getMillas [
^millas.
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

{ #category : #'as yet unclassified' }
ViajeroFrecuente >> restarMillas: cant [
millas := millas - cant.
]

{ #category : #'as yet unclassified' }
ViajeroFrecuente >> sumarMillas: cant [
millas := millas + cant.
]
