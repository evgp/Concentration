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

struct Concentration {

    private(set) var cards = [Card]() //you can look for card, but i am responsable for setting it faceUp and matched
    var score = 0
    //    var flipCount = 0
    
    // MARK: example of computed property
    // BTW all vars are properties
    
    // done ✅: Computed indexOfOneAndOnlyFaceUpCard
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        //{
        //        // inside {} we're going to implement our computed property
        //
        //    }
        //    var indexOfScoringCard: Int?
        get {
            var foundIndex: Int? // [= nil] default value
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index  // if this is first opened card
                    } else {
                        return nil          // if this is second opened card
                    }
                }
            }
            return foundIndex
        }
        // newValue - this is just local varible inside here that contains new value that someone set to indexOfOneAndOnlyFaceUpCard. Default to "newValue"
        //        set(newValue) { the name is totally up to you
        // if it does a lot of work make it a func
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue) // if index == newValue this is the one card FaceUp and return true, otherwise - false.
            }
        }
    }
    //if property is settable, swift knows it's mutating already, else, if gettable only, it needs to set mutating modifier
    
    
    // done ✅: Make shuffle func for known shuffle algorithms
    private func shuffleCards(_ cards: [Card]) -> [Card] {
        var shuffledCards = [Card]()
        var cards = cards
        while cards.count != 0 {
//            let randomIndex = Int(arc4random_uniform(UInt32(cards.count)))
            let randomIndex = cards.count.arc4random
            shuffledCards.append(cards[randomIndex])
            cards.remove(at: randomIndex)
        }
        return shuffledCards
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard at \(index): choosen index not in the cards ") //assertation func have to be true, if not - program crashes with assertation message
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //check if cards are matched
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                    cards[index].seenCount = -1
                    cards[matchIndex].seenCount = 0
                }
                cards[index].isFaceUp = true
                //                indexOfOneAndOnlyFaceUpCard = nil             ---not need, because property is computed
            } else {
                // either no cards or 2 cards are face up
                //                for flipDownIndex in cards.indices {          ---not need, because property is computed
                //                    cards[flipDownIndex].isFaceUp = false
                //                }
                //                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
            cards[index].seenCount += 1
            if cards[index].seenCount > 2 {
                score -= 3
                cards[index].seenCount = -1
            }
        }
    }
    
    init (numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init at \(numberOfPairsOfCards): choosen number not > 0 ")
        // MARK: making things private and using assert you can provide a proper use of the code
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
            // done ✅:  Shuffle the cards
        }
        cards = shuffleCards(cards)
    }
}
