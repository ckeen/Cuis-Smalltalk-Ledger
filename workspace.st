| year date month day  dateSeparator |
year := (#digit asParser, #digit asParser, #digit asParser, #digit asParser ) trim flatten==>  [:t | t value asNumber ].
month := (#digit asParser, #digit asParser) trim flatten ==>  [:t | t value asNumber ].
day := month copy.
dateSeparator := $/ asParser trim value.

date  := year , dateSeparator , month , dateSeparator , day.

date parse: '2018/10/11'.
