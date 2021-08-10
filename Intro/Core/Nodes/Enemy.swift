//
//  Enemy.swift
//  Intro
//
//  Created by Gustavo da Silva Braghin on 10/08/21.
//  Copyright © 2021 Developer Academy UCB. All rights reserved.
//

import SpriteKit

class EnemyController: SKNode {
    
    let enemyCategory:      UInt32 = 0x1 << 2 // 4
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createEnemy(spriteName: String, position: CGPoint) -> SKSpriteNode{
        
        let enemy = SKSpriteNode(imageNamed: spriteName)
        // Defino o tamanho do meu sprite como 75% do tamanho original
        enemy.setScale(0.22)
        
        // Insiro a Posição (X, Y) ao meu node.
        enemy.position = position
        
        // Defino um nome para minha bomba dentro da cena para fácil acesso posteriormente
        enemy.name = "enemy"
        
        // A ZPosition (posição Z [profundidade]) é definida. Por ser uma bomba, ele ficará na frente do background.
        enemy.zPosition = 1
        
        // Configuro a sprite para passar a receber interações de física.
        enemy.setupDefaultPhysicsBody()
        enemy.physicsBody?.categoryBitMask = enemyCategory
        
        // Aplico uma ação de impulso para minha bomba (usando nosso sistema de física 😎)
        self.applyImpulseTo(node: enemy)
        return enemy
    }
    
//    func generateEnemy(timePerEnemy: TimeInterval, width: CGFloat, height: CGFloat, spriteName: String){
//        
//        
//    }
    
    func applyImpulseTo(node: SKNode) {
        
        let applyImpulse = SKAction.applyImpulse(CGVector(dx: CGFloat.random(in: -7...7), dy: -20), duration: 0.1)
        let applyAngularImpulse = SKAction.applyAngularImpulse(CGFloat.random(in: -0.003...0.003), duration: 0.025)
        node.run(applyImpulse)
        node.run(applyAngularImpulse)
        
    }
}
