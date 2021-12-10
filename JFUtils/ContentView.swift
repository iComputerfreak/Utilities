//
//  ContentView.swift
//  JFUtils
//
//  Created by Jonas Frey on 10.12.21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            TrainTimeView()
                .tabItem {
                    Image(systemName: "train.side.front.car")
                    Text("TrainTime")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
