//
//  DriverPin.swift
//  LockConfigurator
//
//  Created by Jonas Frey on 09.11.21.
//

import Foundation
import SwiftUI

struct DriverPin: Pin, Identifiable {
    
    let id = UUID()
    
    enum PinType {
        case normal, serrated, spool
    }
    
    let length: CGFloat = 5
    let type: PinType
    let color: Color
    
    static let normal = DriverPin(type: .normal, color: .pinGold)
    static let serrated = DriverPin(type: .serrated, color: .pinGold)
    static let spool = DriverPin(type: .spool, color: .pinGold)
    
    static let all: [DriverPin] = [.normal, .serrated, .spool]
    
    func draw(path: inout Path, size: CGSize) {
        let ratio = min(size.width / diameter, size.height / length)
        func mmToPx(_ mm: CGFloat) -> CGFloat {
            DriverPin.mmToPx(mm, ratio: ratio)
        }
        
        switch type {
        case .normal:
            path.addRect(.init(x: 0, y: 0, width: mmToPx(diameter), height: mmToPx(length)))
        case .serrated:
            // 3.0 mm top part
            // 1.5 mm serration (3 inset parts with double the width as the hole parts)
            // 0.5 mm bottom part
            drawSerratedPin(path: &path, ratio: ratio)
        case .spool:
            // 1.5 mm top part
            // 3.0 mm middle part (1 mm less diameter)
            // 0.5 mm bottom part
            drawSpoolPin(path: &path, ratio: ratio)
        }
        
        // Center the path vertically, if needed
        if size.width / diameter > size.height / length {
            // The padding is the amount of pixels on each side that is not touched by the drawing function
            let padding = (size.width - mmToPx(diameter))
            // Pad on the left
            path = path.applying(.init(translationX: padding / 2, y: 0))
        } else {
            // Align the path at the bottom, so full padding as translation
            let padding = (size.height - mmToPx(length))
            path = path.applying(.init(translationX: 0, y: padding))
        }
        
    }
    
    private func drawSerratedPin(path: inout Path, ratio: CGFloat) {
        func mmToPx(_ mm: CGFloat) -> CGFloat {
            return DriverPin.mmToPx(mm, ratio: ratio)
        }
        let inset: CGFloat = 0.5
        let serrationWidth: CGFloat = 0.3
        // The serrations + separations are 1.5 mm together
        let serrationSeparationWidth: CGFloat = (1.5 - 3 * serrationWidth) / 2
        //assert(abs(3 * serrationWidth + 2 * serrationSeparationWidth - 1.5) < 0.0001)
        path.addLines([
            // Top Part
            .init(x: mmToPx(0), y: mmToPx(3)),
            // Serrations
            .init(x: mmToPx(inset),             y: mmToPx(3)),
            .init(x: mmToPx(inset),             y: mmToPx(3 + serrationWidth)),
            .init(x: mmToPx(0),                 y: mmToPx(3 + serrationWidth)),
            .init(x: mmToPx(0),                 y: mmToPx(3 + serrationWidth + serrationSeparationWidth)),
            .init(x: mmToPx(inset),             y: mmToPx(3 + serrationWidth + serrationSeparationWidth)),
            .init(x: mmToPx(inset),             y: mmToPx(3 + 2*serrationWidth + serrationSeparationWidth)),
            .init(x: mmToPx(0),                 y: mmToPx(3 + 2*serrationWidth + serrationSeparationWidth)),
            .init(x: mmToPx(0),                 y: mmToPx(3 + 2*serrationWidth + 2*serrationSeparationWidth)),
            .init(x: mmToPx(inset),             y: mmToPx(3 + 2*serrationWidth + 2*serrationSeparationWidth)),
            .init(x: mmToPx(inset),             y: mmToPx(3 + 3*serrationWidth + 2*serrationSeparationWidth)),
            .init(x: mmToPx(0),                 y: mmToPx(3 + 3*serrationWidth + 2*serrationSeparationWidth)),
            // Bottom Part
            .init(x: mmToPx(0),                 y: mmToPx(5)),
            .init(x: mmToPx(diameter),          y: mmToPx(5)),
            .init(x: mmToPx(diameter),          y: mmToPx(4.5)),
            // Serrations
            .init(x: mmToPx(diameter - inset),  y: mmToPx(4.5)),
            .init(x: mmToPx(diameter - inset),  y: mmToPx(4.5 - serrationWidth)),
            .init(x: mmToPx(diameter),          y: mmToPx(4.5 - serrationWidth)),
            .init(x: mmToPx(diameter),          y: mmToPx(4.5 - serrationWidth - serrationSeparationWidth)),
            .init(x: mmToPx(diameter - inset),  y: mmToPx(4.5 - serrationWidth - serrationSeparationWidth)),
            .init(x: mmToPx(diameter - inset),  y: mmToPx(4.5 - 2*serrationWidth - serrationSeparationWidth)),
            .init(x: mmToPx(diameter),          y: mmToPx(4.5 - 2*serrationWidth - serrationSeparationWidth)),
            .init(x: mmToPx(diameter),          y: mmToPx(4.5 - 2*serrationWidth - 2*serrationSeparationWidth)),
            .init(x: mmToPx(diameter - inset),  y: mmToPx(4.5 - 2*serrationWidth - 2*serrationSeparationWidth)),
            .init(x: mmToPx(diameter - inset),  y: mmToPx(4.5 - 3*serrationWidth - 2*serrationSeparationWidth)),
            .init(x: mmToPx(diameter),          y: mmToPx(4.5 - 3*serrationWidth - 2*serrationSeparationWidth)),
            // Top Part
            .init(x: mmToPx(diameter),          y: mmToPx(0)),
            .init(x: mmToPx(0),                 y: mmToPx(0)),
        ])
    }
    
    private func drawSpoolPin(path: inout Path, ratio: CGFloat) {
        func mmToPx(_ mm: CGFloat) -> CGFloat {
            DriverPin.mmToPx(mm, ratio: ratio)
        }
        let inset: CGFloat = 0.5
        // Start in the top left and go down the left side first
        path.addLines([
            .init(x: mmToPx(0),                 y: mmToPx(1.5)),
            .init(x: mmToPx(inset),             y: mmToPx(1.5)),
            .init(x: mmToPx(inset),             y: mmToPx(4.5)),
            .init(x: mmToPx(0),                 y: mmToPx(4.5)),
            .init(x: mmToPx(0),                 y: mmToPx(5.0)),
            .init(x: mmToPx(diameter),          y: mmToPx(5)),
            .init(x: mmToPx(diameter),          y: mmToPx(4.5)),
            .init(x: mmToPx(diameter - inset),  y: mmToPx(4.5)),
            .init(x: mmToPx(diameter - inset),  y: mmToPx(1.5)),
            .init(x: mmToPx(diameter),          y: mmToPx(1.5)),
            .init(x: mmToPx(diameter),          y: mmToPx(0)),
            .init(x: mmToPx(0),                 y: mmToPx(0)),
        ])
    }
}
