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
            TrainTimeApp()
                .tabItem {
                    Image(systemName: "train.side.front.car")
                    Text("TrainTime")
                }
            
            LockConfiguratorApp()
                .tabItem {
                    Image(systemName: "lock.fill")
                    Text("LockConfigurator")
                }
            
            CoinSplitterApp()
                .tabItem {
                    Image(systemName: "circlebadge.2.fill")
                    Text("CoinSplitter")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
