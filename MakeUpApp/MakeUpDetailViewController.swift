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
       // String.deleteHTMLTag(Makeup.description ?? "no info found")
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
            func deleteHTMLTag(tag:String) -> String {
                let description2 = description.replacingOccurrences(of: "(?i)</?\(tag)\\b[^<]*>", with: " ")
                 return description2
            }
            MakeupDescription.text = deleteHTMLTag(tag: description)
            
        } else {
            MakeupDescription.text = "no info found"
        }
   }
    


}

//extension String {
//    func deleteHTMLTag(tag:String) -> String {
//        return self.replacingOccurrences(of: "(?i)</?\(tag)\\b[^<]*>", with: "", options: .regularExpression, range: nil)
//    }
//
//    func deleteHTMLTags(tags:[String]) -> String {
//        var mutableString = self
//        for tag in tags {
//            mutableString = mutableString.deleteHTMLTag(tag: tag)
//        }
//        return mutableString
//    }
//}
