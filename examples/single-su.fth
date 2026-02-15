\ single-su.fth — MPL-2.0
\ Пример: базовое восприятие от OVP-1 без интерпретации

include ../src/is-mvis-core.fth

OBSERVE
  su-id synthetic://ovp1-demo-20260215
  stream-role s" ovp1_primary"
  media-ref QmXyZ123...
  phash $ABCD1234EF567890
  spectral 0.88e 0.42e 0.11e
  event-anchor onto:Event/Percept_20260215T1400
  phase s" observation"
end-su