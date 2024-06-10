//
//  ProductDetailViewController.swift
//  ProductApp
//
//  Created by KANISHK on 10/06/24.
//

import UIKit

class ProductDetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    var product: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
                setupUI()
        // Do any additional setup after loading the view.
    }
    func setupUI() {
            guard let product = product else { return }
            
            titleLabel.text = product.title
            descriptionLabel.text = product.description
            
            // Load and display the product image
            if let imageURL = URL(string: product.thumbnail) {
                URLSession.shared.dataTask(with: imageURL) { data, response, error in
                    if let data = data, error == nil {
                        DispatchQueue.main.async {
                            self.productImageView.image = UIImage(data: data)
                        }
                    }
                }.resume()
            }
        }
    }
