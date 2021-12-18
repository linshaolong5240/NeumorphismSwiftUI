//
//  ContentView.swift
//  Shared
//
//  Created by 林少龙 on 2021/12/18.
//

import SwiftUI
import NeumorphismSwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                NEUBackgroundView()
                ScrollView {
                    NavigationLink(destination: EmptyView()) {
                        Text("Hello, world!")
                            .padding()
                            .background(NEUListRowBackgroundView(isHighlighted: true))
                    }
                }
            }
            .navigationBarTitle("NeumorphismSwiftUI")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
