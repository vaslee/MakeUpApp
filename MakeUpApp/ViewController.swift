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
       
//        if let price = makeupToSet.price {
//            cell.priceTag.text = "$" + String(price)
//        } else {
//            cell.priceTag.text = "No Data"
//        }
        
        if let price = makeupToSet.price {
            if price == "0.0" {
                cell.priceTag.text = "n/a"
            } else {
                cell.priceTag.text = "$" + String(price)
            }
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
        
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        searchBar.resignFirstResponder()
        guard let searchText = searchBar.text else { return }
        
    
        makeUp = makeUp.filter{ ($0.name?.contains(searchText))!}
    }
    
    
    
    
}
