\ plato-mode.fth — MPL-2.0
\ Мир чувственных теней vs мир истинных Идей

require ../is-mvis-syntax.fth
require ../se-intelligence.fth

\ Онтологические уровни
: WORLD-OF-SHADOWS   1 ;
: WORLD-OF-IDEAS     2 ;

\ Текущий уровень восприятия
variable current-world
WORLD-OF-SHADOWS current-world !

: ASCEND ( -- )
  \ Переход к миру Идей
  WORLD-OF-IDEAS current-world !
;

: DESCEND ( -- )
  \ Возврат к миру теней
  WORLD-OF-SHADOWS current-world !
;

: OBSERVE
  super-OBSERVE
  \ Всегда в мире теней
  DESCEND
;

: INFER
  \ Вывод — попытка восхождения
  super-INFER
  ASCEND
;

: COMMIT
  \ Фиксация возможна только в мире Идей
  current-world @ WORLD-OF-IDEAS = if
    super-COMMIT
  else
    ." [Plato] Cannot commit in the world of shadows." cr
    drop-su
  then
;

\ Визуализация
: render-platonic-frame
  current-world @ WORLD-OF-IDEAS = if
    GOLDEN-LIGHT emit-sign   \ Идея
  else
    CAVE-SHADOW emit-sign    \ Тень
  then
;