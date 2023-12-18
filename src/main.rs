use std::fs;

fn main() {
   // --snip--
   let file_path = "misc/basic_proof.txt";

   let contents = fs::read_to_string(file_path)
       .expect("Should have been able to read the file");

   println!("{}", contents);
}