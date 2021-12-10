//
//  Lock.swift
//  LockConfigurator
//
//  Created by Jonas Frey on 09.11.21.
//

import Foundation
import JFUtils

struct Lock {
    
    static let pinCount = 5
    let driverPins: [DriverPin]
    let keyPins: [KeyPin]
    
    static func random() -> Lock {
        // Give normal driver pins a higher chance
        let driverDistribution = DriverPin.all + [DriverPin.normal]
        return Lock(driverPins: driverDistribution.randomElements(pinCount), keyPins: KeyPin.all.randomElements(pinCount))
    }
    
}
