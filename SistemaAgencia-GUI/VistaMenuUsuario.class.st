Class {
	#name : #VistaMenuUsuario,
	#superclass : #Interfaz,
	#instVars : [
		'botonGenerarCont',
		'botonVerFechas',
		'botonPagarCuotas',
		'botonExcurs',
		'botonVolver',
		'txtBienvenida',
		'dniUsuario',
		'usuario',
		'contratos',
		'botonPrueba',
		'txtOpcion',
		'info2',
		'botonFrecuente',
		'unViaje',
		'booleanPlus',
		'botonCancelacionMod'
	],
	#category : #'SistemaAgencia-GUI'
}

{ #category : #'as yet unclassified' }
VistaMenuUsuario class >> crearVistaMenuUsuario: empresaIn conDni: dniIn [
|vista|
vista:= self crear: empresaIn  conUsuario: dniIn.
^vista. 

]

{ #category : #'as yet unclassified' }
VistaMenuUsuario >> agregarExcursiones [
| ventana info colViajes infoViajes campoNumero botonA botonVolver2|

ventana := (Interfaz) crear: datosEmpresa x: 930 y: 525. 

"Buscamos la coleccion de viajes organizados(los unicos que pueden tener excursiones)"
colViajes := usuario listarInfoViajesOrganizados.

info := TextMorph new contents: 'Los Contratos del Cliente ', usuario getNombre, ' a los que puede agregar Excursiones son:'.
ventana añadirUnMorphCentrado: info conMargen: 10.

infoViajes:= self mostrarTabla: colViajes tituloCabecera: 'Contratos disponibles:'.
ventana añadirUnMorphCentrado: infoViajes conMargen: 30.

campoNumero := RubTextFieldMorph new extent: 200@20; ghostText:'Ingrese el Numero del contrato'.
ventana añadirUnMorphCentrado: campoNumero conMargen: 20.

botonA := BotonGenerico crear: 'ACEPTAR' x: 120 y:30 .
ventana  añadirUnMorphCentrado: botonA  conMargen:30 .
botonA mouseAction: [ventana delete. self verificarViajeOrganizado: campoNumero getText asNumber].

botonVolver2 := BotonGenerico crear: 'Volver Atras' x: 80 y: 30.
ventana añadirUnMorphCentrado: botonVolver2  conMargen:20.
botonVolver2 color: Color paleGreen.
botonVolver2 mouseAction: [ ventana delete. (self class)crearVistaMenuUsuario: datosEmpresa conDni:usuario getDni ].

ventana openCenteredInWorld.
]

{ #category : #'as yet unclassified' }
VistaMenuUsuario >> cancelarContrato: numeroContratoIn [
|unContrato fechaVieja|
unContrato := usuario buscarContratoEnCliente: numeroContratoIn.

unContrato ifNotNil: [
    (unContrato isKindOf: ContratoFlexible) ifTrue: [
			(unContrato getViajeContratado isKindOf: ViajeEspecial) ifTrue: [
				(unContrato getViajeContratado) devolverDisponibilidad: (unContrato getCantPersonas).
				(usuario isKindOf: ViajeroFrecuente) ifTrue: [
					usuario eliminaContrato: numeroContratoIn conMillas: (unContrato buscarValorReembolso) asInteger.
				] ifFalse: [ 
					usuario eliminaContrato: numeroContratoIn.
				].
				(self class) crearVistaMenuUsuario: datosEmpresa conDni: usuario getDni.
				CartelError new iniciarError: 'Se cancelo el Contrato ', (unContrato getNumContrato) asString,',  
      se reembolsaron $', ((unContrato buscarValorReembolso) asInteger) asString x: 350 y:50.
			] ifFalse: [
				fechaVieja := (unContrato getViajeContratado) buscarFechaDeViaje: (unContrato getFechaViaje).
				fechaVieja devolverCupo: (unContrato getCantPersonas).
				(usuario isKindOf: ViajeroFrecuente) ifTrue: [
					usuario eliminaContrato: numeroContratoIn conMillas: (unContrato buscarValorReembolso) asInteger.
				] ifFalse: [ 
					usuario eliminaContrato: numeroContratoIn.
				].
				(self class) crearVistaMenuUsuario: datosEmpresa conDni: usuario getDni.
				CartelError new iniciarError: 'Se cancelo el Contrato ', (unContrato getNumContrato) asString,',  
      se reembolsaron $', ((unContrato buscarValorReembolso) asInteger) asString x: 350 y:50.
			]
    ] ifFalse: [ 
        self cancelarModificarContrato.
        CartelError new iniciarError: 'El Contrato no es Flexible' x: 200 y:40.
    ]
]ifNil: [
    self cancelarModificarContrato.
    CartelError new iniciarError: 'El Contrato no existe' x: 200 y:40.
]
]

{ #category : #'as yet unclassified' }
VistaMenuUsuario >> cancelarModificarContrato [
|ventana stringAux stringSeparado infoContratos campoNumero botonVolver2 botonCancelar botonModificar |
ventana := (Interfaz) crear: datosEmpresa x: 800 y: 400. 

"Creamos una lista de strings que muestran la info de los viajes"
stringAux := usuario listarContratos.
stringSeparado := self separarString: stringAux.

infoContratos:= self mostrarTabla: stringSeparado tituloCabecera: 'Contratos del Cliente ', usuario getNombre,': 'x:750 y: 150.
ventana añadirUnMorphCentrado: infoContratos conMargen: 0.

campoNumero := RubTextFieldMorph new extent: 260@20; ghostText:'Ingrese el Numero del Contrato'.
ventana añadirUnMorphCentrado: campoNumero conMargen: 25.

botonCancelar := BotonGenerico crear: 'Cancelar'x: 120 y:30 .
ventana  añadirUnMorphCentrado: botonCancelar  conMargen:25.
botonCancelar mouseAction: [ventana delete. self cancelarContrato: (campoNumero getText) asNumber].

botonModificar := BotonGenerico crear: 'Modificar'x: 120 y:30 .
ventana  añadirUnMorphCentrado: botonModificar  conMargen:20.
botonModificar mouseAction: [ventana delete. self modificarContrato: (campoNumero getText) asNumber].

botonVolver2 := BotonGenerico crear: 'Volver Atras' x: 80 y: 30.
ventana añadirUnMorphCentrado: botonVolver2  conMargen:20.
botonVolver2 color: Color paleGreen.
botonVolver2 mouseAction: [ ventana delete. (self class)crearVistaMenuUsuario: datosEmpresa conDni:usuario getDni ].

ventana openCenteredInWorld.
]

{ #category : #'as yet unclassified' }
VistaMenuUsuario >> cartelPlus: numeroContrato [

|ventana texto botonA botonC unContrato viaje|
unContrato := usuario buscarContratoEnCliente: numeroContrato.
viaje := datosEmpresa buscarViajeDesdeEmpresa: (unContrato buscarInfoViaje getNombre).
(unContrato isKindOf: ContratoFlexible) ifTrue: [ 
	ventana := (Interfaz) crear: datosEmpresa x: 270 y: 160.

texto := TextMorph new contents: 'Usted desea pagar: ', ((viaje getValorImpuesto * 50)/100) asString,' pesos
del viaje: ', viaje getNombre.
ventana añadirUnMorphCentrado: texto conMargen: 10 .

botonA := BotonGenerico crear: 'ACEPTAR'x: 120 y:30 .
ventana  añadirUnMorph: botonA  conMargen:15 .
botonA mouseAction: [ unContrato pagarPlus. ventana delete ] .

botonC := BotonGenerico crear: 'CANCELAR'x: 120 y:30 .
ventana  añadirUnMorph: botonC  alLado:botonA  .
botonC mouseAction: [ ventana delete ].

ventana openCenteredInWorld.
	 ] ifFalse: [ 
	CartelError new iniciarError: 'El contrato a pagar el Plus no es Flexible' x:260  y:35 
	 ]

]

{ #category : #opciones }
VistaMenuUsuario >> contratarViaje [
|ventana botonEspecial botonOrganizado |

ventana := (self class) crear: datosEmpresa x: 275 y: 255. 

txtOpcion := TextMorph new contents: 'Seleccione que Tipo de Viaje desea Contratar'.
ventana añadirUnMorphCentrado: txtOpcion conMargen: 5.

botonEspecial := BotonGenerico crear: 'Viaje Especial' x:125 y:30.
ventana añadirUnMorphCentrado: botonEspecial conMargen: 20.
botonEspecial mouseAction: [ventana delete. self contratarViajeEspecial].

botonOrganizado := BotonGenerico crear: 'Viaje Organizado' x:125 y:30.
ventana añadirUnMorphCentrado: botonOrganizado  conMargen: 20.
botonOrganizado mouseAction:[ventana delete. self contratarViajeOrganizado].

botonVolver  := BotonGenerico crear: 'Volver Atras' x:100 y:30.
ventana añadirUnMorphCentrado: botonVolver  conMargen:30.
botonVolver color: Color paleGreen.
botonVolver mouseAction: [ventana delete. (self class) crearVistaMenuUsuario: datosEmpresa conDni: usuario getDni].

ventana openCenteredInWorld.
]

{ #category : #opciones }
VistaMenuUsuario >> contratarViajeEspecial [
|ventana infoViajes campoNombre campoNroPersonas botonA botonVolver2 colViajes botonPlus|

ventana := (Interfaz) crear: datosEmpresa x: 930 y: 550. 

"Buscamos la coleccion de viajes"
colViajes := datosEmpresa listarInfoViajesEspeciales.

txtOpcion := TextMorph new contents: 'Seleccione el Viaje Especial que desea Contratar'.
ventana añadirUnMorphCentrado: txtOpcion conMargen: 10.

infoViajes:= self mostrarTabla: colViajes tituloCabecera: 'Viajes Especiales Disponibles: ' x: 880 y: 250.
ventana añadirUnMorphCentrado: infoViajes conMargen: 30.

campoNombre := RubTextFieldMorph new extent: 200@20; ghostText:'Ingrese el Nombre del Viaje'.
ventana añadirUnMorphCentrado: campoNombre conMargen: 20.

campoNroPersonas := RubTextFieldMorph new extent: 200@20; ghostText:'Ingrese la Cantidad de Personas'.
ventana añadirUnMorphCentrado: campoNroPersonas conMargen: 20.

botonA := BotonGenerico crear: 'ACEPTAR' x: 120 y:30 .
ventana  añadirUnMorphCentrado: botonA  conMargen:30 .
botonA mouseAction: [ventana delete. self verificarViajeDisponibleEspecial: campoNombre getText asString conCapacidad:campoNroPersonas getText asNumber ].

botonVolver2 := BotonGenerico crear: 'Volver Atras' x: 80 y: 30.
ventana añadirUnMorphCentrado: botonVolver2  conMargen:20.
botonVolver2 color: Color paleGreen.
botonVolver2 mouseAction: [ ventana delete. self contratarViaje].

booleanPlus := false.
botonPlus := BotonGenerico crear: 'Generar Contrato Flexible' x: 150 y:20.
ventana  addMorphFront: botonPlus.botonPlus position: campoNombre position + (300@0).
botonPlus mouseAction: [ self pagarConPlus ].

txtOpcion  := TextMorph new contents: ''.
txtOpcion addDependent: self.
ventana addMorphFront: txtOpcion. txtOpcion position: botonPlus position + (0@30).

ventana openCenteredInWorld.
]

{ #category : #'as yet unclassified' }
VistaMenuUsuario >> contratarViajeOrganizado [
| ventana colViajes infoViajes campoNombre botonA botonVolver2 botonPlus |
ventana := (Interfaz) crear: datosEmpresa x: 930 y: 525. 

"Buscamos la coleccion de viajes"
colViajes := datosEmpresa listarInfoViajesOrganizados.

txtOpcion := TextMorph new contents: 'Seleccione el Viaje Organizado que desea Contratar'.
ventana añadirUnMorphCentrado: txtOpcion conMargen: 10.

infoViajes:= self mostrarTabla: colViajes tituloCabecera: 'Viajes Organizados Disponibles: ' x: 880 y: 250.
ventana añadirUnMorphCentrado: infoViajes conMargen: 30.

campoNombre := RubTextFieldMorph new extent: 200@20; ghostText:'Ingrese el Nombre del Viaje'.
ventana añadirUnMorphCentrado: campoNombre conMargen: 20.

botonA := BotonGenerico crear: 'ACEPTAR' x: 120 y:30 .
ventana  añadirUnMorphCentrado: botonA  conMargen:30 .
botonA mouseAction: [ventana delete. self verificarViajeDisponibleOrganizado: campoNombre getText asString].

botonVolver2 := BotonGenerico crear: 'Volver Atras' x: 80 y: 30.
ventana añadirUnMorphCentrado: botonVolver2  conMargen:20.
botonVolver2 color: Color paleGreen.
botonVolver2 mouseAction: [ ventana delete. self contratarViaje].

booleanPlus := false.
botonPlus := BotonGenerico crear: 'Generar Contrato Flexible' x: 150 y:20.
ventana  addMorphFront: botonPlus.botonPlus position: campoNombre position + (300@0).
botonPlus mouseAction: [ self pagarConPlus ].

txtOpcion  := TextMorph new contents: ''.
txtOpcion addDependent: self.
ventana addMorphFront: txtOpcion. txtOpcion position: botonPlus position + (0@30).

ventana openCenteredInWorld.
]

{ #category : #'as yet unclassified' }
VistaMenuUsuario >> generarNuevoContrato: viajeIn conCantPersonas: cantIn conFecha: fechaIn [
|numContrato|

numContrato := (1000 to: 9999) atRandom.

(viajeIn isKindOf: ViajeEspecial) ifTrue: [
	viajeIn restarDisponibilidad: cantIn.
	usuario nuevoContrato: numContrato conViajeContratado: viajeIn  conFechaViaje: fechaIn conCantPersonas: cantIn  conCantCuotas: 12  conFechaProxVenc: (Date today addDays: 30).
] ifFalse: [ 
	fechaIn restarCupo: cantIn.
	usuario nuevoContrato: numContrato conViajeContratado: viajeIn  conFechaViaje: (fechaIn getFechaSalida) conCantPersonas: cantIn  conCantCuotas: 12  conFechaProxVenc: (Date today addDays: 30).
].
(usuario isKindOf: ViajeroFrecuente) ifTrue: [ usuario sumarMillas: ((viajeIn getCostoPersona * 10)/100) ].
(self class) crearVistaMenuUsuario: datosEmpresa conDni: usuario getDni.
]

{ #category : #'as yet unclassified' }
VistaMenuUsuario >> generarNuevoContratoFlexible: viajeIn conCantPersonas: cantIn conFecha: fechaIn [
|numContrato|
numContrato := (1000 to: 9999) atRandom.

(viajeIn isKindOf: ViajeEspecial) ifTrue: [
    viajeIn restarDisponibilidad: cantIn.
    usuario nuevoContratoFlexible: numContrato conViajeContratado: viajeIn  conFechaViaje: fechaIn conCantPersonas: cantIn  conCantCuotas: 12  conFechaProxVenc: (Date today addDays: 30) conPlus: false.
] ifFalse: [ 
    fechaIn restarCupo: cantIn.
    usuario nuevoContratoFlexible: numContrato conViajeContratado: viajeIn  conFechaViaje: (fechaIn getFechaSalida) conCantPersonas: cantIn  conCantCuotas: 12  conFechaProxVenc: (Date today addDays: 30) conPlus: false.
].
(usuario isKindOf: ViajeroFrecuente) ifTrue: [ usuario sumarMillas: ((viajeIn getCostoPersona * 10)/100) ].
(self class) crearVistaMenuUsuario: datosEmpresa conDni: usuario getDni.
]

{ #category : #'as yet unclassified' }
VistaMenuUsuario >> ingresarFechas [
| ventana campoDia1 campoMes1 campoAño1 texto1 texto2 campoMes2 campoDia2 campoAño2 botonA botonVolver2 |

ventana := (Interfaz) crear: datosEmpresa x: 250 y: 300. 

texto1 := TextMorph new contents: 'Ingrese la Primera Fecha'.
ventana añadirUnMorphCentrado: texto1 conMargen: 10.

campoMes1 := RubTextFieldMorph new extent: 50@20; ghostText:'MM'.
ventana añadirUnMorphCentrado: campoMes1 conMargen: 10. 

campoDia1 := RubTextFieldMorph new extent: 50@20; ghostText:'DD'.
campoDia1 position: campoMes1 position - (campoMes1 width + 10@0).
ventana addMorphBack: campoDia1.

campoAño1 := RubTextFieldMorph new extent: 50@20; ghostText:'YYYY'.
ventana añadirUnMorph: campoAño1 alLado: campoMes1.

texto2 := TextMorph new contents: 'Ingrese la Segunda Fecha'.
ventana añadirUnMorphCentrado: texto2 conMargen: 20.

campoMes2 := RubTextFieldMorph new extent: 50@20; ghostText:'MM'.
ventana añadirUnMorphCentrado: campoMes2 conMargen: 10. 

campoDia2 := RubTextFieldMorph new extent: 50@20; ghostText:'DD'.
campoDia2 position: campoMes2 position - (campoMes2 width + 10@0).
ventana addMorphBack: campoDia2.

campoAño2 := RubTextFieldMorph new extent: 50@20; ghostText:'YYYY'.
ventana añadirUnMorph: campoAño2 alLado: campoMes2. 

botonA := BotonGenerico crear: 'ACEPTAR' x: 120 y:30 .
ventana  añadirUnMorphCentrado: botonA  conMargen:30 .
botonA mouseAction: [ventana delete. self verificarFechas: campoDia1 mes1: campoMes1 año1: campoAño1 dia2: campoDia2 mes2: campoMes2 año2: campoAño2].

botonVolver2 := BotonGenerico crear: 'Volver Atras' x: 100 y: 30.
ventana añadirUnMorphCentrado: botonVolver2  conMargen:20.
botonVolver2 color: Color paleGreen.
botonVolver2 mouseAction: [ ventana delete. (self class)crearVistaMenuUsuario: datosEmpresa conDni:usuario getDni ].

ventana openCenteredInWorld.
]

{ #category : #initialization }
VistaMenuUsuario >> iniciar: empresaIn dniUsuario: dniIn [
|clAux|
usuario := empresaIn buscarClienteDesdeEmpresa: dniIn.

self iniciar: empresaIn  x:325  y:440.

txtBienvenida := StringMorph new contents: 'Bienvenido al Menu, Cliente ' , usuario getNombre; font: (LogicalFont familyName: 'Source Sans Pro' pointSize: 13).
self añadirUnMorphCentrado: txtBienvenida conMargen:0.

txtOpcion := TextMorph new contents: '¿Que desea realizar?'.
self añadirUnMorphCentrado: txtOpcion conMargen:5.

botonGenerarCont  := BotonGenerico crear: 'Generar un Nuevo Contrato'.
self añadirUnMorphCentrado: botonGenerarCont  conMargen:15.
botonGenerarCont mouseAction: [ self delete. self contratarViaje].

botonVerFechas  := BotonGenerico crear: 'Ver Viajes Disponibles en Tal Fecha'.
self añadirUnMorphCentrado: botonVerFechas  conMargen:20 .
botonVerFechas mouseAction: [self delete. self ingresarFechas].

botonPagarCuotas  := BotonGenerico crear: 'Pagar Cuotas de un Contrato'.
self añadirUnMorphCentrado: botonPagarCuotas  conMargen:20 .
botonPagarCuotas mouseAction: [ 
	self delete. 
	(usuario isKindOf: ViajeroFrecuente) ifTrue: [ 
		self pagarCuotasFrecuente 
	] ifFalse: [ 
	self pagarCuotas 
	] 
].

botonCancelacionMod  := BotonGenerico crear: 'Cancelar / Modificar un Contrato'.
self añadirUnMorphCentrado: botonCancelacionMod  conMargen:20 .
botonCancelacionMod mouseAction:[self delete. self cancelarModificarContrato].

botonExcurs  := BotonGenerico crear: 'Agregar Excursiones Opcionales a un Contrato'.
self añadirUnMorphCentrado: botonExcurs  conMargen:20 .
botonExcurs mouseAction:[self delete. self agregarExcursiones].

botonFrecuente  := BotonGenerico crear: 'Solicitar ser Viajero Frecuente' x:175 y:30.
self añadirUnMorph: botonFrecuente  conMargen:55.
botonFrecuente color: Color paleBlue .
botonFrecuente mouseAction: [ clAux :=(usuario cambiarModalidad: datosEmpresa).
	(clAux = usuario) ifFalse: [ 
usuario addDependent:self. self delete.(self class)crearVistaMenuUsuario: datosEmpresa  conDni: usuario getDni. CartelError new iniciarError: 'Usted es ahora Viajero Frecuente' x:200  y:40  ] ifTrue: [  
	CartelError new iniciarError: 'Usted no puede ser Viajero Frecuente' x:230  y:40  
	]
].

botonVolver := BotonGenerico crear: 'Cerrar Sesion' x:110 y:30.
self añadirUnMorph: botonVolver alLado: botonFrecuente.
botonVolver color: Color paleGreen.
botonVolver mouseAction: [ self delete. VistaInicioSesion crearVistaInicio: empresaIn ].

self openCenteredInWorld.
]

{ #category : #'as yet unclassified' }
VistaMenuUsuario >> modificarContrato: numeroContratoIn [
|unContrato ventana colFechas infoFechas campoFecha botonA botonVolver2 |
unContrato := usuario buscarContratoEnCliente: numeroContratoIn.
unContrato ifNotNil: [
	(unContrato isKindOf: ContratoFlexible) ifTrue: [
		unViaje := unContrato getViajeContratado.
		(unViaje isKindOf: ViajeOrganizado) ifTrue: [ 
			ventana := (Interfaz) crear: datosEmpresa x: 930 y: 470. 
	
			colFechas := unViaje listarFechas.

			txtOpcion := TextMorph new contents: 'Seleccione la nueva Fecha de Salida del Viaje ', (unContrato getViajeContratado) getNombre.
			ventana añadirUnMorphCentrado: txtOpcion conMargen: 10.

			infoFechas:= self mostrarTabla: colFechas tituloCabecera: 'Fechas Disponibles: ' x: 880 y: 200.
			ventana añadirUnMorphCentrado: infoFechas conMargen: 30.

			campoFecha := RubTextFieldMorph new extent: 200@20; ghostText:'Ingrese el Numero de Fecha'.
			ventana añadirUnMorphCentrado: campoFecha conMargen: 20.

			botonA := BotonGenerico crear: 'ACEPTAR' x: 120 y:30 .
			ventana  añadirUnMorphCentrado: botonA  conMargen:30 .
			botonA mouseAction: [ventana delete. self verificarNuevaFechaOrganizado: unViaje conNumeroFecha: (campoFecha getText) asNumber conContrato: unContrato].

			botonVolver2 := BotonGenerico crear: 'Volver Atras' x: 80 y: 30.
			ventana añadirUnMorphCentrado: botonVolver2  conMargen:20.
			botonVolver2 color: Color paleGreen.
			botonVolver2 mouseAction: [ ventana delete. self cancelarModificarContrato].

			ventana openCenteredInWorld.
		] ifFalse: [ 
			self cancelarModificarContrato.
			CartelError new iniciarError: 'No se puede modificar la fecha de un Viaje Especial' x: 300 y:40.	
		]
	] ifFalse: [ 
		self cancelarModificarContrato.
		CartelError new iniciarError: 'El Contrato no es Flexible' x: 200 y:40.
	] 
]ifNil: [
	self cancelarModificarContrato.
	CartelError new iniciarError: 'El Contrato no existe' x: 200 y:40.
]

]

{ #category : #'as yet unclassified' }
VistaMenuUsuario >> pagarConPlus [
(booleanPlus = false) ifTrue:  [ 
	booleanPlus := true.
	txtOpcion contents: 'Usted decidio pagar el Contrato con un Plus.'
] ifFalse: [ 
	booleanPlus := false.
	txtOpcion contents: 'Usted decidio NO pagar el Contrato con un Plus.'
]
]

{ #category : #'as yet unclassified' }
VistaMenuUsuario >> pagarCuotas [
|ventana stringSeparado stringAux infoContratos campoNumero campoCantidad botonA botonVolver2 botonPagarPlus |

ventana := (Interfaz) crear: datosEmpresa x: 800 y: 380. 

"Creamos una lista de strings que muestran la info de los viajes"
stringAux := usuario listarContratos.
stringSeparado := self separarString: stringAux.

infoContratos:= self mostrarTabla: stringSeparado tituloCabecera: 'Contratos a Pagar del Cliente ', usuario getNombre,': ' x:750 y: 150.
ventana añadirUnMorphCentrado: infoContratos conMargen: 0.

campoNumero := RubTextFieldMorph new extent: 260@20; ghostText:'Ingrese el Numero del Contrato'.
ventana añadirUnMorphCentrado: campoNumero conMargen: 25.

campoCantidad := RubTextFieldMorph new extent: 260@20; ghostText:'Ingrese la cantidad de cuotas que desea pagar'.
ventana añadirUnMorphCentrado: campoCantidad conMargen: 20.

botonA := BotonGenerico crear: 'ACEPTAR'x: 120 y:30 .
ventana  añadirUnMorphCentrado: botonA  conMargen:25 .
botonA mouseAction: [ventana delete. self verificarCuotas: (campoNumero getText asNumber) conCantidad: (campoCantidad getText asNumber)].

botonVolver2 := BotonGenerico crear: 'Volver Atras' x: 80 y: 30.
ventana añadirUnMorphCentrado: botonVolver2  conMargen:20.
botonVolver2 color: Color paleGreen.
botonVolver2 mouseAction: [ ventana delete. (self class)crearVistaMenuUsuario: datosEmpresa conDni:usuario getDni ].

botonPagarPlus := BotonGenerico crear: 'Pagar Plus' x: 80 y: 30.
ventana addMorphFront: botonPagarPlus.botonPagarPlus position: botonA position + (200@0).
botonPagarPlus mouseAction: [ self cartelPlus:(campoNumero getText asNumber)  ].


ventana openCenteredInWorld.
]

{ #category : #'as yet unclassified' }
VistaMenuUsuario >> pagarCuotasFrecuente [
|ventana stringSeparado stringAux infoContratos campoNumero campoCantidad botonA botonVolver2 mostrarMillas campoCantMillas botonPagarPlus |

ventana := (Interfaz) crear: datosEmpresa x: 800 y: 380. 

"Creamos una lista de strings que muestran la info de los viajes"
stringAux := usuario listarContratos.
stringSeparado := self separarString: stringAux.

infoContratos:= self mostrarTabla: stringSeparado tituloCabecera: 'Contratos a Pagar del Cliente ', usuario getNombre,': ' x:750 y: 150.
ventana añadirUnMorphCentrado: infoContratos conMargen: 0.

campoNumero := RubTextFieldMorph new extent: 260@20; ghostText:'Ingrese el Numero del Contrato'.
ventana añadirUnMorph: campoNumero conMargen: 25.
campoNumero position: campoNumero position + (115@0).

campoCantidad := RubTextFieldMorph new extent: 260@20; ghostText:'Ingrese las cuotas que desea pagar'.
ventana añadirUnMorph: campoCantidad conMargen: 15.
ventana addMorphFront: campoCantidad. campoCantidad position: campoNumero position + (0@30).

mostrarMillas := StringMorph contents: 'Usted posee: ', usuario getMillas asString,' millas'.
ventana addMorphFront: mostrarMillas. mostrarMillas position: campoNumero position +(300@0).

campoCantMillas := RubTextFieldMorph new extent: 230@20; ghostText: 'Ingrese las cuotas a pagar con Millas' .
ventana addMorphFront: campoCantMillas. campoCantMillas position: mostrarMillas position + (0@30).

botonA := BotonGenerico crear: 'ACEPTAR'x: 120 y:30.
ventana  añadirUnMorphCentrado: botonA  conMargen:50.
botonA mouseAction: [ventana delete. self verificarCuotasFrecuente:(campoNumero getText asNumber) conCantidad: (campoCantidad getText asNumber) conCuotasMillas: (campoCantMillas getText asNumber)].

botonVolver2 := BotonGenerico crear: 'Volver Atras' x: 80 y: 30.
ventana añadirUnMorphCentrado: botonVolver2  conMargen:15.
botonVolver2 color: Color paleGreen.
botonVolver2 mouseAction: [ ventana delete. (self class)crearVistaMenuUsuario: datosEmpresa conDni:usuario getDni ].

botonPagarPlus := BotonGenerico crear: 'Pagar Plus' x: 80 y: 30.
ventana addMorphFront: botonPagarPlus.botonPagarPlus position: botonA position + (200@0).
botonPagarPlus mouseAction: [ self cartelPlus:(campoNumero getText asNumber)  ].

ventana openCenteredInWorld.

]

{ #category : #'as yet unclassified' }
VistaMenuUsuario >> separarString: unString [
|partes|
partes := OrderedCollection new.
partes := unString findTokens: '/'.
^ partes.
]

{ #category : #'as yet unclassified' }
VistaMenuUsuario >> verificarCuotas: numeroContratoIn conCantidad: numeroCuotasIn [
|unContrato|
unContrato := usuario buscarContratoEnCliente: numeroContratoIn.
unContrato ifNotNil: [
	((unContrato getCuotasAPagar) > 0) ifTrue:[
		((unContrato getCuotasAPagar)>= numeroCuotasIn) ifTrue: [
			datosEmpresa realizarPago: numeroContratoIn conCantidad: numeroCuotasIn.
			(self class) crearVistaMenuUsuario: datosEmpresa conDni: usuario getDni.
			CartelError new iniciarError: 'Se pagaron ', numeroCuotasIn asString, ' cuotas del Contrato ', numeroContratoIn asString x: 500 y:40.
		] ifFalse: [
			self pagarCuotas.
			CartelError new iniciarError: 'Ingrese una cantidad valida' x: 300 y:40.
		]
	] ifFalse: [ 
		self pagarCuotas.
		CartelError new iniciarError: 'El Contrato ', numeroContratoIn asString, ' ya esta pagado' x: 400 y:40.
	]
]ifNil: [
	self pagarCuotas.
	CartelError new iniciarError: 'El Contrato no existe' x: 200 y:40.
]
]

{ #category : #'as yet unclassified' }
VistaMenuUsuario >> verificarCuotasFrecuente: numeroContratoIn conCantidad: numeroCuotasIn conCuotasMillas: cantMillas [
|unContrato|
unContrato := usuario buscarContratoEnCliente: numeroContratoIn.
unContrato ifNotNil: [
	((unContrato getCuotasAPagar) > 0) ifTrue:[
		((usuario getMillas/100)<cantMillas)ifTrue: [
			self pagarCuotasFrecuente.
			CartelError new iniciarError: 'No tiene suficientes millas para pagar' x: 220 y:40.
		] ifFalse: [ 
			(((unContrato getCuotasAPagar) < (numeroCuotasIn+cantMillas))) ifTrue: [
				self pagarCuotasFrecuente.
				CartelError new iniciarError: 'Ingrese una cantidad valida' x: 300 y:40. 
			] ifFalse: [ 
				datosEmpresa realizarPago: numeroContratoIn conCantidad: (numeroCuotasIn+cantMillas).
				usuario restarMillas: (cantMillas * 100).
				(self class) crearVistaMenuUsuario: datosEmpresa conDni: usuario getDni.
				CartelError new iniciarError: 'Se pagaron ', (numeroCuotasIn+cantMillas) asString, ' cuotas del Contrato ', numeroContratoIn asString x: 600 y:40.
			]
		]
	] ifFalse: [
		self pagarCuotasFrecuente.
		CartelError new iniciarError: 'El Contrato ', numeroContratoIn asString, ' ya esta pagado' x: 400 y:40.
	]	
] ifNil: [
	self pagarCuotasFrecuente.
	CartelError new iniciarError: 'El Contrato no existe' x: 200 y:40 
]
]

{ #category : #'as yet unclassified' }
VistaMenuUsuario >> verificarExcursion: unNombre conCapacidad: unNumPersonas conContrato: unContrato [
|excursion|

excursion := unViaje buscarExcursionDesdeViaje: unNombre.
(excursion) ifNotNil: [
	(excursion getCantPersonasExcursion >= unNumPersonas) ifTrue: [ 
		(unNumPersonas < (unContrato getCantPersonas)) ifTrue: [
			((Date today) < ((unContrato getFechaViaje) - 7 days)) ifTrue: [ 
				datosEmpresa agregarExcursion: (unContrato getNumContrato) conNombre: unNombre conCosto: (excursion getCostoExcursion) conCantidad: unNumPersonas.
				(self class) crearVistaMenuUsuario: datosEmpresa conDni: usuario getDni.
				CartelError new iniciarError: 'Se agrego la Excursion al Contrato ', (unContrato getNumContrato) asString x: 400 y:40.
			] ifFalse: [ 
				self verificarViajeOrganizado: (unContrato getNumContrato).
				CartelError new iniciarError: 'No puede contratarse la Excursion una semana antes del viaje' x: 400 y:40.
			]
		] ifFalse: [ 
			self verificarViajeOrganizado: (unContrato getNumContrato).
			CartelError new iniciarError: 'No puede contratarse la Excursion para ', unNumPersonas asString, ' personas' x: 400 y:40.
		]
	] ifFalse: [ 
		self verificarViajeOrganizado: (unContrato getNumContrato).
		CartelError new iniciarError: 'La Excursion no cuenta con ', unNumPersonas asString,' espacios' x: 400 y:40.
	]
]ifNil: [
	self verificarViajeOrganizado: (unContrato getNumContrato).
    CartelError new iniciarError: 'La Excursion no existe' x: 200 y:40.
]
]

{ #category : #'as yet unclassified' }
VistaMenuUsuario >> verificarFecha: unNombre conFecha: unNumeroFecha conCantPersonas: capacidadIn [
|viaje fecha|

viaje := datosEmpresa buscarViajeDesdeEmpresa: unNombre.
fecha := viaje buscarFechaDesdeViaje: unNumeroFecha.

(fecha) ifNotNil: [
    ((fecha getCupo)>= capacidadIn) ifTrue: [
        (booleanPlus)ifTrue: [ 
            self generarNuevoContratoFlexible: viaje conCantPersonas: capacidadIn conFecha: fecha.
            CartelError new iniciarError: 'El Cliente ', usuario getNombre, ' genero un nuevo Contrato Flexible' x: 350 y:40.
             ] ifFalse: [ 
            self generarNuevoContrato: viaje conCantPersonas: capacidadIn conFecha: fecha.
            CartelError new iniciarError: 'El Cliente ', usuario getNombre, ' genero un nuevo Contrato Comun' x: 350 y:40.
             ].
    ] ifFalse: [
        self contratarViaje.
        CartelError new iniciarError: 'No hay suficiente capacidad' x: 200 y:40
    ]
]ifNil: [
    self contratarViaje.
    CartelError new iniciarError: 'Fecha no Existe' x: 200 y:40 
]
]

{ #category : #'as yet unclassified' }
VistaMenuUsuario >> verificarFechas: campoDia1 mes1: campoMes1 año1: campoAño1 dia2: campoDia2 mes2: campoMes2 año2: campoAño2 [
|fecha1 fecha2 ventana coleccion infoViajes botonA|

fecha1 := Date newDay: (campoDia1 getText) asNumber month: (campoMes1 getText) asNumber year: (campoAño1 getText) asNumber.
fecha2 := Date newDay: (campoDia2 getText) asNumber month: (campoMes2 getText) asNumber year: (campoAño2 getText) asNumber.

coleccion := datosEmpresa listarInfoViajes: fecha1 conFecha2: fecha2. 

(coleccion isEmpty) ifTrue: [ 
	self ingresarFechas.
	CartelError new iniciarError: 'No existen Viajes Disponibles entre las fechas ', (campoDia1 getText) asString, '-',(campoMes1 getText) asString, '-',(campoAño1 getText) asString, ' y ', (campoDia2 getText) asString, '-',(campoMes2 getText) asString, '-',(campoAño2 getText) asString x: 420 y:50 
] ifFalse: [ 
	ventana := (Interfaz) crear: datosEmpresa x: 930 y: 390.
	
	infoViajes:= self mostrarTabla: coleccion tituloCabecera: 'Viajes Disponibles entre ', (campoDia1 getText) asString, '-',(campoMes1 getText) asString, '-',(campoAño1 getText) asString, ' y ', (campoDia2 getText) asString, '-',(campoMes2 getText) asString, '-',(campoAño2 getText) asString.
	
	ventana añadirUnMorphCentrado: infoViajes conMargen: 10.

	botonA := BotonGenerico crear: 'ACEPTAR' x: 120 y:30 .
	ventana  añadirUnMorphCentrado: botonA  conMargen:30 .
	botonA mouseAction: [ventana delete. self ingresarFechas].
	
	ventana openCenteredInWorld.
].








]

{ #category : #'as yet unclassified' }
VistaMenuUsuario >> verificarNuevaFechaOrganizado: viajeIn conNumeroFecha: unNumeroFecha conContrato: unContrato [
|fecha fechaVieja|
fecha := viajeIn buscarFechaDesdeViaje: unNumeroFecha.
(fecha) ifNotNil: [
    ((fecha getCupo) >= (unContrato getCantPersonas)) ifTrue: [
			fechaVieja := (unContrato getViajeContratado) buscarFechaDeViaje: (unContrato getFechaViaje).
			fechaVieja devolverCupo: (unContrato getCantPersonas).
        	unContrato modificarFecha: (fecha getFechaSalida).
        	fecha restarCupo: (unContrato getCantPersonas).
        	(self class) crearVistaMenuUsuario: datosEmpresa conDni: usuario getDni.
      		CartelError new iniciarError: 'Se modifico la Fecha del Viaje del Contrato ', (unContrato getNumContrato) asString x: 350 y:40.
    ] ifFalse: [
        self cancelarModificarContrato.
        CartelError new iniciarError: 'No hay suficiente capacidad en esa Fecha' x: 300 y:40
    ]
]ifNil: [
    self cancelarModificarContrato.
    CartelError new iniciarError: 'Fecha no Existe' x: 200 y:40 
]




]

{ #category : #'as yet unclassified' }
VistaMenuUsuario >> verificarViajeDisponibleEspecial: nombreViajeIn conCapacidad: capacidadIn [
|viaje |
viaje := datosEmpresa buscarViajeDesdeEmpresa: nombreViajeIn.
"viaje ifNotNil: ["
((viaje isKindOf: ViajeEspecial) & (viaje isNotNil)) ifTrue: [ 
    ((viaje getDisponibilidad)>= capacidadIn) ifTrue: [
                (booleanPlus)ifTrue: [ 
            self generarNuevoContratoFlexible:viaje conCantPersonas: capacidadIn conFecha: viaje getFecha.
            CartelError new iniciarError: 'El Cliente ', usuario getNombre, ' genero un nuevo Contrato Flexible' x: 350 y:40.
             ] ifFalse: [ 
            self generarNuevoContrato: viaje conCantPersonas: capacidadIn conFecha: viaje getFecha.
            CartelError new iniciarError: 'El Cliente ', usuario getNombre, ' genero un nuevo Contrato Comun' x: 350 y:40.
             ].
    ] ifFalse: [
        self contratarViajeEspecial.
        CartelError new iniciarError: 'No hay suficiente capacidad' x: 200 y:40
    ]
]ifFalse: [
    self contratarViajeEspecial.
    CartelError new iniciarError: 'Viaje no Existe' x: 200 y:40 
]
]

{ #category : #'as yet unclassified' }
VistaMenuUsuario >> verificarViajeDisponibleOrganizado: unNombre [
| colFechas ventana infoFechas campoFecha campoNroPersonas botonA botonVolver2 |

unViaje := datosEmpresa buscarViajeDesdeEmpresa: unNombre.

((unViaje isKindOf: ViajeOrganizado) & (unViaje isNotNil)) ifTrue:[
	ventana := (Interfaz) crear: datosEmpresa x: 930 y: 520. 
	
	colFechas := unViaje listarFechas.

	txtOpcion := TextMorph new contents: 'Seleccione la Fecha de Salida del Viaje'.
	ventana añadirUnMorphCentrado: txtOpcion conMargen: 10.

	infoFechas:= self mostrarTabla: colFechas tituloCabecera: 'Fechas Disponibles: ' x: 880 y: 200.
	ventana añadirUnMorphCentrado: infoFechas conMargen: 30.

	campoFecha := RubTextFieldMorph new extent: 200@20; ghostText:'Ingrese el Numero de Fecha'.
	ventana añadirUnMorphCentrado: campoFecha conMargen: 20.

	campoNroPersonas := RubTextFieldMorph new extent: 200@20; ghostText:'Ingrese la Cantidad de Personas'.
	ventana añadirUnMorphCentrado: campoNroPersonas conMargen: 20.

	botonA := BotonGenerico crear: 'ACEPTAR' x: 120 y:30 .
	ventana  añadirUnMorphCentrado: botonA  conMargen:30 .
	botonA mouseAction: [ventana delete. self verificarFecha: unNombre conFecha: campoFecha getText asNumber conCantPersonas: campoNroPersonas getText asNumber].

	botonVolver2 := BotonGenerico crear: 'Volver Atras' x: 80 y: 30.
	ventana añadirUnMorphCentrado: botonVolver2  conMargen:20.
	botonVolver2 color: Color paleGreen.
	botonVolver2 mouseAction: [ ventana delete. self contratarViajeOrganizado].

	ventana openCenteredInWorld.
	
] ifFalse: [ 
	self contratarViajeOrganizado.
	CartelError new iniciarError: 'El Viaje no existe' x: 200 y:40.
].

]

{ #category : #'as yet unclassified' }
VistaMenuUsuario >> verificarViajeOrganizado: numeroContratoIn [
|unContrato ventana info colExcursiones infoViajes campoNombre campoNroPersonas botonA botonVolver2 |

unContrato := usuario buscarContratoEnCliente: numeroContratoIn.

unContrato ifNotNil: [
	
	ventana := (Interfaz) crear: datosEmpresa x: 930 y: 480. 

	info := TextMorph new contents: 'Que Excursion desea agregarle al Contrato ', numeroContratoIn asString, '?'.
	ventana añadirUnMorphCentrado: info conMargen: 10.

	"Buscamos la coleccion de excursiones del viaje del contrato"
	unViaje := datosEmpresa buscarViajeDesdeEmpresa: (unContrato buscarInfoViaje getNombre).
	colExcursiones := unViaje listarExcursiones.

	infoViajes:= self mostrarTabla: colExcursiones tituloCabecera: 'Excursiones Disponibles: ' x: 880 y: 170.
	ventana añadirUnMorphCentrado: infoViajes conMargen: 30.

	campoNombre := RubTextFieldMorph new extent: 300@20; ghostText:'Ingrese el Nombre de la Excursion'.
	ventana añadirUnMorphCentrado: campoNombre conMargen: 20.

	campoNroPersonas := RubTextFieldMorph new extent: 300@20; ghostText:'Ingrese la Cantidad de Personas'.
	ventana añadirUnMorphCentrado: campoNroPersonas conMargen: 20.

	botonA := BotonGenerico crear: 'ACEPTAR' x: 120 y:30 .
	ventana  añadirUnMorphCentrado: botonA  conMargen:30 .
	botonA mouseAction: [ventana delete. self verificarExcursion: campoNombre getText asString conCapacidad: campoNroPersonas getText asNumber conContrato: unContrato].

	botonVolver2 := BotonGenerico crear: 'Volver Atras' x: 80 y: 30.
	ventana añadirUnMorphCentrado: botonVolver2  conMargen:20.
	botonVolver2 color: Color paleGreen.
	botonVolver2 mouseAction: [ ventana delete. self agregarExcursiones].

	ventana openCenteredInWorld.
]ifNil: [ 
	self agregarExcursiones.
	CartelError new iniciarError: 'El contrato no existe' x: 200 y:40 
]
]
