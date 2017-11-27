'From Cuis 5.0 of 7 November 2016 [latest update: #3207] on 27 November 2017 at 11:17:49 pm'!
'Description Please enter a description for this package'!
!provides: 'Ledger-Core' 1 4!
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

!LedgerParser methodsFor: 'grammar' stamp: 'ck 11/27/2017 23:03:10'!
clearance
	^($* asParser optional ==> [:t | true])! !

!LedgerParser methodsFor: 'grammar' stamp: 'ck 11/27/2017 23:06:25'!
comment
	^ $; asParser trim , #word asParser star flatten , self eol ==> [ :c | c second ]! !

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

!LedgerParser methodsFor: 'grammar' stamp: 'ck 11/27/2017 23:14:06'!
eol
	^ (Character lf) asParser / (Character cr) asParser! !

!LedgerParser methodsFor: 'as yet unclassified' stamp: 'ck 11/27/2017 23:10:37'!
initialize
	super initialize! !

!LedgerParser methodsFor: 'grammar' stamp: 'ck 11/27/2017 23:12:38'!
start
	self transactionHeader! !

!LedgerParser methodsFor: 'grammar' stamp: 'ck 11/27/2017 23:03:51'!
title
	^ #word asParser plus trim flatten! !

!LedgerParser methodsFor: 'grammar' stamp: 'ck 11/27/2017 23:15:59'!
transactionHeader
" A header consists of date [clearance] title ; comment"
	^(self date , self clearance , self title , self comment , self eol / self end)
! !
