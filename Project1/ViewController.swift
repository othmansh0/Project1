//
//  ViewController.swift
//  Project1
//
//  Created by othman shahrouri on 7/31/21.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()
    var numberOfClicks = [Int]()
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)

        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        pictures.sort()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        numberOfClicks = Array(repeating: 0, count: pictures.count)
        
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for:indexPath )
        cell.textLabel?.text = pictures[indexPath.row]
        let loadedArray = defaults.object(forKey: "clicks") as? [Int] ?? [Int]()
        cell.detailTextLabel?.text = "\(loadedArray[indexPath.row])"
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Incrementing frequency array & updating tableView
        numberOfClicks[indexPath.row] += 1
        defaults.set(numberOfClicks, forKey: "clicks")
        tableView.reloadData()
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            
            vc.selectedImage = pictures[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
            vc.selectedIndex = indexPath.row + 1
            vc.numOfImages = pictures.count
        
        }
    }
    
}

