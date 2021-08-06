//
//  GameScene+Extras.swift
//  Intro
//
//  Created by Marcos Morais on 31/03/19.
//  Copyright © 2019 Developer Academy UCB. All rights reserved.
//

import SpriteKit

extension GameScene {
    
    func animate(with textures: [SKTexture], timePerFrame: TimeInterval) -> SKAction {
        
        let animate = SKAction.animate(with: textures, timePerFrame: timePerFrame)
        return animate
        
    }
    
    func getExplosionTextures() -> [SKTexture] {
        var textures = [SKTexture]()
        for i in 1...12 {
            
            let texture = SKTexture(imageNamed: "Explosion_\(i)")
            texture.filteringMode = .nearest
            textures.append(texture)
            
        }
        
        return textures
    }
    
    func createExplosion(position: CGPoint) {
        let explosion = SKSpriteNode(imageNamed: "Explosion_1")
        explosion.position = position
        explosion.setScale(0.5)
        self.addChild(explosion)
        
        let animateAction = animate(with: getExplosionTextures(), timePerFrame: 0.075)
        let removeAfter = SKAction.removeFromParent()
        
        let sequence = SKAction.sequence([animateAction, removeAfter])
        
        explosion.run(sequence)
        explosion.run(self.explosionSoundAction)
    }
    
    /**
     Método que aplica impulso a um node usando Actions!
     */
    
    func applyImpulseTo(node: SKNode) {
        
        let applyImpulse = SKAction.applyImpulse(CGVector(dx: CGFloat.random(in: -7...7), dy: -20), duration: 0.1)
        let applyAngularImpulse = SKAction.applyAngularImpulse(CGFloat.random(in: -0.003...0.003), duration: 0.025)
        node.run(applyImpulse)
        node.run(applyAngularImpulse)
        
    }
    
}
