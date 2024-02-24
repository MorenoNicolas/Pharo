Class {
	#name : #ScrollMorph,
	#superclass : #ScrollPane,
	#instVars : [
		'ultimoY',
		'colTextMorph',
		'fondoCabecera',
		'x',
		'y',
		'cabecera'
	],
	#category : #'SistemaAgencia-GUI'
}

{ #category : #'as yet unclassified' }
ScrollMorph class >> crear:xIn y:yIn [ 
	"comment stating purpose of class-side method"
	"scope: class-variables  &  class-instance-variables"	
			
	
	^ self new iniciar:xIn y:yIn.
]

{ #category : #'as yet unclassified' }
ScrollMorph class >> crear:xIn y:yIn cabecera:cabecera [
	"comment stating purpose of class-side method"
	"scope: class-variables  &  class-instance-variables"	
			
	
	^ self new iniciar:xIn y:yIn cabecera:cabecera.
]

{ #category : #'as yet unclassified' }
ScrollMorph >> agregarTexto:texto [
|label|
label := texto asStringMorph.
label position: 5@ultimoY.
ultimoY := ultimoY + 30.
colTextMorph add: label.
self scroller addMorph: label behind: fondoCabecera.
]

{ #category : #'as yet unclassified' }
ScrollMorph >> iniciar:xIn y:yIn [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"	
			
	x := xIn.
	y := yIn.
	ultimoY := 40.
	self extent: x@y.
	self color: Color paleMagenta.
	colTextMorph := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
ScrollMorph >> iniciar:xIn y:yIn cabecera:cabeceraIn [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"	
		
	x := xIn.
	y := yIn.
	ultimoY := 40.
	self extent: x@y.
	self color: Color paleTan.
	self borderWidth: 2 ; useRoundedCorners.
	self borderColor: Color darkGray.
	colTextMorph := OrderedCollection new.
	cabecera := cabeceraIn asStringMorph.
	fondoCabecera := Morph new.
	fondoCabecera borderWidth: 2 ; useRoundedCorners.
	fondoCabecera extent: x@30.
	fondoCabecera color: Color paleBuff  .
	cabecera position:5@10.
	self addMorph: fondoCabecera .
	self addMorphFront: cabecera. 
	
]

{ #category : #'as yet unclassified' }
ScrollMorph >> resetear [ 
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"	
			
	colTextMorph do: [:textMorph | textMorph delete. ].
	colTextMorph := OrderedCollection new.
	ultimoY := 40.
]
