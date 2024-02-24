Class {
	#name : #BotonCerrar,
	#superclass : #BotonBase,
	#category : #'SistemaAgencia-GUI'
}

{ #category : #'as yet unclassified' }
BotonCerrar >> iniciar [
self label: 'X'.
self extent:30@30.
self color: Color red.
self borderWidth: 1.
self borderColor: Color gray.
self roundedCorners: 300.
]

{ #category : #'as yet unclassified' }
BotonCerrar >> iniciar: string [
self label: 'X'.
self extent:30@30.
self color: Color red.
self borderWidth: 1.
self borderColor: Color gray.
self roundedCorners: 300.
]
