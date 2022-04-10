//
//  URL_Maker.swift
//  APoD
//
//  Created by Ronny Valtonen on 4/10/22.
//

// Not my code
import Foundation

// https://stackoverflow.com/questions/39594265/how-to-build-a-url-by-using-dictionary-in-swift
// Adds query parameters
extension URL {
    func withQuery(_ query: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = query.map { URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
}
