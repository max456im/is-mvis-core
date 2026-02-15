// SPDX-License-Identifier: MPL-2.0
// © Запевалов М.Н., 2026

use std::ffi::{CStr, CString};
use std::os::raw::c_char;

extern "C" {
    // Предполагается, что ontoForth или pForth уже скомпилирован и доступен
    fn forth_eval(cstr: *const c_char) -> i32;
}

/// Выполняет IS-MVIS-скрипт в Forth-интерпретаторе.
/// Возвращает 0 при успехе, ненулевое значение — ошибка.
#[no_mangle]
pub extern "C" fn is_mvis_run_script(script: &str) -> i32 {
    let c_script = match CString::new(script) {
        Ok(s) => s,
        Err(_) => return -1,
    };
    unsafe { forth_eval(c_script.as_ptr()) }
}

/// Проверяет, поддерживает ли текущий профиль указанный философский режим.
/// Режимы: "berkeley", "plato", "merleau-ponty"
#[no_mangle]
pub extern "C" fn is_mvis_profile_supports(mode: &str) -> bool {
    // Простая заглушка — в реальности читает onto144-profile
    matches!(mode, "berkeley" | "plato" | "merleau-ponty")
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_mode_support() {
        assert!(is_mvis_profile_supports("plato"));
        assert!(!is_mvis_profile_supports("nietzsche")); // пока не реализован
    }
}