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
    
    static func createDefault() -> MetaData {
        var metaData = MetaData()
        metaData.title = "Shadows at the Moon's South Pole"
        metaData.description = "Was this image of the Moon's surface taken with a microscope? No -- it's a multi-temporal illumination map made with a wide-angle camera. To create it, the Lunar Reconnaissance Orbiter spacecraft collected 1,700 images over a period of 6 lunar days (6 Earth months), repeatedly covering an area centered on the Moon's south pole from different angles. The resulting images were stacked to produce the featured map -- representing the percentage of time each spot on the surface was illuminated by the Sun. Remaining convincingly in shadow, the floor of the 19-kilometer diameter Shackleton crater is seen near the map's center. The lunar south pole itself is at about 9 o'clock on the crater's rim. Crater floors near the lunar south and north poles can remain in permanent shadow, while mountain tops can remain in nearly continuous sunlight. Useful for future outposts, the shadowed crater floors could offer reservoirs of water-ice, while the sunlit mountain tops offer good locations to collect solar power."
        metaData.date = "2022-10-04"
        return metaData
        
    }
}

