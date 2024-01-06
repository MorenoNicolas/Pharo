Class {
	#name : #Cliente,
	#superclass : #Object,
	#instVars : [
		'apellido',
		'dni',
		'ciudad',
		'datosContacto',
		'colContratos'
	],
	#category : #SistemaAgencia
}

{ #category : #constructor }
Cliente class >> crear: unDni conApellido: unApellido conCiudad: unaCiudad conDatos: unosDatos [
|nuevoCliente|
nuevoCliente := self new.
nuevoCliente inicializar: unDni conApellido: unApellido conCiudad: unaCiudad conDatos: unosDatos.
^ nuevoCliente	
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
unContrato:= colContratos detect:[:cadaContrato| cadaContrato buscarContrato: nroContrato].
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

{ #category : #queries }
Cliente >> efectivizacionEnCliente: numContrato [
|unContrato retorno|
retorno :=false.
unContrato := colContratos detect: [ :cont|cont buscarContrato: numContrato]. 
unContrato ifNotNil: [retorno := unContrato efectivizar].
^retorno  

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
Cliente >> inicializar: unDni conApellido: unApellido conCiudad: unaCiudad conDatos: unosDatos [
dni := unDni.
apellido := unApellido.
ciudad := unaCiudad.
datosContacto := unosDatos.
colContratos := OrderedCollection new.
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
