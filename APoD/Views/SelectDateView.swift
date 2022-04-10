//
//  Date_Selector_View.swift
//  APoD
//
//  Created by Ronny Valtonen on 4/10/22.
//

import SwiftUI

struct SelectDateView: View {
    @State private var date = Date()
    @ObservedObject var manager: network_manager
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        ZStack {
            Color.gray.ignoresSafeArea()
            VStack {
                Text("Select the date").font(.headline).foregroundColor(.white)
                DatePicker(selection: $date, in: ...Date(), displayedComponents: .date) {
                    Text("Select")
                }.labelsHidden()
                
                Button(action: {
                    self.manager.date = self.date
                    self.presentation.wrappedValue.dismiss()
                }) {
                    Text("Select").foregroundColor(.white)
                }
            }
        }
    }
}

struct SelectDateView_Previews: PreviewProvider {
    static var previews: some View {
        SelectDateView(manager: network_manager())
    }
}
