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
	#category : #tpoFinal2023
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

{ #category : #queries }
Contrato >> buscarPrecioViaje [
|precio|
precio := viajeContratado buscarPrecio.
^ precio.

]

{ #category : #queries }
Contrato >> crearCuotas [
|costo cuota|
costo := viajeContratado buscarPrecio.
cantCuotas timesRepeat: [
    colCuotas add: (cuota := Cuota crear: costo / cantCuotas).
].
]

{ #category : #queries }
Contrato >> efectivizar [
estaPagado := false.
((colCuotas isEmpty) and: ((fechaViaje - Date today )days>  7 ) ) ifTrue: (estaPagado := true).
^estaPagado .

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
((unaCantidad < cantPersonas) & ((Date today) < (fechaViaje - 7 days))) ifTrue: [
	unaExcursion := viajeContratado registrarExcursion: unNombre conCosto: unCosto conCantidad: unaCantidad.
	colExcursionesContratadas add: unaExcursion.
].
]
