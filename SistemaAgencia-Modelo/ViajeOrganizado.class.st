Class {
	#name : #ViajeOrganizado,
	#superclass : #Viaje,
	#instVars : [
		'diasDuracion',
		'colEtapas',
		'colExcursiones',
		'colFechas'
	],
	#category : #'SistemaAgencia-Modelo'
}

{ #category : #constructor }
ViajeOrganizado class >> crear: unNombre conCosto: unCosto conValorImpuestos: unosImpuestos conDias: unosDias conEtapas: unasEtapas conFechas: unasFechas conExcursiones: unasExcursiones [
|nuevoViajeOrganizado|
nuevoViajeOrganizado := self crear: unNombre conCosto: unCosto conValorImpuestos: unosImpuestos.
nuevoViajeOrganizado inicializar: unosDias conEtapas: unasEtapas conFechas: unasFechas conExcursiones: unasExcursiones.
^ nuevoViajeOrganizado.
]

{ #category : #'as yet unclassified' }
ViajeOrganizado >> buscarExcursionDesdeViaje: unNombre [
|unaExcursion|
unaExcursion := nil.
unaExcursion := colExcursiones detect: [:cadaExcursion| cadaExcursion buscarExcursionConNombre: unNombre.]ifNone:[nil].
^unaExcursion.
]

{ #category : #'as yet unclassified' }
ViajeOrganizado >> buscarFechaDeViaje: fechaIn [
|unaFecha|
unaFecha := nil.
unaFecha := colFechas detect: [:cadaFecha| cadaFecha buscarFecha: fechaIn.]ifNone:[nil].
^unaFecha.
]

{ #category : #'as yet unclassified' }
ViajeOrganizado >> buscarFechaDesdeViaje: unNumeroFecha [
|unaFecha|
unaFecha := nil.
(unNumeroFecha <= colFechas size) ifTrue: [
	unaFecha := colFechas at: unNumeroFecha.
] ifFalse: [ 
	unaFecha := nil.
].	 
^unaFecha.
]

{ #category : #queries }
ViajeOrganizado >> buscarInfo [
|rta2|
rta2 := nil.
(colFechas detect:[:cadaFecha| cadaFecha verificarFecha] ifNone: [nil]) ifNotNil:[
	rta2 := super buscarInfo, ' - Duracion: ',diasDuracion asString,' dias '.
	"colEtapas do:[:cadaEtapa| rta2 := rta2 , (cadaEtapa buscarEtapas)].
	(colExcursiones isNotEmpty) ifTrue:[
		rta2 := rta2,' - Excursiones: '.
		colExcursiones do:[:cadaExcursion| rta2 := rta2 , (cadaExcursion buscarExcursiones)].
	]."
].
^ rta2.
]

{ #category : #queries }
ViajeOrganizado >> buscarInfo: fecha1 conFecha: fecha2 [
  | rta2 |
  rta2 := nil.
  ((colFechas detect: [:cadaFecha | cadaFecha verificarFecha: fecha1 conFecha: fecha2] ifNone: [nil])) ifNotNil: [
    rta2 := (super buscarInfo: fecha1 conFecha: fecha2) , ' - Duracion: ',diasDuracion asString,' dias '.
    "colEtapas do: [:cadaEtapa | rta2 := rta2 , cadaEtapa buscarEtapas asString].
    (colExcursiones isNotEmpty) ifTrue: [
      rta2 := rta2 , ' con las siguientes excursiones: '.
      colExcursiones do: [:cadaExcursion | rta2 := rta2 , cadaExcursion buscarExcursiones asString].
    ]."
  ].
  ^ rta2.


]

{ #category : #queries }
ViajeOrganizado >> inicializar: unosDias conEtapas: unasEtapas conFechas: unasFechas conExcursiones: unasExcursiones [
diasDuracion := unosDias.
colEtapas := unasEtapas.
colExcursiones := unasExcursiones.
colFechas := unasFechas.
]

{ #category : #'as yet unclassified' }
ViajeOrganizado >> listarExcursiones [
|aux unaColExcursiones |
aux := nil.
unaColExcursiones := OrderedCollection new.
colExcursiones do: [:cadaExcursion |
	aux := (cadaExcursion buscarExcursiones).
	(aux isNotNil) ifTrue: [
		unaColExcursiones add: aux.
	].
].
^ unaColExcursiones.
]

{ #category : #'as yet unclassified' }
ViajeOrganizado >> listarFechas [
|aux unaColFechas i|
i := 1.
aux := nil.
unaColFechas := OrderedCollection new.
colFechas do: [:cadaFecha |
	aux := (cadaFecha buscarFecha).
	(aux isNotNil) ifTrue: [
		aux := i asString, ' - ', aux.
		unaColFechas add: aux.
		i := i + 1.
	].
].
^ unaColFechas.
]

{ #category : #queries }
ViajeOrganizado >> modificarCosto: unCosto [
costoPorPersona := unCosto.
]

{ #category : #queries }
ViajeOrganizado >> modificarDias: unosDias [
diasDuracion := unosDias.
]

{ #category : #queries }
ViajeOrganizado >> modificarEtapas: unasEtapas [
"colEtapas := unasEtapas."
colEtapas addAll: unasEtapas.
]

{ #category : #queries }
ViajeOrganizado >> modificarExcursiones: unasExcursiones [
"colExcursiones := unasExcursiones."
colExcursiones addAll: unasExcursiones.
]

{ #category : #queries }
ViajeOrganizado >> modificarFechas: unasFechas [
"colFechas := unasFechas"
colFechas addAll: unasFechas.
]

{ #category : #queries }
ViajeOrganizado >> modificarImpuestos: unosImpuestos [
valorImpuestos := unosImpuestos.
]

{ #category : #queries }
ViajeOrganizado >> registrarExcursion: unNombre conCosto: unCosto conCantidad: unaCantidad [
|unaExcursion|
unaExcursion := nil.
unaExcursion := Excursion crear: unNombre conCosto: unCosto conCantPersonas: unaCantidad.
(unaExcursion isNotNil) ifTrue:[colExcursiones add: unaExcursion.].

^ unaExcursion.
]

{ #category : #'as yet unclassified' }
ViajeOrganizado >> restarPersonasDesdeViaje: unNombre conCantidad: unaCantidad [
|excursion|
excursion := self buscarExcursionDesdeViaje: unNombre.
excursion restarPersonasDeExcursion: unaCantidad.
]
