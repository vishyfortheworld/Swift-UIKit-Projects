//
//  ViewController.swift
//  Project7
//
//  Created by Vishrut Vatsa on 01/12/20.
//  

import UIKit

class ViewController: UITableViewController {
    var petitions = [Petition]()

    override func viewDidLoad() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(showCredits))
        
        super.viewDidLoad()
        
        performSelector(inBackground: #selector(fetchJSON), with: nil)

  }
    
    
  @objc  func fetchJSON() {
        let urlString: String

        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        } else {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
        }
        
        

        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
            parse(json: data)
                return
            }
        }
    performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
        }
    
    
    

    func parse(json: Data) {
        let decoder = JSONDecoder()

        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            
            tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
        } else {
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
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }

   @objc func showError() {
       
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    
    
    @objc func showCredits() {
            let ac = UIAlertController(title: "Developer and Data Source", message: " \n A Vishrut Vatsa Production. \n Copyright © Vishrut Vatsa. \n All rights reserved. \n  \n \n The data sourced is licensed from \n WhiteHouse Petitions API ", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            present(ac, animated: true)
        }
}

