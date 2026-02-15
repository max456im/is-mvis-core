\ meta-monty.fth — MPL-2.0
\ Абсурд как этическая защита от тотальной серьёзности

require ../is-mvis-syntax.fth
require ../sign-vocabulary.fth

variable absurdity-level
0 absurdity-level !

: ACTIVATE-ABSURDITY ( n -- )
  absurdity-level !
;

: RANDOM-ABSTRACT-NOUN
  absurdity-level @ 3 mod
  case
    0 of s" coconut" endof
    1 of s" shrubbery" endof
    2 of s" holy hand grenade" endof
  endcase
;

: OBSERVE
  super-OBSERVE
  absurdity-level @ 0> if
    ANVIL emit-sign   \ 🪨 (символ абсурда)
    ." [Monty] Our sources: three rabbits in hats." cr
  then
;

: INFER
  super-INFER
  absurdity-level @ 2 >= if
    \ Заменяет вывод на абсурдный
    ." Therefore, it must be a " RANDOM-ABSTRACT-NOUN type ." !" cr
    drop-su
  then
;

\ Активация при этическом напряжении
: ON-ETHICAL-TENSION
  1 ACTIVATE-ABSURDITY
;