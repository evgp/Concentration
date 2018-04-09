//
//  Concentration.swift
//  Concentration
//
//  Created by Evg P on 04.04.2018.
//  Copyright © 2018 Evg P. All rights reserved.
//
//  This is the Model. TOTALLY UI INDEPENDED
//  no import UIKit here

import Foundation

class Concentration {
    
    var cards = [Card]()
    
    // MARK: example of computed property
    // BTW all vars are properties
    var indexOfOneAndOnlyFaceUpCard: Int? {
        // inside {} we're going to implement our computed property
        
    }
    
    func chooseCard(at index: Int) {
//        if cards[index].isFaceUp {
//            cards[index].isFaceUp = false
//        } else {
//            cards[index].isFaceUp = true
//        }
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                // either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init (numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
            
            // TODO:  Shuffle the cards
        }
    }
}
