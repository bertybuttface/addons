use std::process::exit;

pub fn run() {
	let res = match attohttpc::get("http://localhost/__ping").send() {
		Ok(res) => res,
		Err(e) => {
			eprintln!("ERROR: {}", e);
			exit(1);
		}
	};
	if !res.is_success() {
		eprintln!("Response returned status code {}", res.status());
		exit(1);
	}
}