//
//  CoinSplitterApp.swift
//  CoinSplitter
//
//  Created by Jonas Frey on 23.10.21.
//

import SwiftUI
import Combine

struct CoinSplitterApp: View {
    
    enum FocusableField: Hashable {
        case copper
        case silver
        case electrum
        case gold
        case platinum
        case partySize
    }
    
    @State private var cp: Int = 0
    @State private var sp: Int = 0
    @State private var ep: Int = 0
    @State private var gp: Int = 0
    @State private var pp: Int = 0
    @State private var partySize: Int = 5
    
    @FocusState private var focusedField: FocusableField?
    
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
        
    var body: some View {
        NavigationView {
            Form {
                NumberField(name: "Copper", abbreviation: "cp", amount: $cp)
                    .focused($focusedField, equals: .copper)
                    .padding(.vertical, 5)
                NumberField(name: "Silver", abbreviation: "sp", amount: $sp)
                    .focused($focusedField, equals: .silver)
                    .padding(.vertical, 5)
                NumberField(name: "Electrum", abbreviation: "ep", amount: $ep)
                    .focused($focusedField, equals: .electrum)
                    .padding(.vertical, 5)
                NumberField(name: "Gold", abbreviation: "gp", amount: $gp)
                    .focused($focusedField, equals: .gold)
                    .padding(.vertical, 5)
                NumberField(name: "Platinum", abbreviation: "pp", amount: $pp)
                    .focused($focusedField, equals: .platinum)
                    .padding(.vertical, 5)
                NumberField(name: "Party Size", abbreviation: "", amount: $partySize)
                    .focused($focusedField, equals: .partySize)
                    .padding(.vertical, 5)
                
                Section {
                    Text(result)
                        .font(.headline)
                        .padding(.vertical)
                }
            }
            .navigationTitle("Coin Splitter")
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    HStack {
                        Spacer()
                        Button(action: {
                            focusedField = nil
                        }, label: {
                            Text("Done").bold()
                        })
                    }
                }
            }
        }
    }
}

struct CoinSplitterApp_Previews: PreviewProvider {
    static var previews: some View {
        CoinSplitterApp()
    }
}
