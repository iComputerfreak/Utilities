//
//  Coins.swift
//  JFUtils
//
//  Created by Jonas Frey on 10.12.21.
//

import Foundation

struct Coins: CustomStringConvertible {
    
    var cp = 0
    var sp = 0
    var ep = 0
    var gp = 0
    var pp = 0
    
    var asDefaultCoins: Coins {
        // Convert electrum and platinum
        Coins(cp: cp, sp: sp + ep * 5, ep: 0, gp: gp + pp * 10, pp: 0)
    }
    
    var description: String {
        let values = [(pp, "pp"), (gp, "gp"), (ep, "ep"), (sp, "sp"), (cp, "cp")]
            .filter({ $0.0 != 0 })
        
        func coinString(_ tuple: (Int, String)) -> String {
            coinString(tuple.0, tuple.1)
        }
        
        func coinString(_ amount: Int, _ abbrev: String) -> String {
            "\(amount) \(abbrev)"
        }
        
        guard !values.isEmpty else {
            return coinString(0, "cp")
        }
        if values.count == 1 {
            return coinString(values.first!)
        }
        // If there are at least 2 coin sizes, we do a list
        return values.dropLast().map(coinString).joined(separator: ", ") + " and " + coinString(values.last!)
    }
    
    init(cp: Int = 0, sp: Int = 0, ep: Int = 0, gp: Int = 0, pp: Int = 0) {
        self.pp = pp
        self.gp = gp
        self.ep = ep
        self.sp = sp
        self.cp = cp
    }
    
    init(from cp: Int) {
        var copper = cp
        self.pp = copper / 1000
        copper %= 1000
        self.gp = copper / 100
        copper %= 100
        self.ep = copper / 50
        copper %= 50
        self.sp = copper / 10
        copper %= 10
        self.cp = copper
    }
}
