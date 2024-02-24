Class {
	#name : #ViajeEspecial,
	#superclass : #Viaje,
	#instVars : [
		'ciudadViaje',
		'fechaSalida',
		'fechaRegreso',
		'disponibilidad'
	],
	#category : #'SistemaAgencia-Modelo'
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
	rta2 := super buscarInfo,' - Ciudad: ',ciudadViaje,' - Salida: ',fechaSalida asString,' - Regreso: ',fechaRegreso asString,' - Lugares disponibles: ',disponibilidad asString].
^ rta2.
]

{ #category : #queries }
ViajeEspecial >> buscarInfo: fecha1 conFecha: fecha2 [
  | rta2 |
  rta2 := nil.
  ((disponibilidad > 0) & (fechaSalida >= fecha1) & (fechaSalida <= fecha2)) ifTrue:[
    rta2 := (super buscarInfo: fecha1 conFecha: fecha2) ,' - Ciudad: ',ciudadViaje,' - Salida: ',fechaSalida asString,' - Regreso: ',fechaRegreso asString,' - Lugares disponibles: ',disponibilidad asString].
  ^ rta2.

]

{ #category : #'as yet unclassified' }
ViajeEspecial >> devolverDisponibilidad: unaCantidad [.
disponibilidad := disponibilidad + unaCantidad.
]

{ #category : #'as yet unclassified' }
ViajeEspecial >> getDisponibilidad [
^disponibilidad.
]

{ #category : #'as yet unclassified' }
ViajeEspecial >> getFecha [
^ fechaSalida.
]

{ #category : #queries }
ViajeEspecial >> inicializar: unaCiudad conFechaSalida: fecha1 conFechaRegreso: fecha2 conDisponibilidad: unaDisponibilidad [
ciudadViaje := unaCiudad.
fechaSalida := fecha1.
fechaRegreso := fecha2.
disponibilidad := unaDisponibilidad.
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

{ #category : #'as yet unclassified' }
ViajeEspecial >> restarDisponibilidad: cantIn [
disponibilidad := (disponibilidad - cantIn).
]
