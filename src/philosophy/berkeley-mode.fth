\ berkeley-mode.fth — MPL-2.0
\ "Esse est percipi" — быть значит быть воспринимаемым

require ../is-mvis-syntax.fth

\ Онтологические примитивы Беркли
: PERCEIVED-BY ( observer -- ) ;
: EXISTS-ONLY-WHEN ( condition -- ) ;

\ Переопределение фаз
: OBSERVE
  \ Всё, что наблюдается, существует
  super-OBSERVE
  \ Автоматически связывает с активным наблюдателем
  current-observer PERCEIVED-BY
;

: INFER
  \ Вывод возможен только если подтверждён восприятием
  \ Иначе — отклоняется как "не-сущее"
  check-perceptual-support if
    super-INFER
  else
    ." [Berkeley] Non-perceived inference rejected." cr
    drop-su
  then
;

\ Утилита: проверка, есть ли поддержка восприятия
: check-perceptual-support ( -- flag )
  \ Проверяет, есть ли хотя бы один SU с тем же event-anchor и phase=observation
  current-event-anchor has-observation?
;