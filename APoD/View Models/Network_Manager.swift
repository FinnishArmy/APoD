//
//  Network_Manager.swift
//  APoD
//
//  Created by Ronny Valtonen on 4/10/22.
//

import Foundation
import Combine
import UIKit
import SwiftUI


// Creating an network manager which is an observable object so we can use it in UI views
class network_manager: ObservableObject {
    @Published var date: Date = Date() // Make UI to change the date
    @Published var metaData = MetaData()
    @Published var image: UIImage? = nil
    
    
    // https://stackoverflow.com/questions/59002502/ios-swift-combine-cancel-a-setanycancellable
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        // The full working URL
        let url = URL(string: Constants.baseURL)!
        let finalURL = url.withQuery(["api_key": Constants.key])!
        print(finalURL.absoluteString)
        $date.removeDuplicates()
            .sink { (value) in
                self.image = nil
            }.store(in: &subscriptions)
        
        $date.removeDuplicates()
            .map {
                self.createURL(for: $0)
            }.flatMap { (url) in
                URLSession.shared.dataTaskPublisher(for: finalURL)
                    .map(\.data)
                    .decode(type: MetaData.self, decoder: JSONDecoder())
                    .catch { (error) in
                        Just(MetaData())
                    }
            }
            .receive(on: RunLoop.main)
            .assign(to: \.metaData, on: self)
            .store(in: &subscriptions)
            // Fetch image only if we have an updated metadata
        $metaData
            .filter { $0.url != nil }
            .map { metaData -> URL in
                return metaData.url!
            }.flatMap { (url) in
                URLSession.shared.dataTaskPublisher(for: url)
                    .map(\.data)
                    .catch({error in
                        return Just(Data())
                    })
            }.map { (out) -> UIImage? in
                UIImage(data: out)
            }
            .receive(on: RunLoop.main)
            .assign(to: \.image, on: self)
            .store(in: &subscriptions)
            // Handle return values
//            .sink(receiveCompletion: { (completion) in
//                // Completion handeler
//                switch completion {
//                case .finished:
//                    print("Fetch successfull")
//                case .failure(let failure):
//                    print("Fetch failed: \(failure.localizedDescription)")
//                }
//            // JSON data
//            }) { (data, response) in
//                if let description = String(data: data, encoding: .utf8) {
//                    print("Fethced data \(description)")
//                }
//            }.store(in: &subscriptions)
    }
    func createURL(for date: Date) -> URL {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let date = format.string(from: date)
        
        // Fetch APOD data request
        let URL = URL(string: Constants.baseURL)!
        // Add on the API key
        let finalURL = URL.withQuery(["api_key": Constants.key, "date": date])!
        return finalURL
    }
}
