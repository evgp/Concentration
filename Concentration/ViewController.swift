//
//  ViewController.swift
//  Concentration
//
//  Created by Evg P on 19.03.2018.
//  Copyright © 2018 Evg P. All rights reserved.
//

// TODO: Add "New Game" button wich ends current game in progress and begins a brand new game

import UIKit

class ViewController: UIViewController {
    
   private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    // MARK: we can use lazy to announce instanse before it would be created. game will be accessible when instance exist
    
//    var numberOfPairsOfCards: Int {
//        get {
//            return (cardButtons.count + 1) / 2
//        }
//    }

    
    // MARK: Read-only property could be implemented like that, with no get and set
    var numberOfPairsOfCards: Int { //private(set) set this var is private, but not need to modify, because of read-only property
       return (cardButtons.count + 1) / 2
    }
    
    // done ✅: Score Label
    // Tracking the flip count almost certainly does not belong in your Controller in a proper MVC architecture. Fix that.
    private(set) var flipCount = 0 { // don't get people to set flipCount
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    // outlets are always private, because it's always kind of internal implementation
    @IBOutlet private weak var scoreLabel: UILabel!
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    // done ✅: 6 different themes of emoji set. Game should choose a random theme each time a new game starts.
    // Architecture must make it possible to add a new theme in a single line of code
    
    
    private func cardSkin(_ theme: Int) -> [String] {
        let cardSkin = theme
        switch cardSkin {
        case 1:
            return ["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐨","🐯","🦁","🐮"]
        case 2:
            return ["🍏","🍎","🍐","🍊","🍋","🍌","🍉","🍇","🍓","🍈","🍒","🍑"]
        case 3:
            return ["⚽️","🏀","🏈","⚾️","🎾","🏐","🏉","🎱","🏓","🏸","🥅","🏒"]
        case 4:
            return ["🚗","🚕","🚙","🚌","🚎","🏎","🚓","🚑","🚒","🚐","🚚","🚛"]
        case 5:
            return ["⌚️","📱","📲","💻","⌨️","🖥","🖨","🖱","🖲","🕹","🗜","💽"]
        case 6:
            return ["😀","😃","😄","😁","😆","😅","😂","🤣","☺️","😊","😇","🙂"]
        default:
            return ["🎃","👻","🤖","👽","🏆","🎹","🎨","🏋️‍♂️","🏀","😀","😃","😄"]
            
        }
    }
    //    let cardSkin = Int(arc4random_uniform(UInt32(6)))
    
    
    private lazy var emojiChoices = cardSkin(Int(arc4random_uniform(UInt32(6))))
    private var emoji = [Int:String]()
    
    // TODO: sometimes emoji doesn't showed. ? instead
    @IBAction private func newGame(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        emojiChoices = cardSkin(Int(arc4random_uniform(UInt32(6))))
        emoji = [Int:String]()
        updateViewFromModel()
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            //flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
        } else {
            print("no such card in cardButtons")
        }
        
    }
    // MARK: View update after properties changed
    private func updateViewFromModel(){
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
        scoreLabel.text = "Score: \(game.score)"
    }
    
    // the design approach is make everything private and then decide what to make public.
    private func emoji (for card: Card ) -> String {
        //        if emoji[card.identifier] != nil {
        //            return emoji[card.identifier]!
        //        } else {
        //            return "?"
        //        }
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            //let randomIndex = emojiChoices.count.arc4random we use extension of Int now, so
//            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
            emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    //    func flipCard(withEmoji emoji: String, on button: UIButton) {
    //        if button.currentTitle == emoji {
    //            button.setTitle("", for: UIControlState.normal)
    //            button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
    //        } else {
    //            button.setTitle(emoji, for: UIControlState.normal)
    //            button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
    //        }
    //    }
    
}
// let x = 5.arc4random. - extansion for Int, 5 is the "self"
extension Int {
    var arc4random: Int {
        return Int(arc4random_uniform(UInt32(self)))
    }
}
