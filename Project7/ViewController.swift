//
//  ViewController.swift
//  Project7
//
//  Created by othman shahrouri on 8/15/21.
//

import UIKit
//All user interface work must occur on the main thread, which is the initial thread your program is created on. If you try to execute code on a different thread, it might work, it might fail to work, it might cause unexpected results, or it might just crash.

//Broadly speaking, if you’re accessing any remote resource, you should be doing it on a background thread – i.e., any thread that is not the main thread


// GCD works with a system of queues,First In, First Out (FIFO)
// GCD calls don't create threads to run in, they just get assigned to one of the existing threads for GCD to manage


class ViewController: UITableViewController {
    var petitions = [Petition]()
    var originalPetitions = [Petition]()
    var numberOfFilters = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(showCredits))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterPetitions))
        
       
        performSelector(inBackground: #selector(fetchJSON), with: nil)
        
      
    }
    
    @objc func fetchJSON(){
        let urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            // urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            // urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }

       
            
    
            if let url = URL(string: urlString){
                if let data = try? Data(contentsOf: url){//downloading data from server
                    //we're OK to parse
                    parse(json: data)//will be called in background since fetchJSON us called in background
                    //we need to modify tableView.reloadData in parse function to make it run on main thread
                    return
                }
            }
           
        performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
            
        
    }
    
    @objc func filterPetitions(){
        numberOfFilters += 1
        let ac = UIAlertController(title: "Filter", message: "Enter a Keyword", preferredStyle: .alert)
        ac.addTextField()
        var filteredPetitions = [Petition]()
        let action = UIAlertAction(title: "Search", style: .default)   {        [weak self] action in
            //If user tries to filter data again
            if(self!.numberOfFilters > 1){
                filteredPetitions.removeAll()
                //instead of parsing data in petitions again
                //created another ptetions that never changes
                self?.petitions  = self?.originalPetitions ?? []
            }
            guard let keyWord = ac.textFields?[0].text else { return }
            print(keyWord)
            for petition in self?.petitions ?? [] {
                if(petition.body.contains(keyWord) || petition.title.contains(keyWord) ){
                    filteredPetitions.append(petition)
                }
            }
            self?.petitions = filteredPetitions
            self?.tableView.reloadData()
        }
        ac.addAction(action)
        present(ac, animated: true)
        
        
        
        
        
    }
    
    @objc func showCredits(){
        let ac = UIAlertController(title: "Credits", message: "data comes from the We The People API of the Whitehouse.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac,animated: true)
    }
    
   @objc func showError() {
      
          
            let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
           present(ac, animated: true)
       
       
    }
    
    
    func parse(json: Data){
        //dedicated to converting between JSON and Codable objects.
        let decoder = JSONDecoder()
        
        // asking it to convert our json data into a Petitions object,Petitions.self to refer to the type itself rather than an instance
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json){
            petitions = jsonPetitions.results
            originalPetitions = petitions
            
            //it's never OK to do user interface work on the background thread
            //so we are gonna excute code on main thread
            //tableView.reloadData()
            tableView.performSelector(onMainThread: #selector(tableView.reloadData), with: nil, waitUntilDone: false)
        } else{//fetch wont call show error if an error occured while parsing data so we need to call show error here
            performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DeatilViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}

