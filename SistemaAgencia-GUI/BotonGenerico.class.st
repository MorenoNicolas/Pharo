Class {
	#name : #BotonGenerico,
	#superclass : #BotonBase,
	#category : #'SistemaAgencia-GUI'
}

{ #category : #'as yet unclassified' }
BotonGenerico >> iniciar: string [
| nuevoColor |
self label: string.
self extent:300@30.
"nuevoColor := Color fromHexString: '57bc90'."
"self color: nuevoColor."
self color: Color paleYellow .
self borderWidth: 1.
self borderColor: Color black.
self roundedCorners: 300.
]

{ #category : #'as yet unclassified' }
BotonGenerico >> iniciar: string x:x y:y [
| nuevoColor |
self label: string.
self extent:x@y.
"nuevoColor := Color fromHexString: 'f4e9cd'."
"self color: nuevoColor."
self color: Color paleYellow .
self borderWidth: 1.
self borderColor: Color black.
self roundedCorners: 300.



]
