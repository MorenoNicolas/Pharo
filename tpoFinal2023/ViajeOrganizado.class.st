Class {
	#name : #ViajeOrganizado,
	#superclass : #Viaje,
	#instVars : [
		'diasDuracion',
		'colEtapas',
		'colExcursiones',
		'colFechas'
	],
	#category : #tpoFinal2023
}

{ #category : #constructor }
ViajeOrganizado class >> crear: unNombre conCosto: unCosto conValorImpuestos: unosImpuestos conDias: unosDias conEtapas: unasEtapas conFechas: unasFechas [
|nuevoViajeOrganizado|
nuevoViajeOrganizado := self crear: unNombre conCosto: unCosto conValorImpuestos: unosImpuestos.
nuevoViajeOrganizado inicializar: unosDias conEtapas: unasEtapas conFechas: unasFechas.
^ nuevoViajeOrganizado.
]

{ #category : #queries }
ViajeOrganizado >> buscarInfo [
|rta2|
rta2 := nil.
(colFechas detect:[:cadaFecha| cadaFecha verificarFecha]) ifTrue:[
	rta2 := super buscarInfo, ' con una duracion de ',diasDuracion,' dias, con las siguientes etapas: '.
	colEtapas do:[:cadaEtapa| rta2 := rta2 + (cadaEtapa buscarEtapas)].
	(colExcursiones isNotEmpty) ifTrue:[
		rta2 := rta2,' con las siguientes excursiones: '.
		colExcursiones do:[:cadaExcursion| rta2 := rta2 + (cadaExcursion buscarExcursiones)].
	].
].
^ rta2.
]

{ #category : #queries }
ViajeOrganizado >> buscarInfo: fecha1 conFecha: fecha2 [
  | rta2 |
  rta2 := nil.
  ((colFechas detect: [:cadaFecha | cadaFecha verificarFecha: fecha1 conFecha: fecha2] ifNone: [nil])) ifNotNil: [
    rta2 := (super buscarInfo: fecha1 conFecha: fecha2) , ' con una duracion de ' , diasDuracion asString , ' dias, con las siguientes etapas: '.
    colEtapas do: [:cadaEtapa | rta2 := rta2 , cadaEtapa buscarEtapas asString].
    (colExcursiones isNotEmpty) ifTrue: [
      rta2 := rta2 , ' con las siguientes excursiones: '.
      colExcursiones do: [:cadaExcursion | rta2 := rta2 , cadaExcursion buscarExcursiones asString].
    ].
  ].
  ^ rta2.


]

{ #category : #queries }
ViajeOrganizado >> inicializar: unosDias conEtapas: unasEtapas conFechas: unasFechas [
diasDuracion := unosDias.
colEtapas := unasEtapas.
colExcursiones := OrderedCollection new. "la inicializo vacia ya que agregarlas es opcional, modulo/mensaje aparte"
colFechas := unasFechas.
]

{ #category : #queries }
ViajeOrganizado >> modificar: opcion2 conCosto: unCosto conValorImpuestos: unosImpuestos conCiudad: unaCiudad conFechaSalida: fecha1 conFechaRegreso: fecha2 conDisponibilidad: unaDisponibilidad conDias: unosDias conEtapas: unasEtapas conExcursiones: unasExcursiones conFechas: unasFechas [
((opcion2 = $p) or: (opcion2 = $P)) ifTrue: [costoPorPersona := unCosto].
((opcion2 = $v) or: (opcion2 = $V)) ifTrue: [valorImpuestos := unosImpuestos].
((opcion2 = $d) or: (opcion2 = $D)) ifTrue: [diasDuracion := unosDias].
((opcion2 = $e) or: (opcion2 = $E)) ifTrue: [colEtapas := unasEtapas].
((opcion2 = $x) or: (opcion2 = $X)) ifTrue: [colExcursiones := unasExcursiones].
((opcion2 = $f) or: (opcion2 = $F)) ifTrue: [colFechas := unasFechas].
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
colEtapas := unasEtapas.
]

{ #category : #queries }
ViajeOrganizado >> modificarExcursiones: unasExcursiones [
colExcursiones := unasExcursiones.
]

{ #category : #queries }
ViajeOrganizado >> modificarFechas: unasFechas [
colFechas := unasFechas.
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
