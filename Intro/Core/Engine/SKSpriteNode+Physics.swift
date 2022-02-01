//
//  SKSpriteNode+Physics.swift
//  Intro
//
//  Created by Marcos Morais on 31/03/19.
//  Copyright © 2019 Developer Academy UCB. All rights reserved.
//

import SpriteKit

extension SKSpriteNode {
    
    func setupDefaultPhysicsBody(nodeSize: CGSize) {
        let physicsBody = SKPhysicsBody(rectangleOf: nodeSize)
        self.physicsBody = physicsBody
        self.physicsBody?.mass = 0.05
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.affectedByGravity = false
    }
    
}
