use std::fs::read_to_string;
use std::collections::HashMap;


//Encode the statement into a vector of arrays 
fn encode_statement(proof_lines: &Vec<Vec<String>>) -> Vec<[i64; 3]>{
   let mut statement_dict = HashMap::from([
       ("!", 1),
      ("&", 2),
      ("|", 3),
      (">",4)]);   

   let symbols = ["!", "&", "|", ">"];
   let mut count:i64 = 5;

   let mut encoded_statements = Vec::new();
   for line in proof_lines{
      let mut statement: [i64; 3] = [0; 3];
      let mut raw_statement = line[0].split(&['!', '&','|','>'][..]).collect::<Vec<_>>();

      for symbol in symbols{
         if line[0].contains(&symbol.to_owned()){
            raw_statement.push(symbol);
         }
      }
      
      for (index, elem) in raw_statement.iter().enumerate() {
         if statement_dict.get(elem) == None {
            statement_dict.insert(elem, count);
            statement[index] = count;
            count += 1;
         } else {
            statement[index] = *statement_dict.get(elem).unwrap_or(&0);      
         }
      }
      encoded_statements.push(statement);

   }

   encoded_statements
}

//Reading the proof into a vector of strings
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

   println!("{:?}", encode_statement(&proof_lines));
   
}