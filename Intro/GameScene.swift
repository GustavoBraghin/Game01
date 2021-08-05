//
//  GameScene.swift
//  Intro
//
//  Created by Marcos Morais on 31/03/19.
//  Copyright © 2019 Developer Academy UCB. All rights reserved.
//

// Importo a framework SpriteKit para desenvolvimento de Jogos 2D
import SpriteKit

// Declaração da minha classe GameScene, que herda de SKScene
class GameScene: SKScene {
    
    let scoreLabel = SKLabelNode(fontNamed: "HelveticaNeue-CondensedBold")
    var score: Int
    
    // Nosso método init. Ele é o primeiro método a ser chamado sempre que nossa cena for iniciada!
    override init(size: CGSize) {
        self.score = 0
        
        super.init(size: size)
        
        // Métodos para preparação do projeto inicial
        self.setPhysicsUp()
        self.createBackground(with: CGPoint(x: size.width*0.50, y: size.height*0.55))
        self.createScoreLabel(with: CGPoint(x: size.width*0.5, y: size.height*0.85))
    }
    
    // Esse método é chamado automaticamente após a cena ser criada (DEPOIS do método init(:size))
    override func didMove(to view: SKView) {
        
        self.generateBombs(timePerBomb: 1)
        // Não faz parte da nossa aula
        self.startWorldEvents(with: view.frame.size)
        //createBomb(position: CGPoint(x: size.width/2, y: size.height*0.8))
    }
    
    /**
     Método chamado assim que um toque é detectado na tela. O começo do toque.
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // Recupero a referência para o toque
        let touch = touches.first
        
        // Recupero a posição do toque com referência à minha scene. À minha tela.
        guard let touchLocation = touch?.location(in: self) else { return }
        
        // Procuro saber se existe um node na posição do toque.
        guard let node = self.nodes(at: touchLocation).first else { return }
        
        //if touches the bomb, removes it from the scene and run explosion animation
        if node.name == "bomb" {
            node.removeFromParent()
            
            //udates score and scoreLabel
            self.score += 1
            self.scoreLabel.text = "\(score)"
            
            self.createExplosion(position: touchLocation)
        }
        
    }
    
    /**
     Método chamado assim que o movimento de um toque é detectado na tela. O "meio" do toque.
     */
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    /**
     Método chamado assim que um toque deixa de existir na tela. O "fim" do toque.
     */
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    /**
     Método chamado assim que um toque é cancelado. Exemplo: uma chamada telefônica interrompe o jogo.
     */
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    /**
     Método chamado até 60 vezes por segundo, em tempo real!
     */
    override func update(_ currentTime: TimeInterval) {
        // Chamado antes de cada frame ser renderizado na tela
    }
    
    // MARK: Elements
    
    /**
     Cria o sprite de background e o insere diretamente na nossa scene. Ele recebe um parâmetro de posição (X e Y).
     */
    func createBackground(with position: CGPoint) {
        
        // Declaro minha constante de background. Um Sprite que vem do arquivo Background.png
        let background = SKSpriteNode(imageNamed: "spaceBackground.jpg")
        
        // Insiro a Posição (X, Y) ao meu node.
        background.position = position
        
        // A ZPosition (posição Z [profundidade]) é definida. Por ser um background, ele ficará atrás de tudo.
        background.zPosition = -1
        
        // Altero diretamente a escala X e Y (largura e altura) do nosso background para 275% do tamanho original
        //background.setScale(0.75)
        
        // Retiro o Anti-Aliasing (redutor de serrilhado [por ser pixel art])
        background.texture?.filteringMode = .nearest
        
        // Adiciono meu sprite (background) como filho da cena, para ele ser renderizado.
        self.addChild(background)
        
    }
    
    /**
     Nosso método criador de uma bomba. Ele recebe como parâmetro uma posição (CGPoint).
     */
    func createBomb(position: CGPoint) {
        
        // Crio um novo node do tipo Sprite, com base na imagem Bomb_1.png 💣
        let bomb = SKSpriteNode(imageNamed: "Bomb_1")
        
        // Defino o tamanho do meu sprite como 75% do tamanho original
        bomb.setScale(0.75)
        
        // Insiro a Posição (X, Y) ao meu node.
        //bomb.position = CGPoint(x: size.width/2, y: size.height*0.5)
        bomb.position = position
        
        // Defino um nome para minha bomba dentro da cena para fácil acesso posteriormente
        bomb.name = "bomb"
        
        // A ZPosition (posição Z [profundidade]) é definida. Por ser uma bomba, ele ficará na frente do background.
        bomb.zPosition = 1
        
        // Configuro a sprite para passar a receber interações de física.
        bomb.setupDefaultPhysicsBody()
        
        // Adiciono minha bomba à minha cena (ela vira filha da minha cena)
        self.addChild(bomb)
        
        // Aplico uma ação de impulso para minha bomba (usando nosso sistema de física 😎)
        self.applyImpulseTo(node: bomb)
    }
    
//    func removeBomb(){
//        
//        if 
//    }
    
    //func to create the score label
    func createScoreLabel(with position: CGPoint){
        
        scoreLabel.text = "\(score)"
        scoreLabel.fontSize = 50
        scoreLabel.fontColor = .white
        scoreLabel.position = position
        scoreLabel.zPosition = 10
        
        self.addChild(scoreLabel)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /************************************************
    // MARK: Other. Não será utilizado em nossa aula.
    ************************************************/
    
    private lazy var explosionTextures: [SKTexture] = {
        return self.getExplosionTextures()
    }()
    /*
    lazy var windTextures: [SKTexture] = {
        return self.getWindTextures()
    }()
    */
    lazy var explosionSoundAction: SKAction = {
        return SKAction.playSoundFileNamed("explosion_sound.wav", waitForCompletion: false)
    }()
    
    func setPhysicsUp() {
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -6.8)
    }
    
    func startWorldEvents(with sceneSize: CGSize) {
        // Crio uma explosão. Esse método não faz parte da aula.
        self.createExplosion(position: CGPoint(x: sceneSize.width/2, y: sceneSize.height/2))
        //self.startWind(range: sceneSize)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
