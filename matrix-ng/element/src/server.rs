use gotham::{
	handler::FileOptions,
	helpers::http::response::{create_empty_response, create_response},
	hyper::StatusCode,
	mime::APPLICATION_JSON,
	router::builder::{build_simple_router, DefineSingleRoute, DrawRoutes}
};
use serde::Serialize;
use std::env;

/// The directory containing the static element files
const DIR: &str = "/opt/element";

#[derive(Serialize)]
struct BaseUrl {
	base_url: String
}

impl BaseUrl {
	fn new(base_url: String) -> Self {
		Self { base_url }
	}
}

#[derive(Serialize)]
struct DefaultServerConfig {
	#[serde(rename = "m.homeserver")]
	homeserver: BaseUrl,
	#[serde(rename = "m.identity_server")]
	identity_server: BaseUrl
}

#[derive(Serialize)]
struct Config {
	// homeserver/integrationserver/... urls
	default_server_config: DefaultServerConfig,
	integrations_ui_url: String,
	integrations_rest_url: String,
	map_style_url: String,

	// branding
	brand: String,

	// allow/disallow experimental opt-in features
	#[serde(rename = "showLabsSettings")]
	show_labs_settings: bool,

	// default theme
	default_theme: String,

	// default country code used for phone numbers etc
	#[serde(rename = "defaultCountryCode")]
	default_country_code: String,

	// room directory servers
	#[serde(rename = "roomDirectory")]
	room_directory: RoomDirectory
}

#[derive(Serialize)]
struct RoomDirectory {
	servers: Vec<String>
}

fn env<D: Into<String>>(name: &str, default: D) -> String {
	env::var(name).unwrap_or_else(|_| default.into())
}

// safety: this is assigned only once in the start function and only read thereafter
static mut CONFIG: String = String::new();

pub fn start() {
	let hs = env("DEFAULT_HS_URL", "https://matrix.org");
	let config = serde_json::to_string(&Config {
		default_server_config: DefaultServerConfig {
			homeserver: BaseUrl::new(hs.clone()),
			identity_server: BaseUrl::new(env("DEFAULT_IS_URL", "https://vector.im"))
		},
		integrations_ui_url: env("INTEGRATIONS_UI_URL", "https://scalar.vector.im"),
		integrations_rest_url: env("INTEGRATIONS_REST_URL", "https://scalar.vector.im/api"),
		// taken from https://app.element.io/config.json
		map_style_url: env(
			"MAP_STYLE_URL",
			"https://api.maptiler.com/maps/streets/style.json?key=fU3vlMsMn4Jb6dnEIFsx"
		),

		brand: env("BRAND", "Element"),

		show_labs_settings: true,

		default_theme: env("DEFAULT_THEME", "dark"),

		default_country_code: env("DEFAULT_COUNTRY_CODE", "DE"),

		room_directory: RoomDirectory {
			servers: vec![
				hs,
				"https://matrix.org".to_owned(),
				"https://gitter.im".to_owned(),
				"https://libera.chat".to_owned(),
			]
		}
	})
	.unwrap();

	unsafe {
		CONFIG = config;
	}

	gotham::start(
		"0.0.0.0:8099",
		build_simple_router(|route| {
			route.get("/config.json").to(|state| {
				let res = create_response(&state, StatusCode::OK, APPLICATION_JSON, unsafe { CONFIG.as_str() });
				(state, res)
			});
			route.get("__ping").to(|state| {
				let res = create_empty_response(&state, StatusCode::NO_CONTENT);
				(state, res)
			});

			route.get("/").to_file(
				FileOptions::new(format!("{}/index.html", DIR))
					.with_cache_control("public")
					.with_gzip(true)
					.build()
			);
			route
				.get("/*")
				.to_dir(FileOptions::new(DIR).with_cache_control("public").with_gzip(true).build());
		})
	)
	.expect("Failed to start server");
}