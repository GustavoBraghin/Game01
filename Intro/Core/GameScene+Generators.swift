//
//  GameScene+Generators.swift
//  Intro
//
//  Created by Marcos Morais on 31/03/19.
//  Copyright © 2019 Developer Academy UCB. All rights reserved.
//

import SpriteKit

extension GameScene {
    
    // MARK: Utils
    
    func generateBombs(timePerBomb: TimeInterval) {
        
        let createBomb = SKAction.run {
            let xPosition = CGFloat.random(in: 0.0...(self.scene?.size.width)!)
            let yPosition = CGFloat((self.scene?.size.height)!*0.05)
            //print to discover the value of y point on scene
            //print((self.scene?.size.height)!)
            self.createBomb(position: CGPoint(x: xPosition, y: yPosition))
        }
        let waitInBetween = SKAction.wait(forDuration: timePerBomb*(TimeInterval.random(in: 0.55...1.5)))
        
        let sequence = SKAction.sequence([createBomb, waitInBetween])
        
        let repeatForever = SKAction.repeatForever(sequence)
        
        self.run(repeatForever)
        
    }
    /*
    func startWind(range: CGSize) {
        
        let createWindNode = SKAction.run {
            let xPosition = CGFloat(-50.0)
            let yPosition = CGFloat.random(in: 0.0...range.height)
            self.createWind(position: CGPoint(x: xPosition, y: yPosition))
        }
        let waitInBetween = SKAction.wait(forDuration: 0.250, withRange: 5)
        
        let sequence = SKAction.sequence([createWindNode, waitInBetween])
        
        let repeatForever = SKAction.repeatForever(sequence)
        
        self.run(repeatForever)
        
    }*/
}
