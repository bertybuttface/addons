use std::env;

mod healthcheck;
mod server;

fn main() {
	let mut args = env::args();
	let _ = args.next().unwrap();
	let cmd = args.next().expect("Missing command");
	if args.next().is_some() {
		panic!("No further arguments expected");
	}

	let mut cmd = cmd.as_str();
	while let Some(idx) = cmd.find('/') {
		cmd = &cmd[idx + 1..];
	}
	match cmd {
		"healthcheck" => healthcheck::run(),
		"server" => server::start(),
		"version" => println!("{}", env!("ELEMENT_VERSION")),
		_ => panic!("Unknown command")
	};
}