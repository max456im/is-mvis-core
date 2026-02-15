\ profile-loader.fth — MPL-2.0
\ Загрузка онтологических профилей

\ Поддерживаемые профили
: PROFILE/DEFAULT      s" default" ;
: PROFILE/CHOLERIC     s" choleric" ;
: PROFILE/BERKELEY     s" berkeley" ;
: PROFILE/PLATO        s" plato" ;
: PROFILE/MERLEAU-PONTY s" merleau-ponty" ;

\ Текущий профиль
create current-profile 32 allot

\ Установка профиля
: use-profile ( addr u -- )
  dup 32 > abort" Profile name too long"
  current-profile swap move ;

\ Пример: активация философского режима
: load-philosophy-mode ( -- )
  current-profile count
  s" berkeley" compare 0= if include src/philosophy/berkeley-mode.fth exit then
  s" plato" compare 0=    if include src/philosophy/plato-mode.fth exit then
  s" merleau-ponty" compare 0= if include src/philosophy/merleau-ponty-mode.fth exit then
  ;