Class {
	#name : #Cliente,
	#superclass : #Object,
	#instVars : [
		'apellido',
		'dni',
		'ciudad',
		'datosContacto',
		'colContratos',
		'contraseña'
	],
	#category : #'SistemaAgencia-Modelo'
}

{ #category : #constructor }
Cliente class >> crear: unDni conApellido: unApellido conCiudad: unaCiudad conDatos: unosDatos conContra: unaContra [ 
|nuevoCliente|
nuevoCliente := self new.
nuevoCliente inicializar: unDni conApellido: unApellido conCiudad: unaCiudad conDatos: unosDatos conContra: unaContra. 
^ nuevoCliente	
]

{ #category : #'as yet unclassified' }
Cliente >> asignarColContratos: colContIn [
colContratos := colContIn.
]

{ #category : #queries }
Cliente >> buscarCliente: dniCliente [
|cliente|
(dniCliente == dni )ifTrue: (cliente := self).
^cliente .
]

{ #category : #queries }
Cliente >> buscarClienteconDni: unNumero [
^dni = unNumero .
]

{ #category : #queries }
Cliente >> buscarContratoEliminar: unNombre [
colContratos := colContratos reject:[:cadaContrato| (cadaContrato eliminar: unNombre) isNotNil]. 
]

{ #category : #queries }
Cliente >> buscarContratoEnCliente: nroContrato [
|unContrato|
unContrato := nil.
unContrato:= colContratos detect:[:cadaContrato| cadaContrato buscarContrato: nroContrato] ifNone:[nil].
^ unContrato. 

]

{ #category : #queries }
Cliente >> buscarFechas: fecha1 conFecha2: fecha2 [
|colAux rta|
rta := nil.
colAux := OrderedCollection new.
colContratos do:[:cadaContrato|rta := (cadaContrato buscarContrato: fecha1 conFecha2: fecha2). (rta isNotNil) ifTrue: [colAux add: rta].].
^ colAux.
]

{ #category : #'as yet unclassified' }
Cliente >> cambiarModalidad: empresaIn [
|clienteAux|
clienteAux := ViajeroFrecuente crear:dni  conApellido:apellido  conCiudad:ciudad  conDatos: datosContacto conMillas: 0 conContra: contraseña.

clienteAux asignarColContratos: colContratos.

(self puedeSerFrecuente) ifTrue: [ 
    empresaIn eliminaCliente: dni.
    empresaIn agregarCliente: clienteAux.
     ]ifFalse: [ ^self ].
self changed.

^clienteAux.
]

{ #category : #'as yet unclassified' }
Cliente >> efectivizarEnCliente [
|colContaEfec |
colContaEfec := colContratos select: [ :contrato | contrato cuotasPagadas ].
colContaEfec do: [ :contratoEfe | contratoEfe efectivizar ]

]

{ #category : #'as yet unclassified' }
Cliente >> eliminaContrato: numeroContratoIn [
colContratos remove: (self buscarContratoEnCliente: numeroContratoIn) ifAbsent: [^false].
^true
]

{ #category : #queries }
Cliente >> encontrarClientes [
|unCliente buscado|
unCliente := nil.
buscado := nil.
(colContratos isNotEmpty) ifTrue:[
	buscado :=  colContratos detect:[:cadaContrato| cadaContrato encontrarContrato] ifNone: [buscado:=nil].
	(buscado isNotNil)ifTrue:[unCliente := self].
].
^ unCliente.
]

{ #category : #queries }
Cliente >> getContraseña [
^contraseña
]

{ #category : #'as yet unclassified' }
Cliente >> getContratos [
^ colContratos.
]

{ #category : #'as yet unclassified' }
Cliente >> getDni [
^dni.
]

{ #category : #queries }
Cliente >> getNombre [ 
^apellido
]

{ #category : #queries }
Cliente >> inicializar: unDni conApellido: unApellido conCiudad: unaCiudad conDatos: unosDatos conContra: unaCont [
dni := unDni.
apellido := unApellido.
ciudad := unaCiudad.
datosContacto := unosDatos.
contraseña := unaCont.
colContratos := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
Cliente >> listarContratos [
  | aux info |
  aux := ''.
  info := ''.
  colContratos do: [:cadaContrato |
    aux := (cadaContrato buscarInfoContrato).
    (aux isNotNil) ifTrue: [info:= info, aux, '/'].
  ].
  ^ info.
]

{ #category : #'as yet unclassified' }
Cliente >> listarInfoViajesOrganizados [
|aux colContratosOrganizados|
aux := nil.
colContratosOrganizados := OrderedCollection new.
colContratos do: [:cadaContrato |
	aux := (cadaContrato buscarInfoViaje).
	(aux isNotNil & aux isKindOf: ViajeOrganizado) ifTrue: [colContratosOrganizados add: cadaContrato buscarInfoContrato].
].
^ colContratosOrganizados.
]

{ #category : #queries }
Cliente >> modificacionEnCliente:numContrato deseaCancelar: cancelar conNuevaFecha:nuevaFecha [
|contrato montoT|
contrato:= colContratos detect:[:encontrado| encontrado buscarContrato: numContrato].
(contrato  = ContratoFlexible) ifTrue: [ montoT := contrato reprogramaViajeoCancelar:nuevaFecha  deseaCancelar:  cancelar ].
^montoT 
]

{ #category : #queries }
Cliente >> nuevoContrato: unNumero conViajeContratado: unViaje conFechaViaje: unaFechaViaje conCantPersonas: unaCantPersonas conCantCuotas: unaCantCuotas conFechaProxVenc: unaFechaVenc [ 
|contrato|
contrato := Contrato crear: unNumero conViajeContratado: unViaje conFechaViaje: unaFechaViaje conCantPersonas: unaCantPersonas conCantCuotas: unaCantCuotas conFechaProxVenc: unaFechaVenc.
colContratos add: contrato.
]

{ #category : #queries }
Cliente >> nuevoContratoFlexible: unNumero conViajeContratado: unViaje conFechaViaje: unaFechaViaje conCantPersonas: unaCantPersonas conCantCuotas: unaCantCuotas conFechaProxVenc: unaFechaVenc conPlus: unPlus [
|contratoF |
contratoF  := ContratoFlexible crear: unNumero conViajeContratado: unViaje conFechaViaje: unaFechaViaje conCantPersonas: unaCantPersonas conCantCuotas: unaCantCuotas conFechaProxVenc: unaFechaVenc conPlus: unPlus. 
colContratos add: contratoF
]

{ #category : #'as yet unclassified' }
Cliente >> puedeSerFrecuente [
|aux|
aux:= (colContratos detect: [ :contrato| (contrato esViajeOrganizado) & (contrato getFechaCreacion > (Date today - 365 days))] ifNone: [ nil]).
(aux) ifNil: [^false] ifNotNil:[^true].
]
