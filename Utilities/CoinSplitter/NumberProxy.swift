//
//  NumberProxy.swift
//  JFUtils
//
//  Created by Jonas Frey on 10.12.21.
//

import Foundation

class NumberProxy: ObservableObject {
    @Published var value = "" {
        didSet {
            let filtered = value.filter(\.isNumber)
            
            if value != filtered {
                value = filtered
            }
        }
    }
}
