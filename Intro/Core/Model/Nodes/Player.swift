//
//  Player.swift
//  Intro
//
//  Created by Gustavo da Silva Braghin on 10/08/21.
//  Copyright © 2021 Developer Academy UCB. All rights reserved.
//

import SpriteKit

class Player: SKSpriteNode {
    
    var isAlive: Int
    var isBliking: Bool
    
    init(spriteName: String, position: CGPoint) {
        let playerSize = SKTexture(imageNamed: spriteName)
        isAlive = 0
        isBliking = false
        
        super.init(texture: playerSize, color: .clear, size: playerSize.size())
        
        createPlayer(position: position)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createPlayer(position: CGPoint){

        //self.player = SKSpriteNode(imageNamed: "Astronaut1")
        self.name = "player"
        self.position = position
        self.zPosition = 1
        self.setScale(0.7)
        self.setupDefaultPhysicsBody()
        //this makes the player stop in the walls
        self.physicsBody?.isDynamic = true
    }
    
    func blink() {
        let invisible = SKAction.fadeOut(withDuration: 0.25)
        let visible = SKAction.fadeIn(withDuration: 0.25)
        let wait = SKAction.wait(forDuration: 0.2)
        let setBliking = SKAction.run({
            self.isBliking = true
        })
        let setNotBliking = SKAction.run({
            self.isBliking = false
        })
        
        let seq = SKAction.sequence([invisible, wait, visible])
        let rep = SKAction.repeat(seq, count: 3)
        let sequence = SKAction.sequence([setBliking, rep, setNotBliking])
        self.run(sequence)
    }
}
