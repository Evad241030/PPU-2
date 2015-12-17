//
//  Calculate.swift
//  PPU2
//
//  Created by DAVID GONZALEZ on 10/30/15.
//  Copyright © 2015 David Gonzalez. All rights reserved.
//

import Foundation

class Calculator {
    func divide(val1: Double, val2: Double) -> Double {
        var result = 0.0
        if val1 > 0 && val2 > 0 {
        result = val1 / val2
        }
        return result
    }
}