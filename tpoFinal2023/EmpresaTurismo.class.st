Class {
	#name : #EmpresaTurismo,
	#superclass : #Object,
	#instVars : [
		'colClientes',
		'colViajes'
	],
	#category : #tpoFinal2023
}

{ #category : #constructor }
EmpresaTurismo class >> crear [
|nuevaEmpresaTurismo|
nuevaEmpresaTurismo := self new.
nuevaEmpresaTurismo inicializar.
^ nuevaEmpresaTurismo.
]

{ #category : #queries }
EmpresaTurismo >> agregarCliente: unCliente [
colClientes add: unCliente.
]

{ #category : #queries }
EmpresaTurismo >> agregarExcursion: nroContrato conNombre: unNombre conCosto: unCosto conCantidad: unaCantidad [
|unContrato|
unContrato := nil.
colClientes do: [:cadaCliente |
	(unContrato isNil) ifTrue: [unContrato := cadaCliente buscarContratoEnCliente: nroContrato.].
(unContrato isNotNil) ifTrue: [unContrato registrarEnContrato: unNombre conCosto: unCosto conCantidad: unaCantidad.].
].
]

{ #category : #queries }
EmpresaTurismo >> agregarViaje: unViaje [
colViajes add: unViaje.
]

{ #category : #queries }
EmpresaTurismo >> bajasViajes: unNombre [
|unViaje|
unViaje := colViajes detect:[:cadaViaje| cadaViaje buscarViaje: unNombre].
(unViaje isNotNil) ifTrue:[
	colViajes remove: unViaje.
	colClientes do:[:cadaCliente| cadaCliente buscarContratoEliminar: unNombre].
].


]

{ #category : #queries }
EmpresaTurismo >> clientesContratosAVencer [
|listaClientes unCliente|
listaClientes := OrderedCollection new.
(colClientes isNotEmpty) ifTrue: [ 
	colClientes do: [ :cadaCliente |
		unCliente := cadaCliente encontrarClientes.
		(unCliente isNotNil) ifTrue: [listaClientes add: unCliente].
	].
].
(listaClientes isNotNil) ifTrue:[^ listaClientes ].
]

{ #category : #queries }
EmpresaTurismo >> crearEspecial: unNombre conCosto: unCosto conValorImpuestos: unosImpuestos conCiudad: unaCiudad conFechaSalida: fecha1 conFechaRegreso: fecha2 conDisponibilidad: unaDisponibilidad [
|viajeEspecial|
viajeEspecial := ViajeEspecial crear: unNombre conCosto: unCosto conValorImpuestos: unosImpuestos conCiudad: unaCiudad conFechaSalida: fecha1 conFechaRegreso: fecha2 conDisponibilidad: unaDisponibilidad.
colViajes add: viajeEspecial.
]

{ #category : #queries }
EmpresaTurismo >> crearOrganizado: unNombre conCosto: unCosto conValorImpuestos: unosImpuestos conDias: unosDias conEtapas: unasEtapas conFechas: unasFechas [
|viajeOrganizado|
viajeOrganizado := ViajeOrganizado crear: unNombre conCosto: unCosto conValorImpuestos: unosImpuestos conDias: unosDias conEtapas: unasEtapas conFechas: unasFechas.
colViajes add: viajeOrganizado.
]

{ #category : #queries }
EmpresaTurismo >> efectivizacionContrato: numeroContrato conDniCliente:dniCliente [
|unCliente|
unCliente:= colClientes detect: [ :cliente | cliente buscarClienteconDni: dniCliente ]. 
(unCliente  isNotNil) ifTrue:(unCliente efectivizacionEnCliente: numeroContrato).

]

{ #category : #queries }
EmpresaTurismo >> inicializar [
colClientes := OrderedCollection new.
colViajes := OrderedCollection new.
]

{ #category : #queries }
EmpresaTurismo >> listarInfoViajes: fecha1 conFecha2: fecha2 [
  | aux colViajesDisponibles |
  aux := nil.
  colViajesDisponibles := OrderedCollection new.
  colViajes do: [:cadaViaje |
    aux := (cadaViaje buscarInfo: fecha1 conFecha: fecha2).
    (aux isNotNil) ifTrue: [colViajesDisponibles add: aux].
  ].
  ^ colViajesDisponibles.

]

{ #category : #queries }
EmpresaTurismo >> modificarFecha: nuevaFecha conDniCliente: unDni conNumeroContrato: unCont deseaCancelar: cancelar [
|cliente montoT|
cliente := colClientes detect: [ :encontrado | encontrado buscarCliente: unDni ].
montoT:= cliente modificacionEnCliente: unCont  deseaCancelar: cancelar conNuevaFecha: nuevaFecha.
^montoT 
]

{ #category : #queries }
EmpresaTurismo >> modificarViaje: opcion2 conNombre: unNombre conCosto: unCosto conValorImpuestos: unosImpuestos conCiudad: unaCiudad conFechaSalida: fecha1 conFechaRegreso: fecha2 conDisponibilidad: unaDisponibilidad conDias: unosDias conEtapas: unasEtapas conExcursiones: unasExcursiones conFechas: unasFechas [
|unViaje|
unViaje := colViajes detect:[:cadaViaje| cadaViaje buscarViaje: unNombre].
(unViaje isNotNil) ifTrue:[unViaje modificar: opcion2 conCosto: unCosto conValorImpuestos: unosImpuestos conCiudad: unaCiudad conFechaSalida: fecha1 conFechaRegreso: fecha2 conDisponibilidad: unaDisponibilidad conDias: unosDias conEtapas: unasEtapas conExcursiones: unasExcursiones conFechas: unasFechas].
]

{ #category : #queries }
EmpresaTurismo >> realizarPago: nroContrato conCantidad: unaCantidad [
|unContrato|
unContrato := nil.
unContrato := colClientes detect:[:cadaCliente| cadaCliente buscarContratoEnCliente: nroContrato].
(unContrato) ifNotNil: [unContrato pagar: unaCantidad].

]
