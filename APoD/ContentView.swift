//
//  ContentView.swift
//  APoD
//
//  Created by Ronny Valtonen on 4/10/22.
//

import SwiftUI

struct ContentView: View {
    // Main body view
    var body: some View {
        APoD_Today_View() // Call the view manager
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
