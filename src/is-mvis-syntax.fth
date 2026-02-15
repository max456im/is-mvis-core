\ is-mvis-syntax.fth — MPL-2.0
\ Фазовый синтаксис мышления

\ Текущий режим (глобальная переменная)
variable current-mode
: OBSERVE    1 current-mode ! ;
: INFER      2 current-mode ! ;
: DOUBT      3 current-mode ! ;
: RESOLVE    4 current-mode ! ;
: COMMIT     5 current-mode ! ;

\ Логические связки (для HUGO-генератора)
: BUT        ( -- ) ;
: BECAUSE    ( -- ) ;
: THEREFORE  ( -- ) ;
: UNLESS     ( -- ) ;

\ Модальности
: POSSIBLY   ( -- ) ;
: NECESSARILY ( -- ) ;
: FORBIDDEN  ( -- ) ;

\ Вспомогательное слово для reasoner'а
: match-invariants ( -- flag )
  \ Реализуется в reasoner-модуле (например, на Rust)
  true ; \ заглушка

: create-perceptual-moment ( -- )
  \ Вызывает генерацию Decap/HUGO по профилю
  ;