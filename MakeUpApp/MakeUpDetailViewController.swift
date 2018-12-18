//
//  MakeUpDetailViewController.swift
//  MakeUpApp
//
//  Created by TingxinLi on 12/17/18.
//  Copyright © 2018 TingxinLi. All rights reserved.
//

import UIKit

class MakeUpDetailViewController: UIViewController {

    var Makeup: MakeUp!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var link: UITextView!
    
    @IBOutlet weak var brandLabel: UILabel!
    
    @IBOutlet weak var picture: UIImageView!
    
    @IBOutlet weak var MakeupDescription: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = Makeup.name
        brandLabel.text = Makeup.brand
        
        link.text = Makeup.product_link
        
        if let url = URL.init(string: Makeup.image_link) {
            do {
                let data = try Data.init(contentsOf: url)
                if let image = UIImage.init(data: data) {
                    picture.image = image
                }
            }catch {
                print("Image error is \(error)")
            }
        }

        if let description = Makeup.description {
        MakeupDescription.text = description
        } else {
            MakeupDescription.text = "no info found"
        }
    }
    


}