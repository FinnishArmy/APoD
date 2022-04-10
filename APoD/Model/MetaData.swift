//
//  MetaData.swift
//  APoD
//
//  Created by Ronny Valtonen on 4/10/22.
//

import Foundation

// Reflect all of the data in the JSON file
struct MetaData: Codable { // Use codable protcol to convert data types
    var title: String
    var description: String
    var url: URL?
    var copyright: String? // Optional, sometimes gives a copyright
    var date: String
    
    // Must define coding keys
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case description = "explanation"
        case url = "url"
        case copyright = "copyright"
        case date = "date"
    }
    
    // Make an initalizer to utilize properties
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self) // Use this type
        self.title = try valueContainer.decode(String.self, forKey: CodingKeys.title)
        self.description = try valueContainer.decode(String.self, forKey: CodingKeys.description)
        self.url = try valueContainer.decode(URL.self, forKey: CodingKeys.url)
        // We may not have a copyright
        self.copyright = try? valueContainer.decode(String.self, forKey: CodingKeys.copyright)
        self.date = try valueContainer.decode(String.self, forKey: CodingKeys.date)
    }
    
    init() {
        self.description = ""
        self.title = ""
        self.date = ""
    }
}

