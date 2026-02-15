\ sign-vocabulary.fth — MPL-2.0
\ Онтологические знаки для человеко-машинного диалога

\ Типы знаков
: ACK-SIGN    1 ;
: QUERY-SIGN  2 ;
: WARN-SIGN   3 ;
: SHIFT-SIGN  4 ;
: MIRROR-SIGN 5 ; \ Бодрийяр: симулякр
: CANDLE-SIGN 6 ; \ Платон: идея за пределами

\ Эмиттер знака (реализуется в Decap CMS)
: emit-sign ( sign-id -- )
  case
    ACK-SIGN    of ." [✅]" endof
    QUERY-SIGN  of ." [❓]" endof
    WARN-SIGN   of ." [⚠️]" endof
    SHIFT-SIGN  of ." [→]"  endof
    MIRROR-SIGN of ." [🪞]" endof
    CANDLE-SIGN of ." [🕯️]" endof
  endcase ;