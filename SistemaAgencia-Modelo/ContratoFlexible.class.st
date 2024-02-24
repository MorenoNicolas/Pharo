Class {
	#name : #ContratoFlexible,
	#superclass : #Contrato,
	#instVars : [
		'plusPagado'
	],
	#category : #'SistemaAgencia-Modelo'
}

{ #category : #constructor }
ContratoFlexible class >> crear: unNumero conViajeContratado: unViaje conFechaViaje: unaFechaViaje conCantPersonas: unaCantPersonas conCantCuotas: unaCantCuotas conFechaProxVenc: unaFechaVenc  conPlus: unPlus [
|nuevoContratoFlexible|
nuevoContratoFlexible := self crear: unNumero conViajeContratado: unViaje conFechaViaje: unaFechaViaje conCantPersonas: unaCantPersonas conCantCuotas: unaCantCuotas conFechaProxVenc: unaFechaVenc .
nuevoContratoFlexible inicializar: unPlus.
^ nuevoContratoFlexible.
]

{ #category : #queries }
ContratoFlexible >> inicializar: unPlus [
plusPagado := unPlus.
]

{ #category : #'as yet unclassified' }
ContratoFlexible >> modificarFecha: unaFecha [
fechaViaje := unaFecha.
]

{ #category : #'as yet unclassified' }
ContratoFlexible >> pagarPlus [
plusPagado := true.
]

{ #category : #queries }
ContratoFlexible >> reprogramaViajeoCancelar: nuevaFecha deseaCancelar: cancelar [
|reembolso montoT|
montoT:=0.
reembolso:=0.
 (plusPagado ) ifTrue: [ fechaViaje := nuevaFecha ] ifFalse: [ 
	(cancelar ) ifTrue: [
		 (fechaViaje > 90) ifTrue: [ reembolso:= 75 ].
		 (fechaViaje <90 & fechaViaje > 60)ifTrue: [  reembolso:= 50 ].
		 (fechaViaje < 30)ifTrue:[reembolso := 25].
		 montoT := viajeContratado calcularReembolso: cantPersonas  reembolso: reembolso 
		 ] ].
^montoT.
]
