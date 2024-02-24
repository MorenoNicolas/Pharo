Class {
	#name : #VistaMenuAdministrador,
	#superclass : #Interfaz,
	#instVars : [
		'botonListaClientes',
		'botonABM',
		'botonVolver',
		'txtBienvenida',
		'txtOpcion',
		'txtAviso',
		'txtAviso2',
		'txtAviso3',
		'botonEfect'
	],
	#category : #'SistemaAgencia-GUI'
}

{ #category : #'as yet unclassified' }
VistaMenuAdministrador class >> crearVistaMenuAdministrador: empresaIn [
|vista|
vista:= self crear: empresaIn .
^empresaIn.
]

{ #category : #opciones }
VistaMenuAdministrador >> ABMdeViajes [
|botonAlta botonBaja botonMod txtBienvenida2 ventana|

ventana := (Interfaz) crear: datosEmpresa x: 325 y: 300. 

txtBienvenida2  := TextMorph new contents: 'Usted Selecciono: Altas, Bajas y Modificaciones de Viajes'.
ventana añadirUnMorphCentrado: txtBienvenida2 conMargen: 10.

botonAlta  := BotonGenerico crear: 'Crear un Viaje (alta)' x: 175 y: 30.
ventana añadirUnMorphCentrado: botonAlta  conMargen:30 .
botonAlta mouseAction: [ventana delete. self altaDeViajes].

botonBaja  := BotonGenerico crear: 'Eliminar un Viaje (baja)' x: 175 y: 30.
ventana añadirUnMorphCentrado: botonBaja  conMargen:20 .
botonBaja mouseAction: [ventana delete. self bajaDeViajes].

botonMod  := BotonGenerico crear: 'Modificar un Viaje' x: 175 y: 30.
ventana añadirUnMorphCentrado: botonMod  conMargen:20 .
botonMod mouseAction:[ventana delete. self modificacionDeViajes].

botonVolver  := BotonGenerico crear: 'Volver Atras' x: 100 y: 30.
ventana añadirUnMorphCentrado: botonVolver  conMargen:30.
botonVolver color: Color paleGreen.
botonVolver mouseAction: [ ventana delete. (VistaMenuAdministrador) crearVistaMenuAdministrador: datosEmpresa].

ventana openCenteredInWorld.
]

{ #category : #opciones }
VistaMenuAdministrador >> altaDeViajes [
|ventana txtBienvenida2 botonEspecial botonOrganizado|

ventana := (self class) crear: datosEmpresa x: 250 y: 275. 

txtBienvenida2 := TextMorph new contents: 'Usted Selecciono la opcion: Alta de Viajes'.
ventana añadirUnMorphCentrado: txtBienvenida2 conMargen: 10.

txtOpcion := TextMorph new contents: 'Seleccione que Tipo de Viaje desea Crear'.
ventana añadirUnMorphCentrado: txtOpcion conMargen: 5.

botonEspecial := BotonGenerico crear: 'Viaje Especial' x:125 y:30.
"ventana añadirUnMorph: botonEspecial  conMargen: 15."
ventana añadirUnMorphCentrado: botonEspecial conMargen: 20.
botonEspecial mouseAction: [ventana delete. self ingresarEspecial].

botonOrganizado := BotonGenerico crear: 'Viaje Organizado' x:125 y:30.
ventana añadirUnMorphCentrado: botonOrganizado  conMargen: 20.
botonOrganizado mouseAction:[ventana delete. self ingresarOrganizado].

botonVolver  := BotonGenerico crear: 'Volver Atras' x:100 y:30.
ventana añadirUnMorphCentrado: botonVolver  conMargen:30.
botonVolver color: Color paleGreen.
botonVolver mouseAction: [ventana delete. self ABMdeViajes].

ventana openCenteredInWorld.
]

{ #category : #'as yet unclassified' }
VistaMenuAdministrador >> bajaDeViajes [

|ventana txtBienvenida2 info infoViajes campoNombre botonA botonVolver2 colViajes |

ventana := (Interfaz) crear: datosEmpresa x: 1000 y: 575.

txtBienvenida2 := TextMorph new contents: 'Usted Selecciono la opcion: Baja de Viajes'.
ventana añadirUnMorphCentrado: txtBienvenida2 conMargen: 10.

info := TextMorph new contents: 'Los Viajes Disponibles para dar de baja son los siguientes: '.
ventana añadirUnMorphCentrado: info conMargen: 10.

"Creamos una coleccion con la info de los viajes"
colViajes := datosEmpresa listarInfoViajes.

infoViajes:= self mostrarTabla: colViajes tituloCabecera: 'Viajes Disponibles: '.
ventana añadirUnMorphCentrado: infoViajes conMargen: 30.

campoNombre := RubTextFieldMorph new extent: 200@20; ghostText:'Ingrese el Nombre del Viaje'.
ventana añadirUnMorphCentrado: campoNombre conMargen: 40.

botonA := BotonGenerico crear: 'ACEPTAR' x: 100 y: 30.
ventana  añadirUnMorphCentrado: botonA  conMargen:30.
botonA color: Color paleYellow.
botonA mouseAction: [ventana delete. self verificarViajeAEliminar: campoNombre getText asString].

botonVolver2 := BotonGenerico crear: 'Volver Atras' x: 100 y: 30.
ventana añadirUnMorphCentrado: botonVolver2  conMargen:20.
botonVolver2 color: Color paleYellow .
botonVolver2 mouseAction: [ ventana delete. self ABMdeViajes].

ventana openCenteredInWorld.
]

{ #category : #opciones }
VistaMenuAdministrador >> crearEspecial: empresaIn conNombre: campoNombre conCosto: campoCosto conImpuestos: campoImpuestos conCiudad: campoCiudad dia1: campoDia1 mes1: campoMes1 año1: campoAño1 dia2: campoDia2 mes2: campoMes2 año2: campoAño2 conDisponibilidad: campoDisponibilidad [
|nuevoViaje fechaSalida fechaRegreso |

((campoNombre text isEmpty) | (campoCosto text isEmpty) | (campoImpuestos text isEmpty) | (campoCiudad text isEmpty) | (campoDia1 text isEmpty) | (campoMes1 text isEmpty) | (campoAño1 text isEmpty) | (campoDia2 text isEmpty) | (campoMes2 text isEmpty) | (campoAño2 text isEmpty) | (campoDisponibilidad text isEmpty)) ifTrue: [
	self ingresarEspecial.
	CartelError new iniciarError: 'Uno de los campos esta vacio. Ingrese correctamente los datos' x:400  y:60.
] ifFalse: [
	fechaSalida := Date newDay: (campoDia1 getText) asNumber month: (campoMes1 getText) asNumber year: (campoAño1 getText) asNumber.
	fechaRegreso := Date newDay: (campoDia2 getText) asNumber month: (campoMes2 getText) asNumber year: (campoAño2 getText) asNumber.
	nuevoViaje := (ViajeEspecial) crear: (campoNombre getText) asString conCosto: (campoCosto getText) asNumber conValorImpuestos: (campoImpuestos getText) asNumber conCiudad: (campoCiudad  getText) asString conFechaSalida: fechaSalida conFechaRegreso: fechaRegreso conDisponibilidad: (campoDisponibilidad getText) asNumber.
	datosEmpresa agregarViaje: nuevoViaje.
	self altaDeViajes.
	CartelError new iniciarError: 'El viaje se cargo correctamente' x:200  y:60. "CAMBIAR ESTO"
]
]

{ #category : #'as yet unclassified' }
VistaMenuAdministrador >> crearExcursionNueva: campoNombreExc conCosto: campoCostoExc conCantPersonas: campoCantPersonasExc [
|nuevaExcursion|
nuevaExcursion := Excursion crear: (campoNombreExc getText) asString conCosto: (campoCostoExc getText) asNumber conCantPersonas: (campoCantPersonasExc getText) asNumber.
^nuevaExcursion. 
]

{ #category : #'as yet unclassified' }
VistaMenuAdministrador >> crearFechaNueva: dias conMeses: mes conAnio: anio conCupos: cupos [
|fechaConCupo fecha|
fecha := Date newDay: (dias getText) asNumber month: (mes getText) asNumber year: (anio getText) asNumber.
fechaConCupo := Fecha crear: fecha conCupo: cupos getText asNumber.
^fechaConCupo.
]

{ #category : #'as yet unclassified' }
VistaMenuAdministrador >> crearNuevaEtapa:dias conMes: mes conAnio: anio conCantDias: unCantDia conHotel: unHotel conPension: unaPension conActiv: unasActi conCiudad: unaCiudad [ 
|fechaT etapaT|
fechaT:= Date newDay: (dias getText) asNumber month: (mes getText) asNumber year: (anio getText) asNumber.
etapaT :=Etapa crear: fechaT conCantidadDias: unCantDia getText asNumber conHotel: unHotel getText asString  conTipoPension:unaPension getText asString  conListaActividades: unasActi getText asString conCiudad: unaCiudad getText asString .
^etapaT.
]

{ #category : #'as yet unclassified' }
VistaMenuAdministrador >> crearViajeOrganizado: unNombre conCosto: unCosto conValorImpuestos: unosImpuestos conDias: unosDias conEtapas: unasEtapas conFechas: unasFechas conExcursiones: unasExcursiones [
|viaje|
((unNombre text isEmpty) | (unCosto text isEmpty) | (unosImpuestos text isEmpty) | (unosDias text isEmpty) | (unasFechas isEmpty) | (unasExcursiones isEmpty)) ifTrue: [
    self ingresarOrganizado.
    CartelError new iniciarError: 'Uno de los campos esta vacio. Ingrese correctamente los datos' x:400  y:60.
] ifFalse: [
    viaje := ViajeOrganizado crear:unNombre getText asString conCosto: unCosto getText asNumber conValorImpuestos:unosImpuestos getText asNumber conDias: unosDias getText asNumber conEtapas: unasEtapas conFechas: unasFechas conExcursiones: unasExcursiones.
    datosEmpresa agregarViaje: viaje.
    self altaDeViajes.
    CartelError new iniciarError: 'El viaje se cargo correctamente' x:200  y:60. "CAMBIAR ESTO"
]
]

{ #category : #opciones }
VistaMenuAdministrador >> ingresarEspecial [
|ventana txtBienvenida2 campoNombre campoCosto campoImpuestos campoCiudad campoDisponibilidad botonCrear texto1 campoMes1 campoDia1 campoAño1 texto2 campoMes2 campoDia2 campoAño2 |

ventana := (self class) crear: datosEmpresa x: 340 y: 530. 

txtBienvenida2 := TextMorph new contents: 'Crear Viaje Especial'.
ventana añadirUnMorphCentrado: txtBienvenida2 conMargen: 0.

campoNombre := RubTextFieldMorph new extent: 300@20; ghostText:'Ingrese el Nombre'.
ventana añadirUnMorphCentrado: campoNombre conMargen: 30.

campoCosto := RubTextFieldMorph new extent: 300@20; ghostText:'Ingrese el Costo'.
ventana añadirUnMorphCentrado: campoCosto  conMargen: 20.

campoImpuestos := RubTextFieldMorph new extent: 300@20; ghostText:'Ingrese el Valor de Impuestos'.
ventana añadirUnMorphCentrado: campoImpuestos  conMargen: 20.

campoCiudad := RubTextFieldMorph new extent: 300@20; ghostText:'Ingrese la Ciudad'.
ventana añadirUnMorphCentrado: campoCiudad  conMargen: 20.

texto1 := TextMorph new contents: 'Ingrese la Fecha de Salida'.
ventana añadirUnMorphCentrado: texto1 conMargen: 20.

campoMes1 := RubTextFieldMorph new extent: 50@20; ghostText:'MM'.
ventana añadirUnMorphCentrado: campoMes1 conMargen: 10. 

campoDia1 := RubTextFieldMorph new extent: 50@20; ghostText:'DD'.
campoDia1 position: campoMes1 position - (campoMes1 width + 10@0).
ventana addMorphBack: campoDia1.

campoAño1 := RubTextFieldMorph new extent: 50@20; ghostText:'YYYY'.
ventana añadirUnMorph: campoAño1 alLado: campoMes1.

texto2 := TextMorph new contents: 'Ingrese la Fecha de Regreso'.
ventana añadirUnMorphCentrado: texto2 conMargen: 20.

campoMes2 := RubTextFieldMorph new extent: 50@20; ghostText:'MM'.
ventana añadirUnMorphCentrado: campoMes2 conMargen: 10. 

campoDia2 := RubTextFieldMorph new extent: 50@20; ghostText:'DD'.
campoDia2 position: campoMes2 position - (campoMes2 width + 10@0).
ventana addMorphBack: campoDia2.

campoAño2 := RubTextFieldMorph new extent: 50@20; ghostText:'YYYY'.
ventana añadirUnMorph: campoAño2 alLado: campoMes2.

campoDisponibilidad  := RubTextFieldMorph new extent: 300@20; ghostText:'Ingrese la Capacidad'.
ventana añadirUnMorphCentrado: campoDisponibilidad  conMargen: 20.

botonCrear := BotonGenerico crear: 'Crear Viaje'  x:100 y:30.
ventana añadirUnMorphCentrado: botonCrear conMargen: 20.
botonCrear mouseAction:[ventana delete. self crearEspecial: datosEmpresa conNombre: campoNombre conCosto: campoCosto conImpuestos: campoImpuestos conCiudad: campoCiudad dia1: campoDia1 mes1: campoMes1 año1: campoAño1 dia2: campoDia2 mes2: campoMes2 año2: campoAño2 conDisponibilidad: campoDisponibilidad].

botonVolver := BotonGenerico crear: 'Volver Atras'  x:100 y:30.
ventana añadirUnMorphCentrado: botonVolver conMargen: 20.
botonVolver mouseAction:[ventana delete. self altaDeViajes].

ventana openCenteredInWorld.
]

{ #category : #'as yet unclassified' }
VistaMenuAdministrador >> ingresarOrganizado [
|ventana txtBienvenida2 campoNombre campoCosto campoImpuestos campoDias txtFechas botonAddFecha campoMes1 campoDia1 campoAño1 colFechas colEtapas campoCupos txtEtapas campoDia2 campoMes2 campoAño2 campoCantDias campoHotel campoPension listaActividades campoCiudad botonAddEtapa botonAceptar txtExcursiones campoNombreExc campoCostoExc campoCantPersonasExc botonAddExcursion colExcursiones|
colFechas := OrderedCollection new.
colEtapas := OrderedCollection new.
colExcursiones := OrderedCollection new.

ventana := (self class) crear: datosEmpresa x: 410 y: 650. 

txtBienvenida2 := TextMorph new contents: 'Crear Viaje Organizado'.
ventana añadirUnMorphCentrado: txtBienvenida2 conMargen: 0.

campoNombre := RubTextFieldMorph new extent: 300@20; ghostText:'Ingrese el Nombre'.
ventana añadirUnMorphCentrado: campoNombre conMargen: 20.

campoCosto := RubTextFieldMorph new extent: 300@20; ghostText:'Ingrese el Costo'.
ventana añadirUnMorphCentrado: campoCosto  conMargen: 20.

campoImpuestos := RubTextFieldMorph new extent: 300@20; ghostText:'Ingrese el Valor de Impuestos'.
ventana añadirUnMorphCentrado: campoImpuestos  conMargen: 20.

campoDias := RubTextFieldMorph new extent: 300@20; ghostText:'Ingrese la Cantidad de Dias'.
ventana añadirUnMorphCentrado: campoDias  conMargen: 20.

txtFechas := TextMorph new contents: 'Ingrese posible Fecha'.
ventana añadirUnMorph: txtFechas conMargen: 20.

campoDia1 := RubTextFieldMorph new extent: 50@20; ghostText:'DD'.
ventana añadirUnMorph: campoDia1 conMargen: 10.

campoMes1 := RubTextFieldMorph new extent: 50@20; ghostText:'MM'.
ventana añadirUnMorph: campoMes1 alLado: campoDia1. 

campoAño1 := RubTextFieldMorph new extent: 50@20; ghostText:'YYYY'.
ventana añadirUnMorph: campoAño1 alLado: campoMes1.

campoCupos := RubTextFieldMorph new extent: 170@20; ghostText:'Cantidad de Cupos'.
ventana añadirUnMorph: campoCupos conMargen: 10.

botonAddFecha := BotonGenerico crear: 'Agregar Fecha' x:100  y:20.
ventana añadirUnMorph:botonAddFecha  conMargen:10.
botonAddFecha color: Color lightBlue.
botonAddFecha mouseAction:[ colFechas add: (self crearFechaNueva: campoDia1 conMeses:campoMes1 conAnio:campoAño1 conCupos:campoCupos). self update: colFechas size palabra: 'fecha']. 

txtAviso := TextMorph new contents: ''.
txtAviso addDependent: self.
ventana añadirUnMorph: txtAviso conMargen:0.





txtExcursiones := TextMorph new contents: 'Ingrese posible Excursion'.
ventana añadirUnMorph: txtExcursiones conMargen: 10.

campoNombreExc := RubTextFieldMorph new extent: 170@20; ghostText:'Nombre de la Excursion'.
ventana añadirUnMorph: campoNombreExc conMargen: 10.

campoCostoExc := RubTextFieldMorph new extent: 170@20; ghostText:'Costo de la Excursion'.
ventana añadirUnMorph: campoCostoExc conMargen: 10.

campoCantPersonasExc := RubTextFieldMorph new extent: 170@20; ghostText:'Cantidad de Personas'.
ventana añadirUnMorph: campoCantPersonasExc conMargen: 10.

botonAddExcursion := BotonGenerico crear: 'Agregar Excursion' x:120  y:20.
ventana añadirUnMorph: botonAddExcursion conMargen:10.
botonAddExcursion color: Color lightBlue.
botonAddExcursion mouseAction:[ colExcursiones add: (self crearExcursionNueva: campoNombreExc conCosto: campoCostoExc conCantPersonas: campoCantPersonasExc). self update: colExcursiones size palabra: 'excursion'].

txtAviso3 := TextMorph new contents: ''.
txtAviso3 addDependent: self.
ventana añadirUnMorph: txtAviso3 conMargen:0.




txtEtapas  := TextMorph new contents: 'Ingrese posible Etapa'.
ventana addMorphFront: txtEtapas.
txtEtapas position: (txtFechas position +(210@0)).

campoDia2 := RubTextFieldMorph new extent: 50@20; ghostText:'DD'.
ventana addMorphFront: campoDia2.
campoDia2 position: txtEtapas position + (0@30).

campoMes2 := RubTextFieldMorph new extent: 50@20; ghostText:'MM'.
ventana añadirUnMorph: campoMes2 alLado: campoDia2.

campoAño2 := RubTextFieldMorph new extent: 50@20; ghostText:'YYYY'.
ventana añadirUnMorph: campoAño2 alLado: campoMes2.

campoCantDias := RubTextFieldMorph new extent: 170@20; ghostText:'Ingrese Cantidad Dias'.
ventana addMorphFront: campoCantDias. campoCantDias position: txtEtapas position + (0@60).

campoHotel := RubTextFieldMorph new extent: 170@20; ghostText:'Ingrese Hotel'.
ventana addMorphFront: campoHotel. campoHotel position: txtEtapas position + (0@90).

campoPension := RubTextFieldMorph new extent: 170@20; ghostText:'Ingrese Tipo de Pension'.
ventana addMorphFront: campoPension. campoPension position: txtEtapas position + (0@120).

listaActividades := RubTextFieldMorph new extent: 170@20; ghostText:'Ingrese las Actividades'.
ventana addMorphFront: listaActividades. listaActividades position: txtEtapas position + (0@150).

campoCiudad := RubTextFieldMorph new extent: 170@20; ghostText:'Ingrese la Ciudad'.
ventana addMorphFront: campoCiudad. campoCiudad position: txtEtapas position + (0@180).

botonAddEtapa := BotonGenerico crear: 'Agregar Etapa' x:100  y:20.
botonAddEtapa color: Color lightBlue.
ventana addMorphFront: botonAddEtapa.botonAddEtapa position: campoCiudad position + (0@30).
botonAddEtapa mouseAction:[ colEtapas add: (self crearNuevaEtapa: campoDia2  conMes: campoMes2 conAnio: campoAño2 conCantDias: campoCantDias conHotel:campoHotel  conPension: campoPension conActiv: listaActividades conCiudad: campoCiudad). 
	self update: colEtapas size palabra: 'etapa']. 

txtAviso2 := TextMorph new contents: ''.
txtAviso2 addDependent: self.
ventana addMorphFront: txtAviso2 .txtAviso2 position: botonAddEtapa position +(0@20).

botonAceptar := BotonGenerico crear: 'Crear Viaje'  x:100 y:30.
ventana añadirUnMorphCentrado: botonAceptar conMargen: 10.
botonAceptar mouseAction:[ventana delete. self crearViajeOrganizado: campoNombre  conCosto: campoCosto conValorImpuestos:campoImpuestos  conDias: campoDias conEtapas: colEtapas conFechas:colFechas conExcursiones: colExcursiones].

botonVolver := BotonGenerico crear: 'Volver Atras'  x:100 y:30.
ventana añadirUnMorphCentrado: botonVolver conMargen: 10.
botonVolver color: Color paleGreen.
botonVolver mouseAction:[ventana delete. self altaDeViajes].

ventana openCenteredInWorld.
]

{ #category : #initialization }
VistaMenuAdministrador >> iniciar: empresaIn [
self iniciar: empresaIn  x:350  y:325 .

txtBienvenida := StringMorph new contents: 'Bienvenido, Administrador'; font: (LogicalFont familyName: 'Source Sans Pro' pointSize: 13).
self añadirUnMorphCentrado: txtBienvenida conMargen:0.

txtOpcion := TextMorph new contents: '¿Que desea realizar?'.
self añadirUnMorphCentrado: txtOpcion conMargen:5.

botonListaClientes  := BotonGenerico crear: 'Listar Clientes que tienen Contratos proximos a vencer' x: 325 y: 30.
self añadirUnMorphCentrado: botonListaClientes  conMargen:30 .
botonListaClientes mouseAction: [ self delete. self listarClientesAVencer].

botonEfect  := BotonGenerico crear: 'Efectivizar el Pago de los Contratos' x: 325 y: 30.
self añadirUnMorphCentrado: botonEfect  conMargen:20.
botonEfect mouseAction: [ datosEmpresa efectivizacionContrato. CartelError new iniciarError: 'Se efectivizaron los contratos
con todas las cuotas pagadas' x:200  y:80  ].

botonABM  := BotonGenerico crear: 'ABM de Viajes' x: 325 y: 30.
self añadirUnMorphCentrado: botonABM  conMargen:20 .
botonABM mouseAction: [ self delete. self ABMdeViajes ].

botonVolver  := BotonGenerico crear: 'Volver Atras' x:100 y:30.
self añadirUnMorphCentrado: botonVolver  conMargen: 30.
botonVolver color: Color paleGreen.
botonVolver mouseAction: [ self delete. VistaInicioSesion crearVistaInicio: empresaIn ].

self openCenteredInWorld.
]

{ #category : #'as yet unclassified' }
VistaMenuAdministrador >> listarClientesAVencer [
|ventana colClientes tabla colNombres botonAtras|
ventana := (Interfaz) crear: datosEmpresa x: 330 y: 320.

colClientes := datosEmpresa clientesContratosAVencer.
colNombres := OrderedCollection new.
colClientes do: [ :cliente | colNombres add: 'Cliente: ', (cliente getNombre), ' - DNI: ',(cliente getDni) asString ].

tabla := self mostrarTabla: colNombres tituloCabecera: 'Lista de Clientes con Contratos a Vencer:' x: 300  y: 200.
ventana añadirUnMorphCentrado: tabla conMargen:10.

botonAtras := BotonGenerico crear: 'Volver' x:100 y:30.
ventana añadirUnMorphCentrado: botonAtras conMargen: 30.
botonAtras color: Color paleGreen.
botonAtras mouseAction: [ ventana delete. self class crearVistaMenuAdministrador: datosEmpresa ].  

ventana openCenteredInWorld.
]

{ #category : #'as yet unclassified' }
VistaMenuAdministrador >> modificacionDeViajes [

|ventana txtBienvenida2 info infoViajes campoNombre botonA botonVolver2 colViajes |

ventana := (Interfaz) crear: datosEmpresa x: 1000 y: 575.

txtBienvenida2 := TextMorph new contents: 'Usted Selecciono la opcion: Modificacion de Viajes'.
ventana añadirUnMorphCentrado: txtBienvenida2 conMargen: 10.

info := TextMorph new contents: 'Los Viajes Disponibles para modificar son los siguientes: '.
ventana añadirUnMorphCentrado: info conMargen: 10.

"Creamos una coleccion con la info de los viajes"
colViajes := datosEmpresa listarInfoViajes.

infoViajes:= self mostrarTabla: colViajes tituloCabecera: 'Viajes Disponibles: '.
ventana añadirUnMorphCentrado: infoViajes conMargen: 30.

campoNombre := RubTextFieldMorph new extent: 300@20; ghostText:'Ingrese el Nombre del Viaje que desea modificar'.
ventana añadirUnMorphCentrado: campoNombre conMargen: 40.

botonA := BotonGenerico crear: 'ACEPTAR' x: 100 y: 30.
ventana  añadirUnMorphCentrado: botonA  conMargen:30.
botonA color: Color paleYellow.
botonA mouseAction: [ventana delete. self verificarViajeAModificar: campoNombre getText asString].

botonVolver2 := BotonGenerico crear: 'Volver Atras' x: 100 y: 30.
ventana añadirUnMorphCentrado: botonVolver2  conMargen:20.
botonVolver2 color: Color paleGreen.
botonVolver2 mouseAction: [ ventana delete. self ABMdeViajes].

ventana openCenteredInWorld.
]

{ #category : #'as yet unclassified' }
VistaMenuAdministrador >> modificarCiudadEspecial: unViaje [
| ventana info campoImpuestos botonAceptar nombreViaje botonVolver2 |
ventana := (Interfaz) crear: datosEmpresa x: 300 y: 250.
	
info := TextMorph new contents: 'Ingrese la nueva Ciudad del Viaje:'.
ventana añadirUnMorphCentrado: info conMargen: 0.

nombreViaje := TextMorph new contents: unViaje getNombre.
ventana añadirUnMorphCentrado: nombreViaje conMargen: 0.
	
campoImpuestos := RubTextFieldMorph new extent: 200@20; ghostText:'Ciudad del Viaje'.
ventana añadirUnMorphCentrado: campoImpuestos conMargen: 20.

botonAceptar := BotonGenerico crear: 'ACEPTAR' x: 100 y: 30.
ventana añadirUnMorphCentrado: botonAceptar  conMargen:30.
botonAceptar mouseAction: [unViaje modificarCiudad: (campoImpuestos getText) asString. ventana delete. self modificarEspecial: unViaje].

botonVolver2 := BotonGenerico crear: 'Volver Atras' x: 100 y: 30.
ventana añadirUnMorphCentrado: botonVolver2  conMargen:20.
botonVolver2 color: Color paleGreen.
botonVolver2 mouseAction: [ventana delete. self modificarEspecial: unViaje].
	
ventana openCenteredInWorld.
]

{ #category : #'as yet unclassified' }
VistaMenuAdministrador >> modificarCostoViaje: unViaje [
| ventana info campoCosto botonAceptar nombreViaje botonVolver2 |
ventana := (Interfaz) crear: datosEmpresa x: 300 y: 250.
	
info := TextMorph new contents: 'Ingrese el nuevo Costo por Persona del Viaje:'.
ventana añadirUnMorphCentrado: info conMargen: 0.

nombreViaje := TextMorph new contents: unViaje getNombre.
ventana añadirUnMorphCentrado: nombreViaje conMargen: 0.
	
campoCosto := RubTextFieldMorph new extent: 200@20; ghostText:'Costo por Persona'.
ventana añadirUnMorphCentrado: campoCosto conMargen: 20.

botonAceptar := BotonGenerico crear: 'ACEPTAR' x: 100 y: 30.
ventana añadirUnMorphCentrado: botonAceptar  conMargen:30.
botonAceptar mouseAction: [
	unViaje modificarCosto: (campoCosto getText) asNumber.
	ventana delete.
	(unViaje isKindOf: ViajeEspecial) ifTrue: [ 
		self modificarEspecial: unViaje.
	] ifFalse: [
		self modificarOrganizado: unViaje.
	]
].

botonVolver2 := BotonGenerico crear: 'Volver Atras' x: 100 y: 30.
ventana añadirUnMorphCentrado: botonVolver2  conMargen:20.
botonVolver2 color: Color paleGreen.
botonVolver2 mouseAction: [
	ventana delete.
	(unViaje isKindOf: ViajeEspecial) ifTrue: [
		self modificarEspecial: unViaje.
	] ifFalse: [
		self modificarOrganizado: unViaje.
	]
].
	
ventana openCenteredInWorld.
]

{ #category : #'as yet unclassified' }
VistaMenuAdministrador >> modificarDiasOrganizado: unViaje [
| ventana info campoDias botonAceptar nombreViaje botonVolver2 |
ventana := (Interfaz) crear: datosEmpresa x: 300 y: 250.
	
info := TextMorph new contents: 'Ingrese la nueva Duracion del Viaje:'.
ventana añadirUnMorphCentrado: info conMargen: 0.

nombreViaje := TextMorph new contents: unViaje getNombre.
ventana añadirUnMorphCentrado: nombreViaje conMargen: 0.
	
campoDias := RubTextFieldMorph new extent: 200@20; ghostText:'Dias de Duracion'.
ventana añadirUnMorphCentrado: campoDias conMargen: 20.

botonAceptar := BotonGenerico crear: 'ACEPTAR' x: 100 y: 30.
ventana añadirUnMorphCentrado: botonAceptar  conMargen:30.
botonAceptar mouseAction: [unViaje modificarDias: (campoDias getText) asNumber. ventana delete. self modificarOrganizado: unViaje].

botonVolver2 := BotonGenerico crear: 'Volver Atras' x: 100 y: 30.
ventana añadirUnMorphCentrado: botonVolver2  conMargen:20.
botonVolver2 color: Color paleGreen.
botonVolver2 mouseAction: [ventana delete. self modificarOrganizado: unViaje].
	
ventana openCenteredInWorld.
]

{ #category : #'as yet unclassified' }
VistaMenuAdministrador >> modificarDisponibilidadEspecial: unViaje [
| ventana info campoDisponibilidad botonAceptar nombreViaje botonVolver2 |
ventana := (Interfaz) crear: datosEmpresa x: 300 y: 250.
	
info := TextMorph new contents: 'Ingrese la nueva Disponibilidad del Viaje:'.
ventana añadirUnMorphCentrado: info conMargen: 0.

nombreViaje := TextMorph new contents: unViaje getNombre.
ventana añadirUnMorphCentrado: nombreViaje conMargen: 0.
	
campoDisponibilidad := RubTextFieldMorph new extent: 200@20; ghostText:'Disponibilidad'.
ventana añadirUnMorphCentrado: campoDisponibilidad conMargen: 20.

botonAceptar := BotonGenerico crear: 'ACEPTAR' x: 100 y: 30.
ventana añadirUnMorphCentrado: botonAceptar  conMargen:30.
botonAceptar mouseAction: [unViaje modificarDisponibilidad: (campoDisponibilidad getText) asNumber. ventana delete. self modificarEspecial: unViaje].

botonVolver2 := BotonGenerico crear: 'Volver Atras' x: 100 y: 30.
ventana añadirUnMorphCentrado: botonVolver2  conMargen:20.
botonVolver2 color: Color paleGreen.
botonVolver2 mouseAction: [ventana delete. self modificarEspecial: unViaje].
	
ventana openCenteredInWorld. 
]

{ #category : #'as yet unclassified' }
VistaMenuAdministrador >> modificarEspecial: viaje [
|ventana colViajes infoViaje botonVolver2 info botonCosto botonImpuestos botonCiudad botonSalida botonRegreso botonDisponibilidad|

ventana := (Interfaz) crear: datosEmpresa x: 1000 y: 600.

"Creamos una coleccion con la info de los viajes"
colViajes := OrderedCollection new.
colViajes add: viaje buscarInfo.

infoViaje:= self mostrarTabla: colViajes tituloCabecera: 'Viaje a Modificar' x: 900 y: 80.
ventana añadirUnMorphCentrado: infoViaje conMargen: 30.

info := TextMorph new contents: 'Que atributo desea modificar?'.
ventana añadirUnMorphCentrado: info conMargen: 30.

botonCosto := BotonGenerico crear: 'Costo por Persona' x: 150 y: 30.
ventana  añadirUnMorphCentrado: botonCosto  conMargen:30.
botonCosto mouseAction: [ventana delete. self modificarCostoViaje: viaje].

botonImpuestos := BotonGenerico crear: 'Valor de Impuestos' x: 150 y: 30.
ventana  añadirUnMorphCentrado: botonImpuestos  conMargen:20.
botonImpuestos mouseAction: [ventana delete. self modificarImpuestosViaje: viaje].

botonCiudad := BotonGenerico crear: 'Ciudad del Viaje' x: 150 y: 30.
ventana  añadirUnMorphCentrado: botonCiudad  conMargen:20.
botonCiudad mouseAction: [ventana delete. self modificarCiudadEspecial: viaje].

botonSalida := BotonGenerico crear: 'Fecha de Salida' x: 150 y: 30.
ventana  añadirUnMorphCentrado: botonSalida  conMargen:20.
botonSalida mouseAction: [ventana delete. self modificarFechaSalidaEspecial: viaje].

botonRegreso := BotonGenerico crear: 'Fecha de Regreso' x: 150 y: 30.
ventana  añadirUnMorphCentrado: botonRegreso  conMargen:20.
botonRegreso mouseAction: [ventana delete. self modificarFechaRegresoEspecial: viaje].

botonDisponibilidad := BotonGenerico crear: 'Disponibilidad' x: 150 y: 30.
ventana  añadirUnMorphCentrado: botonDisponibilidad  conMargen:20.
botonDisponibilidad mouseAction: [ventana delete.self modificarDisponibilidadEspecial: viaje].

botonVolver2 := BotonGenerico crear: 'Volver Atras' x: 100 y: 30.
ventana añadirUnMorphCentrado: botonVolver2  conMargen:20.
botonVolver2 color: Color paleGreen.
botonVolver2 mouseAction: [ventana delete. self modificacionDeViajes].

ventana openCenteredInWorld.
]

{ #category : #'as yet unclassified' }
VistaMenuAdministrador >> modificarEtapasOrganizado: unViaje [
|ventana campoDia campoMes campoAño colEtapas info nombreViaje botonModificar botonVolver2 campoCantDias campoHotel campoPension listaActividades campoCiudad botonAddEtapa |
colEtapas := OrderedCollection new.
ventana := (Interfaz) crear: datosEmpresa x: 300 y: 430.

info := TextMorph new contents: 'Ingrese una nueva Etapa posible del Viaje:'.
ventana añadirUnMorphCentrado: info conMargen: 0.

nombreViaje := TextMorph new contents: unViaje getNombre.
ventana añadirUnMorphCentrado: nombreViaje conMargen: 0.

campoMes := RubTextFieldMorph new extent: 50@20; ghostText:'MM'.
ventana añadirUnMorphCentrado: campoMes conMargen: 20. 

campoDia := RubTextFieldMorph new extent: 50@20; ghostText:'DD'.
campoDia position: campoMes position - (campoMes width + 10@0).
ventana addMorphBack: campoDia.

campoAño := RubTextFieldMorph new extent: 50@20; ghostText:'YYYY'.
ventana añadirUnMorph: campoAño alLado: campoMes.

campoCantDias := RubTextFieldMorph new extent: 170@20; ghostText:'Ingrese Cantidad Dias'.
ventana añadirUnMorphCentrado: campoCantDias conMargen: 10.

campoHotel := RubTextFieldMorph new extent: 170@20; ghostText:'Ingrese Hotel'.
ventana añadirUnMorphCentrado: campoHotel conMargen: 10.

campoPension := RubTextFieldMorph new extent: 170@20; ghostText:'Ingrese Tipo de Pension'.
ventana añadirUnMorphCentrado: campoPension conMargen: 10.

listaActividades := RubTextFieldMorph new extent: 170@20; ghostText:'Ingrese las Actividades'.
ventana añadirUnMorphCentrado: listaActividades conMargen: 10.

campoCiudad := RubTextFieldMorph new extent: 170@20; ghostText:'Ingrese la Ciudad'.
ventana añadirUnMorphCentrado: campoCiudad conMargen: 10.

botonAddEtapa := BotonGenerico crear: 'Agregar Etapa' x:100  y:20.
botonAddEtapa color: Color lightBlue.
ventana añadirUnMorphCentrado: botonAddEtapa conMargen: 10.
botonAddEtapa mouseAction:[
	colEtapas add: (self crearNuevaEtapa: campoDia  conMes: campoMes conAnio: campoAño conCantDias: campoCantDias conHotel:campoHotel  conPension: campoPension conActiv: listaActividades conCiudad: campoCiudad). 
	self update: colEtapas size palabra: 'etapa'.
]. 

txtAviso2 := TextMorph new contents: ''.
txtAviso2 addDependent: self.
ventana añadirUnMorph: txtAviso2 conMargen: 0.
txtAviso2 position: (txtAviso2 position) + (60@0).

botonModificar := BotonGenerico crear: 'Modificar Viaje'  x:120 y:30.
ventana añadirUnMorphCentrado: botonModificar conMargen: 20.
botonModificar mouseAction:[
	unViaje modificarEtapas: colEtapas.
	ventana delete.
	self modificarOrganizado: unViaje.
	"cartel?"
].

botonVolver2 := BotonGenerico crear: 'Volver Atras' x: 120 y: 30.
ventana añadirUnMorphCentrado: botonVolver2  conMargen:10.
botonVolver2 color: Color paleGreen.
botonVolver2 mouseAction: [ventana delete. self modificarOrganizado: unViaje].

ventana openCenteredInWorld.
]

{ #category : #'as yet unclassified' }
VistaMenuAdministrador >> modificarExcursionesOrganizado: unViaje [
|colExcursiones ventana info nombreViaje campoNombreExc campoCostoExc campoCantPersonasExc botonAddExcursion botonModificar botonVolver2 |
colExcursiones := OrderedCollection new.
ventana := (Interfaz) crear: datosEmpresa x: 300 y: 325.
	
info := TextMorph new contents: 'Ingrese una nueva Excursion posible del Viaje:'.
ventana añadirUnMorphCentrado: info conMargen: 0.

nombreViaje := TextMorph new contents: unViaje getNombre.
ventana añadirUnMorphCentrado: nombreViaje conMargen: 0.

campoNombreExc := RubTextFieldMorph new extent: 170@20; ghostText:'Nombre de la Excursion'.
ventana añadirUnMorphCentrado: campoNombreExc conMargen: 10.

campoCostoExc := RubTextFieldMorph new extent: 170@20; ghostText:'Costo de la Excursion'.
ventana añadirUnMorphCentrado: campoCostoExc conMargen: 10.

campoCantPersonasExc := RubTextFieldMorph new extent: 170@20; ghostText:'Cantidad de Personas'.
ventana añadirUnMorphCentrado: campoCantPersonasExc conMargen: 10.

botonAddExcursion := BotonGenerico crear: 'Agregar Excursion' x:120  y:20.
ventana añadirUnMorphCentrado: botonAddExcursion conMargen:10.
botonAddExcursion color: Color lightBlue.
botonAddExcursion mouseAction:[ colExcursiones add: (self crearExcursionNueva: campoNombreExc conCosto: campoCostoExc conCantPersonas: campoCantPersonasExc). self update: colExcursiones size palabra: 'excursion'].

txtAviso3 := TextMorph new contents: ''.
txtAviso3 addDependent: self.
ventana añadirUnMorph: txtAviso3 conMargen:0.
txtAviso3 position: (txtAviso3 position) + (50@0).

botonModificar := BotonGenerico crear: 'Modificar Viaje'  x:120 y:30.
ventana añadirUnMorphCentrado: botonModificar conMargen: 20.
botonModificar mouseAction:[
	unViaje modificarExcursiones: colExcursiones.
	ventana delete.
	self modificarOrganizado: unViaje.
	"cartel?"
].

botonVolver2 := BotonGenerico crear: 'Volver Atras' x: 120 y: 30.
ventana añadirUnMorphCentrado: botonVolver2  conMargen:10.
botonVolver2 color: Color paleGreen.
botonVolver2 mouseAction: [ventana delete. self modificarOrganizado: unViaje].

ventana openCenteredInWorld.
]

{ #category : #'as yet unclassified' }
VistaMenuAdministrador >> modificarFechaRegresoEspecial: unViaje [
| ventana info botonAceptar nombreViaje botonVolver2 campoMes campoDia campoAño nuevaFecha |
ventana := (Interfaz) crear: datosEmpresa x: 300 y: 250.
	
info := TextMorph new contents: 'Ingrese la nueva Fecha de Regreso del Viaje:'.
ventana añadirUnMorphCentrado: info conMargen: 0.

nombreViaje := TextMorph new contents: unViaje getNombre.
ventana añadirUnMorphCentrado: nombreViaje conMargen: 0.

campoMes := RubTextFieldMorph new extent: 50@20; ghostText:'MM'.
ventana añadirUnMorphCentrado: campoMes conMargen: 20. 

campoDia := RubTextFieldMorph new extent: 50@20; ghostText:'DD'.
campoDia position: campoMes position - (campoMes width + 10@0).
ventana addMorphBack: campoDia.

campoAño := RubTextFieldMorph new extent: 50@20; ghostText:'YYYY'.
ventana añadirUnMorph: campoAño alLado: campoMes.

botonAceptar := BotonGenerico crear: 'ACEPTAR' x: 100 y: 30.
ventana añadirUnMorphCentrado: botonAceptar  conMargen:30.
botonAceptar mouseAction: [
	nuevaFecha := Date newDay: (campoDia getText) asNumber month: (campoMes getText) asNumber year: (campoAño getText) asNumber.
	unViaje modificarFechaRegreso: nuevaFecha.
	ventana delete.
	self modificarEspecial: unViaje
].

botonVolver2 := BotonGenerico crear: 'Volver Atras' x: 100 y: 30.
ventana añadirUnMorphCentrado: botonVolver2  conMargen:20.
botonVolver2 color: Color paleGreen.
botonVolver2 mouseAction: [ventana delete. self modificarEspecial: unViaje].
	
ventana openCenteredInWorld. 
]

{ #category : #'as yet unclassified' }
VistaMenuAdministrador >> modificarFechaSalidaEspecial: unViaje [ 
| ventana info botonAceptar nombreViaje botonVolver2 campoMes campoDia campoAño nuevaFecha |
ventana := (Interfaz) crear: datosEmpresa x: 300 y: 250.
	
info := TextMorph new contents: 'Ingrese la nueva Fecha de Salida del Viaje:'.
ventana añadirUnMorphCentrado: info conMargen: 0.

nombreViaje := TextMorph new contents: unViaje getNombre.
ventana añadirUnMorphCentrado: nombreViaje conMargen: 0.

campoMes := RubTextFieldMorph new extent: 50@20; ghostText:'MM'.
ventana añadirUnMorphCentrado: campoMes conMargen: 20. 

campoDia := RubTextFieldMorph new extent: 50@20; ghostText:'DD'.
campoDia position: campoMes position - (campoMes width + 10@0).
ventana addMorphBack: campoDia.

campoAño := RubTextFieldMorph new extent: 50@20; ghostText:'YYYY'.
ventana añadirUnMorph: campoAño alLado: campoMes.

botonAceptar := BotonGenerico crear: 'ACEPTAR' x: 100 y: 30.
ventana añadirUnMorphCentrado: botonAceptar  conMargen:30.
botonAceptar mouseAction: [
	nuevaFecha := Date newDay: (campoDia getText) asNumber month: (campoMes getText) asNumber year: (campoAño getText) asNumber.
	unViaje modificarFechaSalida: nuevaFecha.
	ventana delete.
	self modificarEspecial: unViaje
].

botonVolver2 := BotonGenerico crear: 'Volver Atras' x: 100 y: 30.
ventana añadirUnMorphCentrado: botonVolver2  conMargen:20.
botonVolver2 color: Color paleGreen.
botonVolver2 mouseAction: [ventana delete. self modificarEspecial: unViaje].
	
ventana openCenteredInWorld.
]

{ #category : #'as yet unclassified' }
VistaMenuAdministrador >> modificarFechasOrganizado: unViaje [
|ventana campoDia campoMes campoAño campoCupos botonAddFecha colFechas info nombreViaje botonModificar botonVolver2 |
colFechas := OrderedCollection new.
ventana := (Interfaz) crear: datosEmpresa x: 300 y: 295.
	
info := TextMorph new contents: 'Ingrese una nueva Fecha posible del Viaje:'.
ventana añadirUnMorphCentrado: info conMargen: 0.

nombreViaje := TextMorph new contents: unViaje getNombre.
ventana añadirUnMorphCentrado: nombreViaje conMargen: 0.

campoMes := RubTextFieldMorph new extent: 50@20; ghostText:'MM'.
ventana añadirUnMorphCentrado: campoMes conMargen: 20. 

campoDia := RubTextFieldMorph new extent: 50@20; ghostText:'DD'.
campoDia position: campoMes position - (campoMes width + 10@0).
ventana addMorphBack: campoDia.

campoAño := RubTextFieldMorph new extent: 50@20; ghostText:'YYYY'.
ventana añadirUnMorph: campoAño alLado: campoMes.

campoCupos := RubTextFieldMorph new extent: 170@20; ghostText:'Cantidad de Cupos'.
ventana añadirUnMorphCentrado: campoCupos conMargen: 10.

botonAddFecha := BotonGenerico crear: 'Agregar Fecha' x:100  y:20.
ventana añadirUnMorphCentrado: botonAddFecha  conMargen:10.
botonAddFecha color: Color lightBlue.
botonAddFecha mouseAction:[ colFechas add: (self crearFechaNueva: campoDia conMeses:campoMes conAnio:campoAño conCupos:campoCupos). self update: colFechas size palabra: 'fecha'].

txtAviso := TextMorph new contents: ''.
txtAviso addDependent: self.
ventana añadirUnMorph: txtAviso conMargen:0. 
txtAviso position: (txtAviso position) + (60@0).

botonModificar := BotonGenerico crear: 'Modificar Viaje'  x:120 y:30.
ventana añadirUnMorphCentrado: botonModificar conMargen: 20.
botonModificar mouseAction:[
	unViaje modificarFechas: colFechas.
	ventana delete.
	self modificarOrganizado: unViaje.
	"cartel?"
].

botonVolver2 := BotonGenerico crear: 'Volver Atras' x: 120 y: 30.
ventana añadirUnMorphCentrado: botonVolver2  conMargen:10.
botonVolver2 color: Color paleGreen.
botonVolver2 mouseAction: [ventana delete. self modificarOrganizado: unViaje].

ventana openCenteredInWorld.
]

{ #category : #'as yet unclassified' }
VistaMenuAdministrador >> modificarImpuestosViaje: unViaje [
| ventana info campoImpuestos botonAceptar nombreViaje botonVolver2 |
ventana := (Interfaz) crear: datosEmpresa x: 300 y: 250.
	
info := TextMorph new contents: 'Ingrese el nuevo Valor de Impuestos del Viaje:'.
ventana añadirUnMorphCentrado: info conMargen: 0.

nombreViaje := TextMorph new contents: unViaje getNombre.
ventana añadirUnMorphCentrado: nombreViaje conMargen: 0.
	
campoImpuestos := RubTextFieldMorph new extent: 200@20; ghostText:'Valor de Impuestos'.
ventana añadirUnMorphCentrado: campoImpuestos conMargen: 20.

botonAceptar := BotonGenerico crear: 'ACEPTAR' x: 100 y: 30.
ventana añadirUnMorphCentrado: botonAceptar  conMargen:30.
botonAceptar mouseAction: [
	unViaje modificarImpuestos: (campoImpuestos getText) asNumber. 
	ventana delete.
	(unViaje isKindOf: ViajeEspecial) ifTrue: [ 
		self modificarEspecial: unViaje.
	] ifFalse: [
		self modificarOrganizado: unViaje.
	]
].

botonVolver2 := BotonGenerico crear: 'Volver Atras' x: 100 y: 30.
ventana añadirUnMorphCentrado: botonVolver2  conMargen:20.
botonVolver2 color: Color paleGreen.
botonVolver2 mouseAction: [
	ventana delete.
	(unViaje isKindOf: ViajeEspecial) ifTrue: [ 
		self modificarEspecial: unViaje.
	] ifFalse: [
		self modificarOrganizado: unViaje.
	]
].
	
ventana openCenteredInWorld.
]

{ #category : #'as yet unclassified' }
VistaMenuAdministrador >> modificarOrganizado: viaje [
|ventana colViajes infoViaje botonVolver2 info botonCosto botonImpuestos botonDias botonEtapas botonExcursiones botonFechas|

ventana := (Interfaz) crear: datosEmpresa x: 1000 y: 600.

"Creamos una coleccion con la info de los viajes"
colViajes := OrderedCollection new.
colViajes add: viaje buscarInfo.

infoViaje:= self mostrarTabla: colViajes tituloCabecera: 'Viaje a Modificar' x: 900 y: 80.
ventana añadirUnMorphCentrado: infoViaje conMargen: 30.

info := TextMorph new contents: 'Que atributo desea modificar?'.
ventana añadirUnMorphCentrado: info conMargen: 30.

botonCosto := BotonGenerico crear: 'Costo por Persona' x: 150 y: 30.
ventana  añadirUnMorphCentrado: botonCosto  conMargen:30.
botonCosto mouseAction: [ventana delete. self modificarCostoViaje: viaje].

botonImpuestos := BotonGenerico crear: 'Valor de Impuestos' x: 150 y: 30.
ventana  añadirUnMorphCentrado: botonImpuestos  conMargen:20.
botonImpuestos mouseAction: [ventana delete. self modificarImpuestosViaje: viaje].

botonDias := BotonGenerico crear: 'Dias de Duracion' x: 150 y: 30.
ventana  añadirUnMorphCentrado: botonDias  conMargen:20.
botonDias mouseAction: [ventana delete. self modificarDiasOrganizado: viaje].

botonEtapas := BotonGenerico crear: 'Etapas' x: 150 y: 30.
ventana  añadirUnMorphCentrado: botonEtapas  conMargen:20.
botonEtapas mouseAction: [ventana delete. self modificarEtapasOrganizado: viaje].

botonExcursiones := BotonGenerico crear: 'Excursiones' x: 150 y: 30.
ventana  añadirUnMorphCentrado: botonExcursiones  conMargen:20.
botonExcursiones mouseAction: [ventana delete. self modificarExcursionesOrganizado: viaje].

botonFechas := BotonGenerico crear: 'Fechas' x: 150 y: 30.
ventana  añadirUnMorphCentrado: botonFechas  conMargen:20.
botonFechas mouseAction: [ventana delete.self modificarFechasOrganizado: viaje].

botonVolver2 := BotonGenerico crear: 'Volver Atras' x: 100 y: 30.
ventana añadirUnMorphCentrado: botonVolver2  conMargen:20.
botonVolver2 color: Color paleGreen.
botonVolver2 mouseAction: [ventana delete. self modificacionDeViajes].

ventana openCenteredInWorld.
]

{ #category : #'as yet unclassified' }
VistaMenuAdministrador >> separarString: unString [
|partes|
partes := OrderedCollection new.
partes := unString findTokens: '/'.
^ partes.
]

{ #category : #'as yet unclassified' }
VistaMenuAdministrador >> update: texto boolean:tipo [
(tipo)ifTrue: [ txtAviso contents: 'El viaje tiene: ', texto asString ,' posibles fechas.' ] ifFalse: 
[ txtAviso2 contents: 'El viaje tiene: ', texto asString ,' posibles etapas.' ]
]

{ #category : #'as yet unclassified' }
VistaMenuAdministrador >> update: texto palabra: palabra [

(palabra = 'fecha') ifTrue: [txtAviso contents: 'El viaje tiene: ', texto asString ,' posibles fechas.'].
(palabra = 'etapa') ifTrue: [txtAviso2 contents: 'El viaje tiene: ', texto asString ,' posibles etapas.'].
(palabra = 'excursion') ifTrue: [txtAviso3 contents: 'El viaje tiene: ', texto asString ,' posibles excursiones.'].

"Y si mejor le mandamos un string en vez de un booleano? porque hay 3 tipos de texto para actualizar"
]

{ #category : #'as yet unclassified' }
VistaMenuAdministrador >> verificarViajeAEliminar: nombreViajeIn [
|viaje|
viaje := datosEmpresa buscarViajeDesdeEmpresa: nombreViajeIn.
viaje ifNotNil: [
	datosEmpresa bajasViajes: nombreViajeIn.
	(self class) crearVistaMenuAdministrador: datosEmpresa.
	CartelError new iniciarError: 'El Viaje ', nombreViajeIn, ' se dio de baja' x: 300 y:40.
]ifNil: [
	self bajaDeViajes.
	CartelError new iniciarError: 'Viaje no Existe' x: 200 y:40 
]
]

{ #category : #'as yet unclassified' }
VistaMenuAdministrador >> verificarViajeAModificar: nombreViajeIn [
|viaje|
viaje := datosEmpresa buscarViajeDesdeEmpresa: nombreViajeIn.
viaje ifNotNil: [
	(viaje isKindOf: ViajeEspecial) ifTrue: [ 
		self modificarEspecial: viaje.
	] ifFalse: [
		self modificarOrganizado: viaje.
	]
]ifNil: [
	self modificacionDeViajes.
	CartelError new iniciarError: 'Viaje no Existe' x: 200 y:40 
]
]
