//
//  APODResponse.swift
//  YourUniverse
//
//  Created by Вероника Карпова on 10.10.2023.
//

import Foundation

struct APODResponse: Decodable {
    let url: String
    let title: String
    let explanation: String
    let copyright: String?
    
    enum CodingKeys: String, CodingKey {
        case url
        case title
        case explanation
        case copyright
    }
}
