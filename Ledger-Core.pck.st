'From Cuis 5.0 of 7 November 2016 [latest update: #3207] on 27 November 2017 at 4:37:08 pm'!
'Description Please enter a description for this package'!
!provides: 'Ledger-Core' 1 2!
!requires: 'PetitParser' 1 1 nil!
!classDefinition: #LedgerParser category: #'Ledger-Core'!
Object subclass: #LedgerParser
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ledger-Core'!
!classDefinition: 'LedgerParser class' category: #'Ledger-Core'!
LedgerParser class
	instanceVariableNames: ''!


!LedgerParser commentStamp: '<historical>' prior: 0!
I represent a ledger file. See [ledger-cli](https://ledger-cli.org) for a detailed description.!
