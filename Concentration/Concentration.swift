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
    var score = 0
//    var flipCount = 0
    
    // MARK: example of computed property
    // BTW all vars are properties
    
    // TODO: Computed indexOfOneAndOnlyFaceUpCard
    var indexOfOneAndOnlyFaceUpCard: Int?
    //{
    //        // inside {} we're going to implement our computed property
    //
    //    }
//    var indexOfScoringCard: Int?
    // done ✅: Make shuffle func for known shuffle algorithms
    func shuffleCards(_ cards: [Card]) -> [Card] {
        var shuffledCards = [Card]()
        var cards = cards
        while cards.count != 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(cards.count)))
            shuffledCards.append(cards[randomIndex])
            cards.remove(at: randomIndex)
        }
        return shuffledCards
    }
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //check if cards are matched
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                    cards[index].seenCount = -1
                    cards[matchIndex].seenCount = 0
                } else {
                    if cards[index].seenCount >= 2 {
                        score -= 3
                        cards[index].seenCount = -1
                    }
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
            cards[index].seenCount += 1
        }
    }
    
    init (numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
            // done ✅:  Shuffle the cards
        }
        cards = shuffleCards(cards)
    }
}
