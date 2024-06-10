//
//  ViewController.swift
//  ProductApp
//
//  Created by KANISHK on 10/06/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var viewProductsButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
                view.backgroundColor = .white
                setupButton()
        // Do any additional setup after loading the view.
    }
    func setupButton() {
            viewProductsButton.setTitle("View Products", for: .normal)
            viewProductsButton.addTarget(self, action: #selector(navigateToProductList), for: .touchUpInside)
        }
    

    @IBAction func navigateToProductList(_ sender: UIButton) {
        let productListVC = storyboard?.instantiateViewController(withIdentifier: "ProductListViewController") as! ProductListViewController
                navigationController?.pushViewController(productListVC, animated: true)
            }
        }
    

