//
//  ViewController.swift
//  MakeUpApp
//
//  Created by TingxinLi on 12/17/18.
//  Copyright © 2018 TingxinLi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var makeUp = [MakeUp](){
        
        didSet {
            DispatchQueue.main.async {
                self.MakeupTableView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var MakeupSearchBar: UISearchBar!
    @IBOutlet weak var MakeupTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MakeupTableView.dataSource = self
        MakeupSearchBar.delegate = self
        
        MakeupAPIClient.getMakeup() { (data, error) in
            if let error = error {
                print(error)
            } else if let data = data {
                self.makeUp = data
                
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? MakeUpDetailViewController, let selectedIndexPath = MakeupTableView.indexPathForSelectedRow else { return }
        let makeUpToSend = makeUp[selectedIndexPath.row]
        destination.Makeup = makeUpToSend
    }

}





extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return makeUp.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = MakeupTableView.dequeueReusableCell(withIdentifier: "MakeUpCell", for: indexPath) as? MakeUpCell else { return UITableViewCell() }
        
        let makeupToSet = makeUp[indexPath.row]
       cell.productName.text = makeupToSet.name
       // cell.textLabel?.text = makeupToSet.brand
        if let price = makeupToSet.price {
            cell.priceTag.text = "$" + String(price)
        } else {
            cell.priceTag.text = "$$$"
        }
        
        
        
        if let url = URL.init(string: makeupToSet.image_link) {
            do {
                let data = try Data.init(contentsOf: url)
                if let image = UIImage.init(data: data) {
                    cell.productImage.image = image
                }
            }catch {
                print("Image error is \(error)")
            }
        }
        
        //
        return cell
    }
}


extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        print(searchBar.text)
//        if let searchTerm = searchBar.text {
//           self.makeUp.filter($0)
//        }
//        searchBar.resignFirstResponder()
//
        searchBar.resignFirstResponder() // resign == keyboard
        guard let searchText = searchBar.text else { return }
        
        // user can enter "classic" or "egg"
        //results should return "Classic Deviled Eggs"
        makeUp = makeUp.filter{ ($0.name?.contains(searchText))!}
    }
    
    
    
    
}
