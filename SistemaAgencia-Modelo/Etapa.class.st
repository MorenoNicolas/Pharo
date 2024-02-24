Class {
	#name : #Etapa,
	#superclass : #Object,
	#instVars : [
		'diaLlegada',
		'cantidadDias',
		'hotel',
		'tipoPension',
		'listaActividades',
		'ciudadEtapa'
	],
	#category : #'SistemaAgencia-Modelo'
}

{ #category : #constructor }
Etapa class >> crear: unDia conCantidadDias: unaCantidad conHotel: unHotel conTipoPension: unTipoPension conListaActividades: unasActividades conCiudad: unaCiudad [
|nuevaEtapa|
nuevaEtapa := self new.
nuevaEtapa inicializar: unDia conCantidadDias: unaCantidad conHotel: unHotel conTipoPension: unTipoPension conListaActividades: unasActividades conCiudad: unaCiudad.
^ nuevaEtapa.
]

{ #category : #queries }
Etapa >> buscarEtapas [
|rta3|
rta3 := 'Llegada el dia ',diaLlegada asString,' a la ciudad ',ciudadEtapa asString,' por ',cantidadDias asString,' dias, en el hotel ',hotel asString,' con las siguientes actividades: ', self listarActividades.
^ rta3. 
]

{ #category : #queries }
Etapa >> inicializar: unDia conCantidadDias: unaCantidad conHotel: unHotel conTipoPension: unTipoPension conListaActividades: unasActividades conCiudad: unaCiudad [
diaLlegada := unDia.
cantidadDias := unaCantidad.
hotel := unHotel.
tipoPension := unTipoPension.
listaActividades := unasActividades.
ciudadEtapa := unaCiudad.
]

{ #category : #queries }
Etapa >> listarActividades [
  "| rtaActividades |
  rtaActividades := ''.
  listaActividades do: [:cadaActividad |
    rtaActividades := rtaActividades , cadaActividad asString , ', '.
  ]."
^ listaActividades.

]
