//
//  APoD_Today_View.swift
//  APoD
//
//  Created by Ronny Valtonen on 4/10/22.
//

import SwiftUI

struct APoD_Today_View: View {
    // Use network manager
    @ObservedObject var manager = network_manager()
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct APoD_Today_View_Previews: PreviewProvider {
    static var previews: some View {
        APoD_Today_View()
    }
}
