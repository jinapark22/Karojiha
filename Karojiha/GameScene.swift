//
//  GameScene.swift
//  Karojiha
//
//  Created by Jina Park on 10/11/17.
//  Copyright © 2017 Macalester College. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    struct PhysicsCategory {
        static let Player: UInt32 = 1
        static let Obstacle: UInt32 = 2
        static let Edge: UInt32 = 4
    }
    
    let birdAtlas = SKTextureAtlas(named:"player")
    var birdSprites = Array<SKTexture>()
    var bird = SKSpriteNode()
    var repeatActionbird = SKAction()
    
    var obstacles: [SKNode] = []
    let obstacleSpacing: CGFloat = 800
    let cameraNode = SKCameraNode()
    let ledge = SKNode()
    let playerBody = SKPhysicsBody(circleOfRadius: 30)


    
    override func didMove(to view: SKView) {
        createScene()
        createLedge()
        createPlayerAndPosition()

        physicsWorld.gravity.dy = -15
        
        addChild(cameraNode)
        camera = cameraNode
        cameraNode.position = CGPoint(x: size.width/2, y: size.height/2)
        
    }
    
    func createLedge() {
        ledge.position = CGPoint(x: size.width/2, y: size.height/40)
        let ledgeBody = SKPhysicsBody(rectangleOf: CGSize(width: size.width/2, height: size.height/40))
        ledgeBody.isDynamic = false
        ledgeBody.categoryBitMask = PhysicsCategory.Edge
        ledge.physicsBody = ledgeBody
        addChild(ledge)
    }
    
    func createPlayerAndPosition() {
        playerBody.mass = 1.5
        playerBody.categoryBitMask = PhysicsCategory.Player
        playerBody.collisionBitMask = 4
        bird.physicsBody = playerBody
        bird.position = CGPoint(x: ledge.position.x, y: ledge.position.y + 10)
    }
    
    
    func addObstacle() {
        addSquareObstacle()
    }
    
    func addSquareObstacle() {
        let path = UIBezierPath(roundedRect: CGRect.init(x: -200, y: -200,
                                                         width: 400, height: 40),
                                cornerRadius: 20)
        
        let obstacle = obstacleByDuplicatingPath(path, clockwise: false)
        obstacles.append(obstacle)
        obstacle.position = CGPoint(x: size.width/2, y: obstacleSpacing * CGFloat(obstacles.count))
        addChild(obstacle)
    }
    
    func obstacleByDuplicatingPath(_ path: UIBezierPath, clockwise: Bool) -> SKNode {
        let container = SKNode()
        let section = SKShapeNode(path: path.cgPath)
        container.addChild(section)
        return container
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        bird.physicsBody?.velocity.dy = 600.0
        
        self.bird.run(repeatActionbird)

    }
    
    
    func createScene(){
        
        self.bird = createBird()
        self.addChild(bird)
        
        birdSprites.append(birdAtlas.textureNamed("bird1"))
        birdSprites.append(birdAtlas.textureNamed("bird2"))
        birdSprites.append(birdAtlas.textureNamed("bird3"))
        birdSprites.append(birdAtlas.textureNamed("bird4"))
        
        let animatebird = SKAction.animate(with: self.birdSprites, timePerFrame: 0.1)
        self.repeatActionbird = SKAction.repeatForever(animatebird)
        
    }
    
    func dieAndRestart() {
        bird.physicsBody?.velocity.dy = 0
        //bird.removeFromParent()
        
        for node in obstacles {
            node.removeFromParent()
        }
        
        obstacles.removeAll()
        
        addObstacle()
        cameraNode.position = CGPoint(x: size.width/2, y: size.height/2)
        
        let scene = GameScene(size: size)
        view?.presentScene(scene)
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
        if bird.position.y > obstacleSpacing * CGFloat(obstacles.count - 2) {
            addObstacle()
        }
        
        let playerPositionInCamera = cameraNode.convert(bird.position, from: self)
        if playerPositionInCamera.y > 0 {
            cameraNode.position.y = bird.position.y
        }
        
        if playerPositionInCamera.y < -size.height/2 {
            dieAndRestart()
        }
    }
}
