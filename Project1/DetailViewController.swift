//
//  DetailViewController.swift
//  Project1
//
//  Created by othman shahrouri on 7/31/21.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    var selectedIndex: Int?
    var numOfImages: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let imageIndex = selectedIndex, let totalNumImages = numOfImages{
            title = "Picture \(imageIndex) of \(totalNumImages)"
        }
        
        navigationItem.largeTitleDisplayMode = .never

        if let imageToLoad = selectedImage{
            imageView.image =  UIImage(named: imageToLoad)
            
        }
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
  
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
}
