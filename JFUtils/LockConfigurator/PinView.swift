//
//  PinView.swift
//  LockConfigurator
//
//  Created by Jonas Frey on 09.11.21.
//

import Foundation
import SwiftUI

struct PinView: View {
    
    let pin: Pin
    
    var body: some View {
        GeometryReader { reader in
            Path { path in
                pin.draw(path: &path, size: reader.size)
            }
            .fill(pin.color)
        }
    }
    
}

struct PinView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HStack {
                PinView(pin: DriverPin.normal)
                PinView(pin: DriverPin.serrated)
                PinView(pin: DriverPin.spool)
            }
            HStack {
                PinView(pin: KeyPin.green)
                PinView(pin: KeyPin.silver)
                PinView(pin: KeyPin.purple)
            }
        }
        .padding()
    }
}
