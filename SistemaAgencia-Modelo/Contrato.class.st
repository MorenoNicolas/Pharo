Class {
	#name : #Contrato,
	#superclass : #Object,
	#instVars : [
		'numContrato',
		'fechaCreacion',
		'viajeContratado',
		'fechaViaje',
		'cantPersonas',
		'cantCuotas',
		'fechaProxVencimiento',
		'colCuotas',
		'colExcursionesContratadas',
		'estaPagado'
	],
	#category : #'SistemaAgencia-Modelo'
}

{ #category : #constructor }
Contrato class >> crear: unNumero conViajeContratado: unViaje conFechaViaje: unaFechaViaje conCantPersonas: unaCantPersonas conCantCuotas: unaCantCuotas conFechaProxVenc: unaFechaVenc [
|nuevoContrato|
nuevoContrato := self new.
nuevoContrato inicializar: unNumero conViajeContratado: unViaje conFechaViaje: unaFechaViaje conCantPersonas: unaCantPersonas conCantCuotas: unaCantCuotas conFechaProxVenc: unaFechaVenc.
^ nuevoContrato.
]

{ #category : #queries }
Contrato >> agregarCuota: cuotaNueva [ 
colCuotas add: cuotaNueva .
]

{ #category : #queries }
Contrato >> buscarContrato: numeroContrato [ 
^ numeroContrato = numContrato .
]

{ #category : #queries }
Contrato >> buscarContrato: fecha1 conFecha2: fecha2 [
|rta|
rta := nil.
(fechaViaje >= fecha1 & fechaViaje <= fecha2) ifTrue:[rta := viajeContratado buscarInfo].
^ rta.
]

{ #category : #'as yet unclassified' }
Contrato >> buscarInfoContrato [
|rta|
(self isKindOf: ContratoFlexible) ifTrue: [
	rta := numContrato asString, ' (Flexible) - Fecha de Creacion: ',fechaCreacion asString, ' - Nombre Viaje: ', viajeContratado getNombre, ' - Cuotas a Pagar: ',colCuotas size asString .
] ifFalse:[
	rta := numContrato asString, ' (Comun) - Fecha de Creacion: ',fechaCreacion asString, ' - Nombre Viaje: ', viajeContratado getNombre, ' - Cuotas a Pagar: ',colCuotas size asString .
].
^ rta.
]

{ #category : #'as yet unclassified' }
Contrato >> buscarInfoViaje [
^ viajeContratado.
]

{ #category : #queries }
Contrato >> buscarPrecioViaje [
|precio|
precio := viajeContratado buscarPrecio.
^ precio.

]

{ #category : #'as yet unclassified' }
Contrato >> buscarValorReembolso [
|reembolso|
reembolso := 0.
((Date today) > ((fechaViaje - (60 days)))) ifTrue: [reembolso := (((viajeContratado) buscarValorTotal) * 25) / 100 ].
(((Date today) < ((fechaViaje - (60 days)))) & ((Date today) > ((fechaViaje - (90 days))))) ifTrue: [reembolso := (((viajeContratado) buscarValorTotal) * 50) / 100 ].
((Date today) < ((fechaViaje - (90 days)))) ifTrue: [reembolso := (((viajeContratado) buscarValorTotal) * 75) / 100 ].
^reembolso
]

{ #category : #queries }
Contrato >> crearCuotas [
|costo cuota|
costo := viajeContratado buscarPrecio.
cantCuotas timesRepeat: [
    colCuotas add: (cuota := Cuota crear: costo / cantCuotas).
].
]

{ #category : #'as yet unclassified' }
Contrato >> cuotasPagadas [
^(colCuotas isEmpty).
]

{ #category : #queries }
Contrato >> efectivizar [
    estaPagado := false.
    (colCuotas isEmpty and: [(fechaViaje - Date today) days > 7]) ifTrue: [
        estaPagado := true.
    ].
    

]

{ #category : #queries }
Contrato >> eliminar: unNombre [
|unContrato|
(viajeContratado recuperarViaje: unNombre) ifTrue:[viajeContratado := nil. unContrato := self].
^ unContrato.
]

{ #category : #queries }
Contrato >> encontrarContrato [
|rta|
rta := false.
((fechaProxVencimiento - 7 days) <= Date today) ifTrue: [rta := true].
^ rta.
]

{ #category : #'as yet unclassified' }
Contrato >> esViajeOrganizado [
^ (viajeContratado isKindOf: ViajeOrganizado)
]

{ #category : #'as yet unclassified' }
Contrato >> getCantPersonas [
^cantPersonas.
]

{ #category : #'as yet unclassified' }
Contrato >> getCuotasAPagar [
^ colCuotas size.
]

{ #category : #'as yet unclassified' }
Contrato >> getFechaCreacion [
^fechaCreacion.
]

{ #category : #'as yet unclassified' }
Contrato >> getFechaViaje [
^fechaViaje.
]

{ #category : #'as yet unclassified' }
Contrato >> getNumContrato [
^numContrato.
]

{ #category : #'as yet unclassified' }
Contrato >> getViajeContratado [
^viajeContratado.
]

{ #category : #queries }
Contrato >> inicializar: unNumero conViajeContratado: unViaje conFechaViaje: unaFechaViaje conCantPersonas: unaCantPersonas conCantCuotas: unaCantCuotas conFechaProxVenc: unaFechaVenc [
numContrato := unNumero.
fechaCreacion := Date today.
viajeContratado := unViaje.
fechaViaje := unaFechaViaje.
cantPersonas := unaCantPersonas.
cantCuotas := unaCantCuotas.
fechaProxVencimiento := unaFechaVenc.
colExcursionesContratadas := OrderedCollection new.
colCuotas := OrderedCollection new.
estaPagado := false.
self crearCuotas.


]

{ #category : #queries }
Contrato >> pagar: unaCantidad [
    | cantidad |
    cantidad := unaCantidad.
    ((colCuotas isNotEmpty ) and: [cantidad <= colCuotas size]) ifTrue: [
        cantidad timesRepeat: [
            colCuotas first registrarPago.
            colCuotas removeFirst.
        ].
    ].
]

{ #category : #queries }
Contrato >> registrarEnContrato: unNombre conCosto: unCosto conCantidad: unaCantidad [
|unaExcursion|
unaExcursion := (Excursion) crear: unNombre conCosto: unCosto conCantPersonas: unaCantidad.
colExcursionesContratadas add: unaExcursion.
]
