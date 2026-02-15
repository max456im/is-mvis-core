/* SPDX-License-Identifier: MPL-2.0 */
/* © Запевалов М.Н., 2026 */

#ifndef IS_MVIS_BINDINGS_H
#define IS_MVIS_BINDINGS_H

#ifdef __cplusplus
extern "C" {
#endif

/**
 * @brief Выполняет IS-MVIS-скрипт в Forth-интерпретаторе.
 * @param script — null-terminated строка на Forth (IS-MVIS)
 * @return 0 при успехе, !=0 — ошибка
 */
int is_mvis_run_script(const char* script);

/**
 * @brief Проверяет поддержку философского режима.
 * @param mode — "berkeley", "plato", "merleau-ponty"
 * @return 1 если поддерживается, 0 — нет
 */
int is_mvis_profile_supports(const char* mode);

#ifdef __cplusplus
}
#endif

#endif /* IS_MVIS_BINDINGS_H */