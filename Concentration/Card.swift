//
//  Card.swift
//  Concentration
//
//  Created by Evg P on 04.04.2018.
//  Copyright © 2018 Evg P. All rights reserved.
//

import Foundation

struct Card {
    
    var isFaceUp = false
    var isMatched = false
    var seenCount = 0
    var identifier: Int
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    //  static method means only use with Type or Class
    
    init (){
        self.identifier = Card.getUniqueIdentifier()
    }
}
