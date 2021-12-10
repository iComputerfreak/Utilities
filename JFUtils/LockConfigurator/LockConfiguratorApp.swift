//
//  LockConfiguratorApp.swift
//  LockConfigurator
//
//  Created by Jonas Frey on 09.11.21.
//

import SwiftUI

struct LockConfiguratorApp: View {
    
    @State private var lock: Lock = Lock.random()
    
    var body: some View {
        NavigationView {
        GeometryReader { reader in
            VStack(spacing: 5) {
                Spacer()
                // Driver pins
                HStack {
                    ForEach(lock.driverPins) { pin in
                        PinView(pin: pin)
                    }
                }
                .frame(height: reader.size.height / 3)
                // Key pins
                HStack {
                    ForEach(lock.keyPins) { pin in
                        PinView(pin: pin)
                    }
                }
                .frame(height: reader.size.height / 3)
                Button("Randomize") {
                    lock = Lock.random()
                }
                Spacer()
                    .frame(minHeight: reader.size.height / 4)
            }
        }
        .padding(.horizontal, 10)
        .navigationTitle("Lock Configurator")
        }
    }
}

struct LockConfiguratorApp_Previews: PreviewProvider {
    static var previews: some View {
        LockConfiguratorApp()
    }
}
