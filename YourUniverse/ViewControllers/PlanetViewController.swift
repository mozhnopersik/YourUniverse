//
//  PlanetViewController.swift
//  YourUniverse
//
//  Created by Вероника Карпова on 10.10.2023.
//

import UIKit
import Alamofire

class PlanetViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var onThisPhotoLabel: UILabel!
    @IBOutlet weak var explanationLabel: UILabel!
    @IBOutlet weak var yourUniverseLabel: UILabel!
    @IBOutlet weak var copyrightLabel: UILabel!
    
    let placeholderImage = UIImage(named: "placeholder")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        titleLabel.font = UIFont(name: "TildaSans-Black", size: 20)
        explanationLabel.font = UIFont(name: "TildaSans-Regular", size: 13)
        onThisPhotoLabel.font = UIFont(name: "TildaSans-Regular", size: 12)
        yourUniverseLabel.font = UIFont(name: "TradeWinds", size: 30)
        
        imageView.layer.cornerRadius = 10.0
        imageView.clipsToBounds = true
        
        fetchAPOD()
    }
}

extension PlanetViewController {
    func fetchAPOD() {
        RequestManager.shared.fetchAPOD { [weak self] result in
            switch result {
            case .success(let apodResponse):
                DispatchQueue.main.async {
                    self?.titleLabel.text = apodResponse.title
                    self?.explanationLabel.text = apodResponse.explanation
                    self?.copyrightLabel.text = apodResponse.copyright
                    
                    if let imageUrl = URL(string: apodResponse.url) {
                        URLSession.shared.dataTask(with: imageUrl) { data, _, error in
                            if let data = data, let image = UIImage(data: data) {
                                DispatchQueue.main.async {
                                    self?.imageView.image = image
                                }
                            } else if let error = error {
                                print("Error loading image: \(error)")
                            }
                        }.resume()
                    }
                    if let copyright = apodResponse.copyright {
                        self?.copyrightLabel.text = copyright
                    } else {
                        self?.copyrightLabel.text = "Copyright information not received"
                    }
                }
            case .failure(let error):
                print("Error fetching APOD: \(error)")
            }
        }
    }
}
