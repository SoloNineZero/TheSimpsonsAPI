//
//  Quote.swift
//  TheSimpsonsAPI
//
//  Created by Игорь Солодянкин on 27.03.2023.
//

import Foundation

struct Quotes {
    let quote: String
    let character: String
    let image: String
    
    init(quoteData: [String: Any]) {
        quote = quoteData["quote"] as? String ?? ""
        character = quoteData["character"] as? String ?? ""
        image = quoteData["image"] as? String ?? ""
    }
    
    static func getQuote(from value: Any) -> [Quotes] {
        guard let quotesData = value as? [[String:Any]] else { return [] }
        return quotesData.map { Quotes(quoteData: $0) }
    }
}

