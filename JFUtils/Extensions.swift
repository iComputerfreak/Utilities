//
//  Extensions.swift
//  JFUtils
//
//  Created by Jonas Frey on 10.12.21.
//

import Foundation

extension Array {
    func randomElements(_ k: Int) -> Self {
        var elements: Self = []
        for _ in 0..<k {
            if let element = self.randomElement() {
                elements.append(element)
            }
        }
        return elements
    }
}
