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
    @State private var switchDate: Bool = false
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(alignment: .center, spacing: 20) {
                Button(action: {
                    self.switchDate.toggle()
                }) {
                    Image(systemName: "calendar")
                    Text("Change Day")
                }
                .padding(.trailing)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .popover(isPresented: $switchDate) {
                    SelectDateView(manager: self.manager)
                }
                
                if manager.image != nil {
                    Image(uiImage: self.manager.image!)
                        .resizable()
                        .scaledToFit()
                }
                ScrollView {
                    VStack(alignment: .center, spacing: 20) {
                        Text(manager.metaData.date).font(.title).foregroundColor(.white)
                        Text(manager.metaData.title).font(.headline).foregroundColor(.white)
                        Text(manager.metaData.description).foregroundColor(.white)
                    }
                }.padding()
            }
        }
    }
}

// Dummy data
struct APoD_Today_View_Previews: PreviewProvider {
    static var previews: some View {
        let view = APoD_Today_View()
        view.manager.metaData = MetaData.createDefault()
        view.manager.image = UIImage(named: "preview")
        
        return view
    }
}
