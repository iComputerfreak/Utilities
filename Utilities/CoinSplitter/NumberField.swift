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
    
    let name: String
    let abbreviation: String
    @Binding var amount: Int
    
    var body: some View {
        HStack {
            Text(name)
                .font(.title)
            Spacer()
            TextField(name, value: $amount, format: .number , prompt: Text(abbreviation))
                .multilineTextAlignment(.trailing)
                .font(.title)
                .keyboardType(.numberPad)
            HStack {
                Text(abbreviation)
                    .font(.title)
                Spacer()
            }
                .frame(width: 40)
        }
    }
}

struct NumberField_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            NumberField(name: "Copper", abbreviation: "cp", amount: .constant(10))
            NumberField(name: "Copper", abbreviation: "cp", amount: .constant(-1))
            NumberField(name: "Copper", abbreviation: "cp", amount: .constant(0))
        }
        .previewLayout(.sizeThatFits)
    }
}
