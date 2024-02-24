Class {
	#name : #EmpresaTurismo,
	#superclass : #Object,
	#instVars : [
		'colClientes',
		'colViajes'
	],
	#category : #'SistemaAgencia-Modelo'
}

{ #category : #constructor }
EmpresaTurismo class >> crear [
|nuevaEmpresaTurismo|
nuevaEmpresaTurismo := self new.
nuevaEmpresaTurismo inicializar.
^ nuevaEmpresaTurismo.
]

{ #category : #constructor }
EmpresaTurismo class >> crearEmpresa [
|nuevaEmpresaTurismo unaColClientes unaColViajes fecha1 fecha2 fecha3 fecha4 fecha5 fecha6 fecha7 fecha8 fecha9 fecha10 etapa1 etapa2 etapa3 etapa4 etapa5 etapa6 etapa7 etapa8 etapa9 etapa10 excursion1 excursion2 excursion3 excursion4 excursion5 excursion6 excursion7 excursion8 excursion9 excursion10 viaje1 viaje2 viaje3 viaje4 viaje5 viaje6 viaje7 viaje8 viaje9 viaje10|
nuevaEmpresaTurismo := self new.

unaColClientes := OrderedCollection new.

unaColClientes add: (ViajeroFrecuente crear: 1 conApellido: 'Moreno' conCiudad: 'Zapala' conDatos: 299151520 conMillas: 1000 conContra: 1).
unaColClientes add: (Cliente crear: 2 conApellido: 'Gomez' conCiudad: 'Buenos Aires' conDatos: 1122334455 conContra:1).
unaColClientes add: (Cliente crear: 87654321 conApellido: 'Perez' conCiudad: 'Cordoba' conDatos: 987654321 conContra: 1).
unaColClientes add: (Cliente crear: 13579246 conApellido: 'Lopez' conCiudad: 'Rosario' conDatos: 246813579 conContra: 1).
unaColClientes add: (Cliente crear: 98765432 conApellido: 'Fernandez' conCiudad: 'Mendoza' conDatos: 654321987 conContra: 1).
unaColClientes add: (Cliente crear: 56789123 conApellido: 'Martinez' conCiudad: 'Salta' conDatos: 321456987 conContra: 1).
unaColClientes add: (Cliente crear: 11223344 conApellido: 'Sanchez' conCiudad: 'Tucuman' conDatos: 9876543210 conContra: 1).
unaColClientes add: (Cliente crear: 87654321 conApellido: 'Gonzalez' conCiudad: 'Neuquen' conDatos: 1234567890 conContra: 1).
unaColClientes add: (Cliente crear: 54321678 conApellido: 'Romero' conCiudad: 'La Plata' conDatos: 9876543210 conContra: 1).
unaColClientes add: (Cliente crear: 99988877 conApellido: 'Torres' conCiudad: 'Mar del Plata' conDatos: 1234567890 conContra: 1).

fecha1 := Fecha crear: (Date today addDays: 55) conCupo: 12.
fecha2 := Fecha crear: (Date today addDays: 70) conCupo: 0.
fecha3 := Fecha crear: (Date today addDays: 85) conCupo: 10.
fecha4 := Fecha crear: (Date today addDays: 100) conCupo: 8.
fecha5 := Fecha crear: (Date today addDays: 115) conCupo: 5.
fecha6 := Fecha crear: (Date today addDays: 130) conCupo: 0.
fecha7 := Fecha crear: (Date today addDays: 145) conCupo: 16.
fecha8 := Fecha crear: (Date today addDays: 160) conCupo: 13.
fecha9 := Fecha crear: (Date today addDays: 175) conCupo: 7.
fecha10 := Fecha crear: (Date today addDays: 190) conCupo: 9.

etapa1 := Etapa crear: (Date today addDays: 200) conCantidadDias: 3 conHotel: 'Hotel Comahue' conTipoPension: 'Sin Pension' conListaActividades: 'Escalar cerro, Visitar el centro, Ir al mirador' conCiudad: 'Neuquen'.
etapa2 := Etapa crear: (Date today addDays: 210) conCantidadDias: 2 conHotel: 'Hotel Patagonia' conTipoPension: 'Media Pension' conListaActividades: 'Caminata por el lago, Visitar museo' conCiudad: 'Bariloche'.
etapa3 := Etapa crear: (Date today addDays: 220) conCantidadDias: 4 conHotel: 'Hotel del Sol' conTipoPension: 'Pension Completa' conListaActividades: 'Tour en bicicleta, Visitar viñedos, Degustación de vinos' conCiudad: 'Mendoza'.
etapa4 := Etapa crear: (Date today addDays: 230) conCantidadDias: 1 conHotel: 'Hotel Oasis' conTipoPension: 'Sin Pension' conListaActividades: 'Relajarse en la playa' conCiudad: 'Mar del Plata'.
etapa5 := Etapa crear: (Date today addDays: 240) conCantidadDias: 5 conHotel: 'Hotel El Bosque' conTipoPension: 'Media Pension' conListaActividades: 'Senderismo en montaña, Visitar cascadas, Avistamiento de aves' conCiudad: 'San Carlos de Bariloche'.
etapa6 := Etapa crear: (Date today addDays: 250) conCantidadDias: 2 conHotel: 'Hotel del Lago' conTipoPension: 'Pension Completa' conListaActividades: 'Tour en barco por el lago, Visitar parques naturales' conCiudad: 'Villa La Angostura'.
etapa7 := Etapa crear: (Date today addDays: 260) conCantidadDias: 3 conHotel: 'Hotel Estepa' conTipoPension: 'Media Pension' conListaActividades: 'Safari fotográfico, Visitar reservas naturales' conCiudad: 'Ushuaia'.
etapa8 := Etapa crear: (Date today addDays: 270) conCantidadDias: 4 conHotel: 'Hotel Bosque Encantado' conTipoPension: 'Pension Completa' conListaActividades: 'Recorrido en tren panorámico, Visitar sitios históricos' conCiudad: 'Trenque Lauquen'.
etapa9 := Etapa crear: (Date today addDays: 280) conCantidadDias: 2 conHotel: 'Hotel Pampa' conTipoPension: 'Una Pension' conListaActividades: 'Paseo en globo aerostático, Visitar ruinas arqueológicas' conCiudad: 'Salta'.
etapa10 := Etapa crear: (Date today addDays: 290) conCantidadDias: 1 conHotel: 'Hotel Aconcagua' conTipoPension: 'Sin Pension' conListaActividades: 'Explorar el centro histórico, Visitar la catedral' conCiudad: 'Mendoza'.

excursion1 := Excursion crear: 'Excursion en la selva' conCosto: 1500 conCantPersonas: 20.
excursion2 := Excursion crear: 'Visita a la montaña' conCosto: 1800 conCantPersonas: 15.
excursion3 := Excursion crear: 'Recorrido en barco' conCosto: 1200 conCantPersonas: 25.
excursion4 := Excursion crear: 'Aventura submarina' conCosto: 2200 conCantPersonas: 10.
excursion5 := Excursion crear: 'Paseo en globo aerostático' conCosto: 2500 conCantPersonas: 8.
excursion6 := Excursion crear: 'Exploración de ruinas arqueológicas' conCosto: 1900 conCantPersonas: 12.
excursion7 := Excursion crear: 'Tour en bicicleta' conCosto: 1000 conCantPersonas: 30.
excursion8 := Excursion crear: 'Visita a viñedos y degustación de vinos' conCosto: 2800 conCantPersonas: 20.
excursion9 := Excursion crear: 'Safari fotográfico' conCosto: 2400 conCantPersonas: 15.
excursion10 := Excursion crear: 'Visita a parques naturales' conCosto: 1700 conCantPersonas: 25.


viaje1 := ViajeEspecial crear: 'Aventura en la selva' conCosto: 1200 conValorImpuestos: 150 conCiudad: 'Amazonas' conFechaSalida: (Date today addDays: 300) conFechaRegreso: (Date today addDays: 305) conDisponibilidad: 10.
viaje2 := ViajeEspecial crear: 'Escapada a la montaña' conCosto: 800 conValorImpuestos: 100 conCiudad: 'Montañas Nevadas' conFechaSalida: (Date today addDays: 107) conFechaRegreso: (Date today addDays: 110) conDisponibilidad: 5.
viaje3 := ViajeEspecial crear: 'Relax en la playa' conCosto: 1800 conValorImpuestos: 200 conCiudad: 'Playa del Sol' conFechaSalida: (Date today addDays: 150) conFechaRegreso: (Date today addDays: 200) conDisponibilidad: 0.
viaje4 := ViajeEspecial crear: 'Descubriendo culturas' conCosto: 1500 conValorImpuestos: 180 conCiudad: 'Ciudad Histórica' conFechaSalida: (Date today addDays: 300) conFechaRegreso: (Date today addDays: 305) conDisponibilidad: 8.
viaje5 := ViajeEspecial crear: 'Aventura submarina' conCosto: 2200 conValorImpuestos: 250 conCiudad: 'Mar Profundo' conFechaSalida: (Date today addDays: 140) conFechaRegreso: (Date today addDays: 145) conDisponibilidad: 12.

viaje6 := ViajeOrganizado crear: 'Aventura en la selva organizada' conCosto: 1200 conValorImpuestos: 150 conDias: 5 conEtapas: (OrderedCollection with: etapa1 with: etapa2 with: etapa3) conFechas: (OrderedCollection with: fecha1 with: fecha2 with: fecha3) conExcursiones: (OrderedCollection with: excursion1 with: excursion2).
viaje7 := ViajeOrganizado crear: 'Escapada a la montaña organizada' conCosto: 800 conValorImpuestos: 100 conDias: 4 conEtapas: (OrderedCollection with: etapa4 with: etapa5) conFechas: (OrderedCollection with: fecha4 with: fecha5) conExcursiones: (OrderedCollection with: excursion3 with: excursion4).
viaje8 := ViajeOrganizado crear: 'Relax en la playa organizada' conCosto: 1800 conValorImpuestos: 200 conDias: 6 conEtapas: (OrderedCollection with: etapa6 with: etapa7 with: etapa8) conFechas: (OrderedCollection with: fecha6 with: fecha7 with: fecha8) conExcursiones: (OrderedCollection with: excursion5 with: excursion6).
viaje9 := ViajeOrganizado crear: 'Descubriendo culturas organizada' conCosto: 1500 conValorImpuestos: 180 conDias: 6 conEtapas: (OrderedCollection with: etapa9 with: etapa10) conFechas: (OrderedCollection with: fecha9 with: fecha10) conExcursiones: (OrderedCollection with: excursion7 with: excursion8).
viaje10 := ViajeOrganizado crear: 'Aventura submarina organizada' conCosto: 2200 conValorImpuestos: 250 conDias: 6 conEtapas: (OrderedCollection with: etapa1 with: etapa3 with: etapa5) conFechas: (OrderedCollection with: fecha2 with: fecha4 with: fecha6) conExcursiones: (OrderedCollection with: excursion9 with: excursion10).


unaColViajes := OrderedCollection new.

unaColViajes add: viaje1.
unaColViajes add: viaje2.
unaColViajes add: viaje3.
unaColViajes add: viaje4.
unaColViajes add: viaje5.
unaColViajes add: viaje6.
unaColViajes add: viaje7.
unaColViajes add: viaje8.
unaColViajes add: viaje9.
unaColViajes add: viaje10.

"(unaColClientes at:1) nuevoContrato: 2200 conViajeContratado: viaje6  conFechaViaje: (Date today addDays: 300) conCantPersonas: 4  conCantCuotas: 12  conFechaProxVenc: (Date today addDays: 30)."
(unaColClientes at:1) nuevoContratoFlexible: 2200 conViajeContratado: viaje6  conFechaViaje: (Date today addDays: 55) conCantPersonas: 2  conCantCuotas: 12  conFechaProxVenc: (Date today addDays: 30) conPlus: true.


nuevaEmpresaTurismo inicializarConClientes: unaColClientes conViajes: unaColViajes.
^ nuevaEmpresaTurismo.
]

{ #category : #queries }
EmpresaTurismo >> agregarCliente: unCliente [
colClientes add: unCliente.
]

{ #category : #queries }
EmpresaTurismo >> agregarExcursion: nroContrato conNombre: unNombre conCosto: unCosto conCantidad: unaCantidadPersonas [
|unContrato indice|
unContrato := nil.
indice := 1.
[indice <= colClientes size and: [unContrato isNil]] whileTrue: [
	|cadaCliente|
	cadaCliente := colClientes at: indice. "Obtiene el elemento en el índice actual"
	unContrato := cadaCliente buscarContratoEnCliente: nroContrato.
	unContrato ifNotNil: [
		unContrato registrarEnContrato: unNombre conCosto: unCosto conCantidad: unaCantidadPersonas.
		(unContrato getViajeContratado) restarPersonasDesdeViaje: unNombre conCantidad: unaCantidadPersonas.
	].
	"Incrementa el índice para pasar al siguiente elemento"
	indice := indice + 1.
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
EmpresaTurismo >> buscarClienteDesdeEmpresa: unDni [
|unCliente|
unCliente := nil.
unCliente:= colClientes detect: [:cadaCliente| cadaCliente buscarClienteconDni: unDni.] ifNone: [nil].
^unCliente.
]

{ #category : #'as yet unclassified' }
EmpresaTurismo >> buscarViajeDesdeEmpresa: unNombre [
|unViaje|
unViaje := nil.
unViaje := colViajes detect: [:cadaViaje| cadaViaje buscarViaje: unNombre.] ifNone: [nil].
^unViaje.
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
EmpresaTurismo >> efectivizacionContrato [

colClientes do: [ :cliente | cliente efectivizarEnCliente ]. 


]

{ #category : #'as yet unclassified' }
EmpresaTurismo >> eliminaCliente: dniIn [
colClientes remove: (self buscarClienteDesdeEmpresa: dniIn ) ifAbsent: [^false].
^true
]

{ #category : #queries }
EmpresaTurismo >> inicializar [
colClientes := OrderedCollection new.
colViajes := OrderedCollection new.
]

{ #category : #queries }
EmpresaTurismo >> inicializarConClientes: unaColClientes conViajes: unaColViajes [
colClientes := unaColClientes.
colViajes := unaColViajes.
]

{ #category : #'as yet unclassified' }
EmpresaTurismo >> listarInfoViajes [
|aux colViajesDisponibles|
aux := nil.
colViajesDisponibles := OrderedCollection new.
colViajes do: [:cadaViaje |
aux := (cadaViaje buscarInfo).
(aux isNotNil) ifTrue: [colViajesDisponibles add: aux].
].
^ colViajesDisponibles.
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

{ #category : #'as yet unclassified' }
EmpresaTurismo >> listarInfoViajesEspeciales [
|aux colViajesDisponibles|
aux := nil.
colViajesDisponibles := OrderedCollection new.
colViajes do: [:cadaViaje |
aux := (cadaViaje buscarInfo).
(aux isNotNil & cadaViaje isKindOf: ViajeEspecial) ifTrue: [colViajesDisponibles add: aux].
].
^ colViajesDisponibles.
]

{ #category : #'as yet unclassified' }
EmpresaTurismo >> listarInfoViajesOrganizados [
|aux colViajesDisponibles|
aux := nil.
colViajesDisponibles := OrderedCollection new.
colViajes do: [:cadaViaje |
aux := (cadaViaje buscarInfo).
(aux isNotNil & cadaViaje isKindOf: ViajeOrganizado) ifTrue: [colViajesDisponibles add: aux].
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
    | contratoEncontrado |
    contratoEncontrado := nil.
    
    colClientes do: [:cadaCliente |
        (cadaCliente buscarContratoEnCliente: nroContrato) ifNotNil: [
            contratoEncontrado := cadaCliente buscarContratoEnCliente: nroContrato.
            contratoEncontrado pagar: unaCantidad.
        ].
    ].


]
