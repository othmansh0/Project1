//
//  ViewController.swift
//  Project1
//
//  Created by othman shahrouri on 7/31/21.
//

import UIKit

class ViewController: UICollectionViewController {
   
    
    
    
    var pictures = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        //Loading data in background
        performSelector(inBackground: #selector(loadImages), with: nil)
        
        
        
        DispatchQueue.main.async { [weak self ] in
            self?.navigationController?.navigationBar.prefersLargeTitles = true
            self?.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(self?.shareTapped))
        }
     
    }


   
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
  
  
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Picture", for:indexPath ) as? NsslCell else {fatalError("We are fucked")}
            
            cell.imageName.text = pictures[indexPath.item]
           
        cell.image2.image = UIImage(named: pictures[indexPath.item])
     
       
        

        
        return cell
    }
    
    
    
 
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            
            vc.selectedImage = pictures[indexPath.item]
            navigationController?.pushViewController(vc, animated: true)
            vc.selectedIndex = indexPath.item + 1
            vc.numOfImages = pictures.count
        }
        
    }
    
    
    
    @objc func shareTapped() {
         let item = ["This is a great app"]
        let vc = UIActivityViewController(activityItems: item, applicationActivities:[])
        present(vc,animated: true)
        
        
        
    }
    
    @objc func loadImages(){
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)

        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        pictures.sort()
        
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.performSelector(onMainThread: #selector(self?.collectionView.reloadData), with: nil, waitUntilDone: false)
        }
     
    }
    
    
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
}

