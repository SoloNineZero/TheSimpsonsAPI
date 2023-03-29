//
//  MainViewController.swift
//  TheSimpsonsAPI
//
//  Created by Игорь Солодянкин on 27.03.2023.
//

import UIKit
import Alamofire

final class MainViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var photoImage: UIImageView!
    @IBOutlet var quoteCloudImage: UIImageView!
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    @IBOutlet var quoteLabel: UILabel!
    @IBOutlet var characterLabel: UILabel!
    
    
    // MARK: - Private properties
    private var quotes: [Quotes] = []
    private var showImage = true
    private let networkManger = NetworkManager.shared
    
    // MARK: - Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        quoteCloudImage.isHidden = false
        photoImage.isHidden = false
        quoteLabel.isHidden = false
        characterLabel.isHidden = false
        quoteCloudImage.isHidden = false
        
        showUI()
        fetchQuote()
        
        title = "The Simpsons quote"
    }
    
    //MARK: - IBActions
    @IBAction func nextQuoteButton() {
        activityIndicator.startAnimating()
        showUI()
        fetchQuote()
    }
    
    // MARK: - Private functions
    private func fetchQuote() {
        networkManger.fetchQuote(from: "\(Link.apiSimpsonsUrl.url)") { [weak self] result in
            switch result {
            case .success(let quotes):
                self?.quotes = quotes
                self?.configure()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func configure() {
        quotes.forEach { quote in
            quoteLabel.text = "'\(quote.quote)'"
            characterLabel.text = "(\(quote.character))"
            networkManger.fetchImage(from: quote.image) { [weak self] result in
                switch result {
                case .success(let imageData):
                    self?.photoImage.image = UIImage(data: imageData)
                case .failure(let error):
                    print(error)
                }
            }
            activityIndicator.stopAnimating()
            showUI()
        }
    }
    
    private func showUI() {
        photoImage.isHidden.toggle()
        quoteLabel.isHidden.toggle()
        characterLabel.isHidden.toggle()
        quoteCloudImage.isHidden.toggle()
    }
}

