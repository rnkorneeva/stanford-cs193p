//
//  Concentration.swift
//  Concentration
//
//  Created by Irina Korneeva on 07/07/2018.
//  Copyright © 2018 Irina. All rights reserved.
//

import Foundation

class Concentration {
    private(set) var cards = [Card]()
    
    private(set) var currentTheme : Int
    private var numberOfThemes : Int
    
    private var indexOfOneAndOnlyFaceUpCard: Int?
    
    private(set) var scoreCount = 0
    private(set) var flipCount = 0
    
    func chooseCard(at index: Int) {
        flipCount += 1
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, index != matchIndex {
                if (cards[matchIndex] == cards[index])  {
                    cards[index].isMatched = true
                    cards[matchIndex].isMatched = true
                    scoreCount += 2
                } else {
                    scoreCount -= 2
                }
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFacedUp = false
                }
                indexOfOneAndOnlyFaceUpCard = index
            }
            cards[index].isFacedUp = true
        }
    }
    
    func resetAction() {
        flipCount = 0
        scoreCount = 0
        for index in cards.indices {
            cards[index].isMatched = false
            cards[index].isFacedUp = false
        }
        currentTheme = Int(arc4random_uniform(UInt32(numberOfThemes)))
        shuffleTheCards()
    }
    
    init(numberOfPairsOfcards: Int, numberOfThemes: Int) {
        for _ in 1...numberOfPairsOfcards {
            let card = Card()
            cards += [card, card]
        }
        self.numberOfThemes = numberOfThemes
        currentTheme = Int(arc4random_uniform(UInt32(numberOfThemes)))
        shuffleTheCards()
    }
    
    private func shuffleTheCards() {
        for index in cards.indices {
            let newIndex = Int(arc4random_uniform(UInt32(cards.count)))
            (cards[index], cards[newIndex]) = (cards[newIndex], cards[index])
        }
    }    
    
}
