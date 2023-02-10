//
//  ContentView.swift
//  FireMap
//
//  Created by KimWooJin on 2023/02/09.
//

import SwiftUI

struct ContentView: View {
    var model = CityFireModel()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            Button("Click") {model.cityFireRequest()}
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
