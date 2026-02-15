\ merleau-ponty-mode.fth — MPL-2.0
\ Воплощённое, телесное восприятие: разум вплетён в мир

require ../is-mvis-syntax.fth
require ../sign-vocabulary.fth

\ Примитивы телесности
: EMBODIED-FOCUS ( -- ) ;      \ внимание как телесная ориентация
: AMBIGUITY-TOLERANCE ( n -- ) ; \ допуск неопределённости (0..1)

\ Настройки по умолчанию
0.7 AMBIGUITY-TOLERANCE

: OBSERVE
  super-OBSERVE
  \ ROI определяется не только зрением, но и "телесной готовностью"
  EMBODIED-FOCUS
;

: DOUBT
  \ Сомнение — не ошибка, а условие понимания
  super-DOUBT
  \ Визуализация: знак "теневой контур"
  SHADOW-CONTOUR emit-sign
;

: RESOLVE
  \ Разрешение — не устранение неопределённости, а принятие её как части мира
  super-RESOLVE
  \ Сохраняет след сомнения в ontic_signature
  mark-ambiguity-trace
;