//
//  GameElements.swift
//  Karojiha
//
//  Created by Jina Park on 10/11/17.
//  Copyright © 2017 Macalester College. All rights reserved.
//

import SpriteKit

extension GameScene{
    
    //Create the bird
    func createBird() -> SKSpriteNode {
        
        //Set the size and position of the bird
        let bird = SKSpriteNode(texture: SKTextureAtlas(named:"player").textureNamed("bird_1"))
        bird.size = CGSize(width: 150, height: 110)
        bird.position = CGPoint(x:self.frame.midX, y:self.frame.midY)
        
        //Define the bird to be a SKPhysicsBody object.
        bird.physicsBody = SKPhysicsBody(circleOfRadius: bird.size.width / 2)
        bird.physicsBody?.linearDamping = 1.1
        bird.physicsBody?.restitution = 0
        
        //Set the bird to be affected by gravity.
        bird.physicsBody?.affectedByGravity = false
        bird.physicsBody?.isDynamic = true

        //makes bird flap its wings when tap occurrs
        let birdSprites = (1...4).map { n in birdAtlas.textureNamed("bird_\(n)") }
        let animatebird = SKAction.animate(with: birdSprites, timePerFrame: 0.1)
        flappingAction = SKAction.repeat(animatebird, count: 2)
        
        return bird
    }
    
    //Set up click counter in upper right corner
    func createElevationLabel(){
        elevationLabel.horizontalAlignmentMode = .right
        elevationLabel.position = CGPoint(x: size.width/2.35, y: size.height/2.25)
        elevationLabel.fontColor = .orange
        elevationLabel.fontSize = 20
        elevationLabel.fontName = "Avenir-BlackOblique"
        elevationLabel.text = String(describing:
            Int((bird.position.y) - (ledge.position.y + 10))) + String(" ft")
        cameraNode.addChild(elevationLabel)
    }
    
    //Creates the sound button button
    func createSoundBtn() {
        soundBtn = SKSpriteNode(imageNamed: "soundButtonSmallSquare")
        soundBtn.size = CGSize(width: 50, height: 50)
        soundBtn.position = CGPoint(x: -size.width/10, y: size.height/2.25)
        soundBtn.zPosition = 6
        soundBtn.setScale(0)
        cameraNode.addChild(soundBtn)
        soundBtn.run(SKAction.scale(to: 1.0, duration: 0.0))
    }
    
    //Creates the pause button
    func createPauseBtn() {
        pauseBtn = SKSpriteNode(imageNamed: "pauseButtonSmallSquare")
        pauseBtn.size = CGSize(width: 50, height: 50)
        pauseBtn.position = CGPoint(x: -size.width/4, y: size.height/2.25)
        pauseBtn.zPosition = 6
        pauseBtn.setScale(0)
        cameraNode.addChild(pauseBtn)
        pauseBtn.run(SKAction.scale(to: 1.0, duration: 0.0))
    }

    //Creates the restart button
    func createHomeBtn() {
        homeBtn = SKSpriteNode(imageNamed: "homeButtonSmallSquare")
        homeBtn.size = CGSize(width: 50, height: 50)
        homeBtn.position = CGPoint(x: -size.width/2.5 , y: size.height/2.25)
        homeBtn.zPosition = 6
        homeBtn.setScale(0)
        cameraNode.addChild(homeBtn)
        homeBtn.run(SKAction.scale(to: 1.0, duration: 0.0))
    }
}


