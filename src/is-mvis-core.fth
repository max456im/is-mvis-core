\ is-mvis-core.fth — MPL-2.0
\ Базовые примитивы IS-MVIS: данные восприятия

\ Онтологические URI → ID (для компактности)
: PERSON 1 ;
: OBJECT 2 ;
: EVENT  3 ;

\ Спектральный базис OVP-1
: UV    0 ;
: GREEN 1 ;
: IR    2 ;

\ Примитивы Stream Unit
: su-id          ( addr u -- ) drop ; \ игнорируем, но ожидаем UUID
: stream-role    ( addr u -- ) 2drop ; \ строка роли
: media-ref      ( addr u -- ) 2drop ; \ CID или хэш
: phash          ( u64 -- ) ;          \ perceptual hash как число
: spectral       ( uv green ir -- ) ;  \ три float'а в стеке
: entity         ( uri confidence x1 y1 x2 y2 -- ) ;
: event-anchor   ( eid -- ) ;
: phase          ( addr u -- ) 2drop ;

\ Завершение SU — вызывает reasoner
: end-su ( -- )
  match-invariants
  if create-perceptual-moment then ;