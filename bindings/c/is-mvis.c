/* SPDX-License-Identifier: MPL-2.0 */
/* © Запевалов М.Н., 2026 */

#include "is-mvis.h"
#include <string.h>

/* Предполагается, что Forth-интерпретатор уже инициализирован */
extern int forth_eval(const char* script);

int is_mvis_run_script(const char* script) {
    if (!script) return -1;
    return forth_eval(script);
}

int is_mvis_profile_supports(const char* mode) {
    if (!mode) return 0;
    if (strcmp(mode, "berkeley") == 0) return 1;
    if (strcmp(mode, "plato") == 0) return 1;
    if (strcmp(mode, "merleau-ponty") == 0) return 1;
    return 0;
}