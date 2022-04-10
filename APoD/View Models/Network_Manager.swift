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
    
    @Published var metaData = MetaData()
    @Published var image: UIImage? = nil
    
    // https://stackoverflow.com/questions/59002502/ios-swift-combine-cancel-a-setanycancellable
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        // Fetch APOD data request
        let URL = URL(string: Constants.baseURL)!
        // Add on the API key
        let finalURL = URL.withQuery(["api_key": Constants.key])!
        // The full working URL
        print(finalURL.absoluteString)

        // Create URL session
        URLSession.shared.dataTaskPublisher(for: finalURL)
            .map(\.data)
            .decode(type: MetaData.self, decoder: JSONDecoder())
            .catch { (erro) in
                Just(MetaData())
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
}
