| year date month day  dateSeparator p|
year := (#digit asParser, #digit asParser, #digit asParser, #digit asParser ) trim flatten==>  [:t | t value asNumber ].
month := (#digit asParser, #digit asParser) trim flatten ==>  [:t | t value asNumber ].
day := month copy.
dateSeparator := $/ asParser trim.

date  := year , dateSeparator , month , dateSeparator , day  ==> [:date | Date year: date first month: date third day: date fifth].

date parse: '2018/10/11'.

p _ LedgerParser new.
p parse: '2012/22/2 * foo ; hey!'
