use hex_color::HexColor;
use openrgb2::{OpenRgbClient, OpenRgbResult};

#[tokio::main]
async fn main() -> OpenRgbResult<()> {

    if std::env::args().len() != 2 {
        eprintln!("Usage: {} <hex_color>", 
            std::env::args().next().unwrap());
        std::process::exit(1);
    }

    let args: Vec<String> = std::env::args().collect();

    let client = OpenRgbClient::connect().await?;

    client
        .get_controller(0)
        .await?
        .set_all_leds(openrgb2::Color::new(
            HexColor::parse(args[1].as_str())
                .unwrap_or(HexColor::default())
                .r,
            HexColor::parse(args[1].as_str())
                .unwrap_or(HexColor::default())
                .g,
            HexColor::parse(args[1].as_str())
                .unwrap_or(HexColor::default())
                .b,
        ))
        .await?;

    Ok(())
}
