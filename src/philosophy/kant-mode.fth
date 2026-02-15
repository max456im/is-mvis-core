\ kant-mode.fth — MPL-2.0
\ Категорический императив как основа познания

require ../is-mvis-syntax.fth

: UNIVERSALIZABLE? ( action -- flag )
  \ Проверяет: можно ли действие сделать всеобщим законом?
  \ Реализация зависит от onto16-правил
  check-universalization-rule
;

: INFER
  super-INFER
  current-inference UNIVERSALIZABLE? 0= if
    ." [Kant] Inference fails the test of universal law." cr
    drop-su
  then
;

: COMMIT
  \ Только если действие морально допустимо
  current-commitment is-morally-permissible? if
    super-COMMIT
  else
    ." [Kant] Action cannot be willed as universal law." cr
    drop-su
  then
;