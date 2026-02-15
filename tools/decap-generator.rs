// decap-generator.rs — MPL-2.0
// Генерирует Decap CMS-фрейм из Stream Unit

use std::fs;
use serde::{Deserialize, Serialize};
use clap::Parser;

#[derive(Parser)]
struct Cli {
    #[arg(short, long)]
    input: String,
    #[arg(short, long, default_value = "output.decaps.json")]
    output: String,
}

#[derive(Deserialize)]
struct StreamUnit {
    su_id: String,
    stream_role: String,
    #[serde(default)]
    entities: Vec<Entity>,
    #[serde(default)]
    event_anchor: Option<String>,
    #[serde(default)]
    phase: Option<String>,
    #[serde(default)]
    se_level: Option<u8>,
    #[serde(default)]
    anti_dissipative: Option<bool>,
}

#[derive(Deserialize)]
struct Entity {
    onto_uri: String,
    confidence: f32,
}

#[derive(Serialize)]
struct DecapFrame {
    frame_id: String,
    visual: VisualLayer,
    semantic: SemanticLayer,
    pragmatic: PragmaticLayer,
}

#[derive(Serialize)]
struct VisualLayer {
    r#type: String,
    elements: Vec<VisualElement>,
}

#[derive(Serialize)]
struct VisualElement {
    r#type: String,
    label: String,
    confidence: f32,
    style: String, // цвет/форма по SEI
}

#[derive(Serialize)]
struct SemanticLayer {
    title: String,
    summary: String,
    source: String,
}

#[derive(Serialize)]
struct PragmaticLayer {
    intent: String,
    action_prompt: Option<String>,
}

fn map_sei_to_style(level: Option<u8>, anti: bool) -> String {
    match (level, anti) {
        (Some(1), _) => "soft_blue".to_string(),       // L1 — диссипативный, мягкий
        (Some(2), true) => "focused_red".to_string(),  // L2 — целенаправленный
        (Some(3), true) => "structured_gold".to_string(),
        (Some(4), true) => "existential_violet".to_string(),
        _ => "neutral_gray".to_string(),
    }
}

fn generate_decap(su: &StreamUnit) -> DecapFrame {
    let entity_label = su.entities.first()
        .map(|e| e.onto_uri.split('/').last().unwrap_or("Unknown"))
        .unwrap_or("Event");

    let confidence = su.entities.first().map(|e| e.confidence).unwrap_or(0.0);

    let style = map_sei_to_style(su.se_level, su.anti_dissipative.unwrap_or(false));

    let intent = if su.anti_dissipative == Some(true) {
        "focus".to_string()
    } else {
        "inform".to_string()
    };

    DecapFrame {
        frame_id: format!("decap://{}", su.su_id),
        visual: VisualLayer {
            r#type: "symbolic".to_string(),
            elements: vec![VisualElement {
                r#type: "silhouette".to_string(),
                label: entity_label.to_string(),
                confidence,
                style,
            }],
        },
        semantic: SemanticLayer {
            title: su.event_anchor.as_ref()
                .map(|s| s.split('/').last().unwrap_or("Perception"))
                .unwrap_or("Observation")
                .to_string(),
            summary: format!("Detected {} (confidence: {:.0}%)", entity_label, confidence * 100.0),
            source: su.stream_role.clone(),
        },
        pragmatic: PragmaticLayer {
            intent,
            action_prompt: if su.anti_dissipative == Some(true) {
                Some("Maintaining focus".to_string())
            } else {
                None
            },
        },
    }
}

fn main() -> Result<(), Box<dyn std::error::Error>> {
    let cli = Cli::parse();
    let content = fs::read_to_string(&cli.input)?;
    let su: StreamUnit = serde_json::from_str(&content)?;

    let decap = generate_decap(&su);
    let output = serde_json::to_string_pretty(&decap)?;
    fs::write(&cli.output, output)?;

    println!("✅ Generated Decap CMS frame: {}", cli.output);
    Ok(())
}