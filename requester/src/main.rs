use std::{env, io::Write};

fn main() {
    let url = env::args().nth(1).expect("didn't get an url");
    let body = ureq::get(&url)
        .call()
        .expect("failed to make a request")
        .into_string()
        .expect("failed to read body");
    std::io::stdout()
        .lock()
        .write_all(body.as_bytes())
        .expect("failed to write body to stdout");
}
