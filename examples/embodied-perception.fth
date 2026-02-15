\ embodied-perception.fth — MPL-2.0
\ Восприятие как вплетённость в мир (Merleau-Ponty)

include ../src/is-mvis-core.fth
include ../src/philosophy/merleau-ponty-mode.fth

\ Активируем режим
activate-merleau-ponty

OBSERVE
  \ Нет чёткой границы между "я" и "миром"
  spectral 0.5e 0.5e 0.5e
  gradient-saturation 0.3e
  \ Внимание распределено (ROI = весь FoV)
end-su

INFER
  "The world is not 'out there' — it is lived through my sensorium."
end-su

COMMIT
  phase s" embodied_awareness"
  \ Выражение — через абстрактный Decap-образ (размытые границы)
  emit-decap-symbol EMBODIED-AWARENESS-SYMBOL
end-su

deactivate-merleau-ponty