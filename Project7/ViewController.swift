//
//  ViewController.swift
//  Project7
//
//  Created by othman shahrouri on 8/15/21.
//

import UIKit

class ViewController: UITableViewController {
    var petitions = [Petition]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // let urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
            let urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        
        if let url = URL(string: urlString){
            if let data = try? Data(contentsOf: url){
                //we're OK to parse
                parse(json: data)
            }
        }
        
  
    }
    
    
    func parse(json: Data){
        //dedicated to converting between JSON and Codable objects.
        let decoder = JSONDecoder()
        // asking it to convert our json data into a Petitions object,Petitions.self to refer to the type itself rather than an instance
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json){
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = petitions[indexPath.row].title
        cell.detailTextLabel?.text = petitions[indexPath.row].body
        return cell
    }
    
    

}

