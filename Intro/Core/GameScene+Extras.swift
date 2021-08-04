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
    
    
    func createWind(position: CGPoint) {
        
        let wind = SKSpriteNode(imageNamed: "Wind_1")
        wind.position = position
        wind.setScale(CGFloat.random(in: 0.1...0.55))
        wind.zPosition = 0
        self.addChild(wind)
        
        let animate = self.animate(with: self.windTextures, timePerFrame: 0.125)
        
        let move = SKAction.moveTo(x: self.size.width, duration: TimeInterval(Float.random(in: 2...4)))
        
        let fade = SKAction.fadeAlpha(to: 0, duration: TimeInterval(Float.random(in: 2...5)))
        
        wind.run(animate) {
            wind.removeFromParent()
        }
        
        wind.run(move)
        wind.run(fade)
        
    }
    
    func getWindTextures() -> [SKTexture] {
        var textures = [SKTexture]()
        for i in 1...16 {
            
            let texture = SKTexture(imageNamed: "Wind_\(i)")
            texture.filteringMode = .nearest
            textures.append(texture)
            
        }
        
        return textures
    }
    
    
    /**
     Método que aplica impulso a um node usando Actions!
     */
    func applyImpulseTo(node: SKNode) {
        
        let applyImpulse = SKAction.applyImpulse(CGVector(dx: CGFloat.random(in: -10...10), dy: 50), duration: 0.1)
        let applyAngularImpulse = SKAction.applyAngularImpulse(CGFloat.random(in: -0.01...0.01), duration: 0.025)
        node.run(applyImpulse)
        node.run(applyAngularImpulse)
        
    }
    
}
