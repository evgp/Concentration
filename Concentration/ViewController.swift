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
    
    lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    // MARK: we can use lazy to announce instanse before it would be created. game will be accessible when instance exist
    
    var numberOfPairsOfCards: Int {
        get {
            return (cardButtons.count + 1) / 2
        }
    }
    
    
    // TODO: Score Label
    // Tracking the flip count almost certainly does not belong in your Controller in a proper MVC architecture. Fix that.
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    // done ✅: 6 different themes of emoji set. Game should choose a random theme each time a new game starts.
    // Architecture must make it possible to add a new theme in a single line of code
    
    
    func cardSkin(_ theme: Int) -> [String] {
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
    
    
    lazy var emojiChoices = cardSkin(Int(arc4random_uniform(UInt32(6))))
    var emoji = [Int:String]()
    
    @IBAction func newGame(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        updateViewFromModel()
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
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
    func updateViewFromModel(){
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
    }
    
    
    func emoji (for card: Card ) -> String {
        //        if emoji[card.identifier] != nil {
        //            return emoji[card.identifier]!
        //        } else {
        //            return "?"
        //        }
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
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

