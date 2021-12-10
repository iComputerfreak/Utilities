//
//  KeyPin.swift
//  LockConfigurator
//
//  Created by Jonas Frey on 09.11.21.
//

import Foundation
import SwiftUI

struct KeyPin: Pin, Identifiable {
    
    let id = UUID()
    
    let tipLength: CGFloat = 1
    let totalLength: CGFloat
    let color: Color
    
    var length: CGFloat { totalLength - tipLength }
    
    // 7 pins each
    static let purple = KeyPin(totalLength: 7, color: .pinPurple)
    static let red = KeyPin(totalLength: 6.5, color: .pinRed)
    static let silver = KeyPin(totalLength: 6, color: .pinSilver)
    static let gold = KeyPin(totalLength: 5.5, color: .pinGold)
    static let green = KeyPin(totalLength: 5, color: .pinGreen)
    
    static let all = [.purple, .red, silver, .gold, .green]
    
    func draw(path: inout Path, size: CGSize) {
        func mmToPx(_ mm: CGFloat) -> CGFloat {
            let ratio = min(size.width / diameter, size.height / totalLength)
            return KeyPin.mmToPx(mm, ratio: ratio)
        }
        
        path.addLines([
            .init(x: mmToPx(0), y: mmToPx(length)),
            .init(x: mmToPx(diameter/2), y: mmToPx(totalLength)),
            .init(x: mmToPx(diameter), y: mmToPx(length)),
            .init(x: mmToPx(diameter), y: mmToPx(0)),
            .init(x: mmToPx(0), y: mmToPx(0)),
        ])
    }
}
