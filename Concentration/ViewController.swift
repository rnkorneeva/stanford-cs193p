//
//  ViewController.swift
//  Concentration
//
//  Created by Irina Korneeva on 26/05/2018.
//  Copyright © 2018 Irina. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private lazy var game = Concentration(numberOfPairsOfcards: cardButtons.count/2, numberOfThemes: emojiChoicesDict.count)
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private weak var scoreLabel: UILabel!
    
    @IBAction private func resetButton(_ sender: Any) {
        game.resetAction()
        updateViewFromModel()
        emoji.removeAll()
        emojiChoices = emojiChoicesDict[game.currentTheme]!
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    private func updateViewFromModel() {
        scoreLabel.text = "Score: \(game.scoreCount)"
        flipCountLabel.text = "Flips: \(game.flipCount)"
        
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFacedUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = .white
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? .clear : .orange
            }
        }
    }
    
    private var emojiChoicesDict = [0: ["👻", "🎃", "💄", "🤡", "👿", "🙀", "🍭", "🦄", "🍷"],
                                    1: ["😅", "😀", "😇", "😍", "😜", "😎", "😘", "😡", "😴"]]
    
    private lazy var emojiChoices = emojiChoicesDict[game.currentTheme]!
    
    private var emoji = [Card: String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card] ?? "?"
    }
    
}

