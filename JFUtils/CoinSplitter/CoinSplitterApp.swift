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
    
    var body: some View {
        VStack {
            Text("Coin Splitter")
                .font(.largeTitle)
                .bold()
                .padding(.top)
            ScrollView {
                VStack(alignment: .leading) {
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
                    
                    Text(result)
                        .font(.headline)
                        .padding(.vertical)
                    
                    Spacer()
                }
            }
            .padding(.horizontal)
        }
    }
}

struct NumberField: View {
    
    let numberFormatter: NumberFormatter = {
        let f = NumberFormatter()
        return f
    }()
    
    let name: String
    let abbreviation: String
    @Binding var amount: Int
    @State private var text: String
    @State private var publisher: AnyCancellable?
    
    init(name: String, abbreviation: String, amount: Binding<Int>) {
        self.name = name
        self.abbreviation = abbreviation
        self._amount = amount
        self._text = State(initialValue: amount.wrappedValue == 0 ? "" : "\(amount.wrappedValue)")
    }
    
    var body: some View {
        HStack {
            Text("\(name):")
                .font(.title)
            Spacer()
            TextField(abbreviation, text: $text, onEditingChanged: { (startedEditing: Bool) in
                print("Editing \(text)")
                
            })
                .font(.title)
                .keyboardType(.numberPad)
                .frame(maxWidth: 100)
                .multilineTextAlignment(.trailing)
                .background(
                    Color.init(white: 0.9)
                        .cornerRadius(5)
                )
            .onChange(of: text, perform: { value in
                // Write the amount as int
                self.amount = Int(truncating: numberFormatter.number(from: text) ?? 0)
            })
            Text("\(abbreviation)")
                .font(.title)
        }
    }
    
}

struct CoinSplitterApp_Previews: PreviewProvider {
    static var previews: some View {
        CoinSplitterApp()
    }
}
