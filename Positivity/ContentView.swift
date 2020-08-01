//
//  ContentView.swift
//  Positivity
//
//  Created by Giannis Chatziveroglou on 6/28/20.
//  Copyright © 2020 Giannis Chatziveroglou. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 1
 
    var body: some View {
        TabView(selection: $selection){
            MyProfile()
                .tabItem {
                    VStack {
                        Image(systemName: "person")
                        Text("Profile")
                            .font(.system(size: 60))
                    }
                }
                .tag(0)
             MainView()
                .tabItem {
                    VStack {
                        Image(systemName: "heart.fill")
                        Text("Main")
                    }
                }
                .tag(1)
            Settings()
                .tabItem {
                    VStack {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
                }
                .tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice(PreviewDevice(rawValue: "iPhone XS Max"))
    }
}
