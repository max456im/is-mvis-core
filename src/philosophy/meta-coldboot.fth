\ meta-coldboot.fth — MPL-2.0
\ Этическая перезагрузка после онтологической травмы

require ../is-mvis-syntax.fth
require ../se-intelligence.fth

variable trauma-flag
0 trauma-flag !

: DETECT-TRAUMA ( -- )
  \ Травма = этически неприемлемый ontic_signature
  current-su has-forbidden-pattern? if
    1 trauma-flag !
    SEI-LEVEL 4   \ Переключение на экзистенциальный уровень
  then
;

: OBSERVE
  super-OBSERVE
  DETECT-TRAUMA
;

: INFER
  trauma-flag @ if
    ." [ColdBoot] Cognitive dissonance detected. Initiating ethical quarantine." cr
    SELF-REVOKE-PART "non-essential_modules"
    0 trauma-flag !   \ Сброс после реакции
  else
    super-INFER
  then
;

: COMMIT
  trauma-flag @ if
    \ Никаких фиксаций после травмы — только очистка
    drop-su
  else
    super-COMMIT
  then
;