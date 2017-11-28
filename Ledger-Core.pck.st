'From Cuis 5.0 of 7 November 2016 [latest update: #3222] on 28 November 2017 at 4:58:31 pm'!
'Description Please enter a description for this package'!
!provides: 'Ledger-Core' 1 7!
!requires: 'PetitParser' 1 1 nil!
!classDefinition: #LedgerParser category: #'Ledger-Core'!
PPCompositeParser subclass: #LedgerParser
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ledger-Core'!
!classDefinition: 'LedgerParser class' category: #'Ledger-Core'!
LedgerParser class
	instanceVariableNames: ''!


!LedgerParser commentStamp: '<historical>' prior: 0!
I represent a ledger file. See [ledger-cli](https://ledger-cli.org) for a detailed description.!

!LedgerParser methodsFor: 'grammar' stamp: 'ck 11/28/2017 11:15:57'!
clearance
	^ $* asParser optional ==> [:t | true]! !

!LedgerParser methodsFor: 'grammar' stamp: 'ck 11/28/2017 16:47:39'!
comment
	^ $; asParser trim , (#word asParser, #space asParser optional) plus flatten  ==> [:c | c second ].! !

!LedgerParser methodsFor: 'grammar' stamp: 'ck 11/27/2017 23:10:07'!
date
"Ledger transaction date parsing YYYY/MM/DD"

| year month day dateSeparator |
year := (#digit asParser, #digit asParser, #digit asParser, #digit asParser ) trim flatten==>  [:t | t value asNumber ].
month := (#digit asParser, #digit asParser) trim flatten ==>  [:t | t value asNumber ].
day := month copy.
dateSeparator := $/ asParser trim.

	^ (year , dateSeparator , month , dateSeparator , day  ==> [:date | Date year: date first month: date third day: date fifth])
! !

!LedgerParser methodsFor: 'grammar' stamp: 'ck 11/28/2017 12:00:17'!
eol
	^ "(Character lf) asParser / "(Character cr) asParser! !

!LedgerParser methodsFor: 'as yet unclassified' stamp: 'ck 11/27/2017 23:10:37'!
initialize
	super initialize! !

!LedgerParser methodsFor: 'grammar' stamp: 'ck 11/28/2017 14:12:51'!
money
	^ #letter asParser plus trim flatten optional, 
	  ($- asParser trim optional ==> [:sign | sign ifNil: [$0] ifNotNil: [sign]]) ,
	  #digit asParser plus flatten,
	  (($. asParser , #digit asParser, #digit asParser) flatten optional ==> [:a | a ifNil: [''] ifNotNil: [a]])
	  ==> [:a |  ((a second asString) append: (a third append: a fourth)) asNumber ].! !

!LedgerParser methodsFor: 'grammar' stamp: 'ck 11/27/2017 23:12:38'!
start
	self transactionHeader! !

!LedgerParser methodsFor: 'grammar' stamp: 'ck 11/28/2017 11:43:17'!
title
	^ (#word asParser) trim plus flatten trim! !

!LedgerParser methodsFor: 'as yet unclassified' stamp: 'ck 11/28/2017 16:58:18'!
transaction
	^(self transactionHeader) , (self transactionLine plus)! !

!LedgerParser methodsFor: 'grammar' stamp: 'ck 11/28/2017 15:42:09'!
transactionHeader
" A header consists of date [clearance] title ; comment"
	^ self date , self clearance , self title , self comment
! !

!LedgerParser methodsFor: 'grammar' stamp: 'ck 11/28/2017 16:25:21'!
transactionLine
	^ #blank asParser plus, #blank asParser negate plus flatten, #blank asParser plus, self money optional, #blank asParser star, #newline asParser ==> [:n | {n second. n fourth} ]! !
