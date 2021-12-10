//
//  CoinSplitterApp.swift
//  CoinSplitter
//
//  Created by Jonas Frey on 23.10.21.
//

import SwiftUI
import Combine

struct CoinSplitterApp: View {
    
    @State private var cp: Int = 0
    @State private var sp: Int = 0
    @State private var ep: Int = 0
    @State private var gp: Int = 0
    @State private var pp: Int = 0
    @State private var partySize: Int = 5
    
    private var result: String {
        let totalCopper = pp * 1000 + gp * 100 + ep * 50 + sp * 10 + cp
        // Divide by party size
        let copperPerParty = totalCopper / partySize
        // There could be some rest
        let rest = totalCopper % partySize
        let coins = Coins(from: copperPerParty)
        
        var r = "Each party member gains \(coins.asDefaultCoins)."
        if rest != 0 {
            r += "\nThere \(rest == 1 ? "is" : "are") \(rest) cp left."
        }
        return r
    }
    
    @State private var test: Int = 0
    
    var body: some View {
        NavigationView {
            Form {
                NumberField(name: "Copper", abbreviation: "cp", amount: $cp)
                    .padding(.vertical, 5)
                NumberField(name: "Silver", abbreviation: "sp", amount: $sp)
                    .padding(.vertical, 5)
                NumberField(name: "Electrum", abbreviation: "ep", amount: $ep)
                    .padding(.vertical, 5)
                NumberField(name: "Gold", abbreviation: "gp", amount: $gp)
                    .padding(.vertical, 5)
                NumberField(name: "Platinum", abbreviation: "pp", amount: $pp)
                    .padding(.vertical, 5)
                NumberField(name: "Party Size", abbreviation: "", amount: $partySize)
                    .padding(.vertical, 5)
                
                Section {
                    Text(result)
                        .font(.headline)
                        .padding(.vertical)
                }
            }
            .navigationTitle("Coin Splitter")
        }
    }
}

struct CoinSplitterApp_Previews: PreviewProvider {
    static var previews: some View {
        CoinSplitterApp()
    }
}
