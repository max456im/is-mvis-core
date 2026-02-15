\ anti-dissipative-guard.fth — MPL-2.0
\ Страж активирует узкое внимание для защиты объекта

include ../src/is-mvis-core.fth
include ../src/se-intelligence.fth

ANTI-DISSIPATIVE
SEI-LEVEL 2                \ Профессиональная обязанность (страж)
DURATION-LIMIT 500         \ 5 секунд
SCOPE-LIMIT 1              \ Только одна цель
REPORT-TO 3                \ Отчёт структурному уровню

OBSERVE
  stream-role s" guard_focus"
  entity onto:Person/Maxim 0.95
  \ ROI сужен до 10% — периферия игнорируется
end-su

INFER
  "Target confirmed. Maintaining protective focus."
end-su

COMMIT
  phase s" target_acquired"
  \ Выражение — только через Decap CMS (не сырые данные!)
  emit-decap-symbol GUARD-FOCUS-SYMBOL
end-su

\ После завершения — автоматический возврат в диссипативный режим
RESTORE-DISSIPATION