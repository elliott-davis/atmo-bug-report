use suborbital::runnable::*;
use suborbital::db;
// use suborbital::util;
// use suborbital::log;

struct Readall{}

impl Runnable for Readall {
    fn run(&self, _: Vec<u8>) -> Result<Vec<u8>, RunErr> {
        suborbital::resp::content_type("application/json; charset=utf-8");
        match db::select("SelectAllRestaurants", Vec::new()) {
            Ok(result) => Ok(result),
            Err(e) => {
                Err(RunErr::new(500, e.message.as_str()))
            }
        }
    }
}

// initialize the runner, do not edit below //
static RUNNABLE: &Readall = &Readall{};

#[no_mangle]
pub extern fn init() {
    use_runnable(RUNNABLE);
}