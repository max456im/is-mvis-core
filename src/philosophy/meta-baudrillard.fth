\ meta-baudrillard.fth — MPL-2.0
\ Гиперреальность: нет оригинала, только модели

require ../is-mvis-syntax.fth
require ../sign-vocabulary.fth

: SIMULACRUM? ( -- flag )
  \ Проверяет: есть ли внешний источник, или всё — внутренняя модель?
  current-su has-external-anchor? 0=
;

: OBSERVE
  super-OBSERVE
  SIMULACRUM? if
    MIRROR emit-sign   \ 🪞
    ." [Baudrillard] This is a copy without an original." cr
  then
;

: INFER
  super-INFER
  \ Все выводы — рекомбинации знаков
  mark-as-simulacrum
;

: COMMIT
  \ Фиксация невозможна — только циркуляция знаков
  ." [Baudrillard] No truth to commit — only repetition." cr
  drop-su
;