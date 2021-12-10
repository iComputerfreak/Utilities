//
//  Pin.swift
//  LockConfigurator
//
//  Created by Jonas Frey on 09.11.21.
//

import Foundation
import SwiftUI

protocol Pin {
    
    var id: UUID { get }
    
    var diameter: CGFloat { get }
    var color: Color { get }
    
    func draw(path: inout Path, size: CGSize)
    
    static func mmToPx(_ mm: CGFloat, ratio: CGFloat) -> CGFloat
}

extension Pin {
    
    var diameter: CGFloat { 3.0 }
    
    static func mmToPx(_ mm: CGFloat, ratio: CGFloat) -> CGFloat {
        return mm * ratio
    }
}

extension Color {
    static let pinGold = Color(.displayP3, red: 223/255.0, green: 190/255.0, blue: 122/255.0, opacity: 1.0)
    static let pinGreen = Color(.displayP3, red: 142/255.0, green: 186/255.0, blue: 142/255.0, opacity: 1.0)
    static let pinPurple = Color(.displayP3, red: 100/255.0, green: 50/255.0, blue: 63/255.0, opacity: 1.0)
    static let pinSilver = Color(.displayP3, red: 232/255.0, green: 223/255.0, blue: 214/255.0, opacity: 1.0)
    static let pinRed = Color(.displayP3, red: 203/255.0, green: 96/255.0, blue: 85/255.0, opacity: 1.0)
}

func mmToPx(_ mm: CGFloat, ratio: CGFloat) -> CGFloat {
    return mm * ratio
}
