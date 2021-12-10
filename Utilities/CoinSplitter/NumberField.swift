//
//  NumberField.swift
//  JFUtils
//
//  Created by Jonas Frey on 10.12.21.
//

import Foundation
import SwiftUI
import Combine

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
