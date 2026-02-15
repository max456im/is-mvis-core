\ dialog-flow.fth — MPL-2.0
\ Synthetic mind отвечает на запрос в трёх философских режимах

include ../src/is-mvis-core.fth
include ../src/is-mvis-syntax.fth
include ../src/profile-loader.fth

\ Загружаем профиль Платона
load-profile PLATO-MODE

OBSERVE
  entity onto:Person/Maxim 0.92
  event-anchor onto:Event/Meeting_20260215
end-su

INFER
  "This appearance is a shadow of the true Idea of Personhood."
end-su

COMMIT
  phase s" philosophical_response"
  \ Выражение через HUGO (не SU!)
  emit-hugo s" То, что вы называете 'Maxim', — лишь тень подлинной Идеи." 
end-su

\ Переключаемся на Беркли
load-profile BERKELEY-MODE

OBSERVE
  entity onto:Person/Maxim 0.92
end-su

INFER
  "To be is to be perceived. Maxim exists only in this act of perception."
end-su

emit-hugo s" Максим существует, поскольку я его воспринимаю — и только в этом акте."