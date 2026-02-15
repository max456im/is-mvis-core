// su-validator.rs — MPL-2.0
// Проверяет корректность IS-MVIS Stream Unit

use std::fs;
use serde::{Deserialize, Serialize};
use clap::Parser;

#[derive(Parser)]
struct Cli {
    #[arg(short, long)]
    input: String,
}

#[derive(Deserialize, Serialize)]
struct StreamUnit {
    su_id: String,
    stream_role: String,
    #[serde(skip_serializing_if = "Option::is_none")]
    phash: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    spectral: Option<[f32; 3]>,
    #[serde(skip_serializing_if = "Option::is_none")]
    event_anchor: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    se_level: Option<u8>, // SEI уровень (1..4)
    #[serde(skip_serializing_if = "Option::is_none")]
    anti_dissipative: Option<bool>,
}

fn validate_su(su: &StreamUnit) -> Result<(), String> {
    // Базовая валидация
    if !su.su_id.starts_with("uuid://") && !su.su_id.starts_with("synthetic://") {
        return Err("su_id must be UUID or synthetic URI".into());
    }

    if su.stream_role.is_empty() {
        return Err("stream_role is required".into());
    }

    // Валидация SEI-уровня
    if let Some(level) = su.se_level {
        if !(1..=4).contains(&level) {
            return Err("se_level must be 1..4".into());
        }
        // L1 не может быть антидиссипативным
        if level == 1 && su.anti_dissipative == Some(true) {
            return Err("L1 (subjective) cannot be anti-dissipative".into());
        }
    }

    // Антидиссипация требует SEI-уровня
    if su.anti_dissipative == Some(true) && su.se_level.is_none() {
        return Err("anti_dissipative requires se_level".into());
    }

    Ok(())
}

fn main() -> Result<(), Box<dyn std::error::Error>> {
    let cli = Cli::parse();
    let content = fs::read_to_string(&cli.input)?;
    let su: StreamUnit = serde_json::from_str(&content)?;

    match validate_su(&su) {
        Ok(()) => {
            println!("✅ Valid Stream Unit");
            println!("SU ID: {}", su.su_id);
            if let Some(level) = su.se_level {
                println!("SEI Level: {}", level);
            }
            Ok(())
        }
        Err(e) => {
            eprintln!("❌ Invalid Stream Unit: {}", e);
            std::process::exit(1);
        }
    }
}