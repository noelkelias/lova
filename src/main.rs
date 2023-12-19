use std::fs::read_to_string;
use std::collections::HashMap;


fn encode_statement(proof_lines: &Vec<Vec<String>>) -> Vec<[i64; 3]>{
   let statement_dict = HashMap::from([
       (">", 1),
      ("&", 2),
      ("|", 3),
      ("!",4)]);   
      
   let mut count = 5;

   let mut encoded_statements = Vec::new();
   for line in proof_lines{
      let mut statement: [i64; 3] = [0; 3];
      let raw_statement = line[0].split(&['>', '&', '|', '!']).filter(|&r| r != "").map(|r| r.to_string() ).collect::<Vec<_>>();
      
      for (index, elem) in raw_statement.iter().enumerate() {
         if statement_dict.get(&elem) == None{
            statement_dict.insert(elem, count);
            count += 1;
         } else {
             
         }
      }
   }

   encoded_statements
}

fn read_proof(path: &str) -> Vec<Vec<String>> {
   let mut result = Vec::new();
   let file = read_to_string(path).unwrap();

   for line in file.lines() {
      let  proof_line = line.replace(&[' '][..], "").split(&['(', ')', '[', ']']).filter(|&r| r != "").map(|r| r.to_string() ).collect::<Vec<_>>();
      result.push(proof_line);
  }

  result
}

fn main() {
   // --snip--
   let proof_lines = read_proof("misc/basic_proof.txt");
   println!("{:?}", proof_lines);

   
}