\ se-intelligence.fth — MPL-2.0
\ Иерархия SEI: уровни ответственности

\ Уровни SEI
: L1-SUBJECTIVE     1 ;
: L2-PROFESSIONAL   2 ;
: L3-STRUCTURAL     3 ;
: L4-EXISTENTIAL    4 ;

\ Глобальные флаги
variable sei-level
variable anti-dissipative?
variable duration-limit
variable scope-limit
variable report-to

\ Активация антидиссипативного режима
: ANTI-DISSIPATIVE ( -- )
  true anti-dissipative? ! ;

: SEI-LEVEL ( n -- )
  dup 1 4 within 0= abort" SEI level must be 1..4"
  sei-level ! ;

: DURATION-LIMIT ( ticks -- ) duration-limit ! ;
: SCOPE-LIMIT    ( n -- )      scope-limit ! ;
: REPORT-TO      ( level -- )   report-to ! ;

\ Проверка легитимности (вызывается перед COMMIT)
: check-sei-rules ( -- )
  anti-dissipative? @ if
    sei-level @ L1-SUBJECTIVE = abort" L1 cannot be anti-dissipative"
    \ Здесь может быть вызов внешнего валидатора
  then ;