//
//  Player.swift
//  Intro
//
//  Created by Gustavo da Silva Braghin on 10/08/21.
//  Copyright © 2021 Developer Academy UCB. All rights reserved.
//

import SpriteKit

class Player: SKSpriteNode {
    
    var isAlive: Bool
    
    init(spriteName: String, position: CGPoint) {
        let playerSize = SKTexture(imageNamed: spriteName)
        isAlive = false
        
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
        self.physicsBody?.isDynamic = false
    }
}
