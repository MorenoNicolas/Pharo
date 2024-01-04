Class {
	#name : #ViajeEspecial,
	#superclass : #Viaje,
	#instVars : [
		'ciudadViaje',
		'fechaSalida',
		'fechaRegreso',
		'disponibilidad'
	],
	#category : #tpoFinal2023
}

{ #category : #constructor }
ViajeEspecial class >> crear: unNombre conCosto: unCosto conValorImpuestos: unosImpuestos conCiudad: unaCiudad conFechaSalida: fecha1 conFechaRegreso: fecha2 conDisponibilidad: unaDisponibilidad [
|nuevoViajeEspecial|
nuevoViajeEspecial := self crear: unNombre conCosto: unCosto conValorImpuestos: unosImpuestos.
nuevoViajeEspecial inicializar: unaCiudad conFechaSalida: fecha1 conFechaRegreso: fecha2 conDisponibilidad: unaDisponibilidad.
^ nuevoViajeEspecial.
]

{ #category : #queries }
ViajeEspecial >> buscarInfo [
|rta2|
(disponibilidad > 0) ifTrue:[
	rta2 := super buscarInfo,' en ',ciudadViaje,', salida el ',fechaSalida,', regreso el ',fechaRegreso,', con disponibilidad de ',disponibilidad,' personas.'].
^ rta2.
]

{ #category : #queries }
ViajeEspecial >> buscarInfo: fecha1 conFecha: fecha2 [
  | rta2 |
  rta2 := nil.
  ((disponibilidad > 0) & (fechaSalida >= fecha1) & (fechaSalida <= fecha2)) ifTrue:[
    rta2 := (super buscarInfo: fecha1 conFecha: fecha2) , ' en ' , ciudadViaje asString , ', salida el ' , fechaSalida asString, ', regreso el ' , fechaRegreso asString, ', con disponibilidad de ' , disponibilidad asString, ' personas.' ].
  ^ rta2.

]

{ #category : #queries }
ViajeEspecial >> inicializar: unaCiudad conFechaSalida: fecha1 conFechaRegreso: fecha2 conDisponibilidad: unaDisponibilidad [
ciudadViaje := unaCiudad.
fechaSalida := fecha1.
fechaRegreso := fecha2.
disponibilidad := unaDisponibilidad.
]

{ #category : #queries }
ViajeEspecial >> modificar: opcion2 conCosto: unCosto conValorImpuestos: unosImpuestos conCiudad: unaCiudad conFechaSalida: fecha1 conFechaRegreso: fecha2 conDisponibilidad: unaDisponibilidad conDias: unosDias conEtapas: unasEtapas conExcursiones: unasExcursiones conFechas: unasFechas [
((opcion2 = $p) or: (opcion2 = $P)) ifTrue: [costoPorPersona := unCosto].
((opcion2 = $v) or: (opcion2 = $V)) ifTrue: [valorImpuestos := unosImpuestos].
((opcion2 = $c) or: (opcion2 = $C)) ifTrue: [ciudadViaje := unaCiudad].
((opcion2 = $s) or: (opcion2 = $S)) ifTrue: [fechaSalida := fecha1].
((opcion2 = $r) or: (opcion2 = $R)) ifTrue: [fechaRegreso := fecha2].
((opcion2 = $d) or: (opcion2 = $D)) ifTrue: [disponibilidad := unaDisponibilidad].
]

{ #category : #queries }
ViajeEspecial >> modificarCiudad: unaCiudad [
ciudadViaje := unaCiudad.
]

{ #category : #queries }
ViajeEspecial >> modificarCosto: unCosto [
costoPorPersona := unCosto.
]

{ #category : #queries }
ViajeEspecial >> modificarDisponibilidad: unaDisponibilidad [
disponibilidad := unaDisponibilidad.
]

{ #category : #queries }
ViajeEspecial >> modificarFechaRegreso: unaFecha [
fechaRegreso := unaFecha.
]

{ #category : #queries }
ViajeEspecial >> modificarFechaSalida: unaFecha [
fechaSalida := unaFecha.
]

{ #category : #queries }
ViajeEspecial >> modificarImpuestos: unosImpuestos [
valorImpuestos := unosImpuestos.
]
