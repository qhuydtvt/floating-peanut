//
//  GameScene.swift
//  Wave Runner
//
//  Created by Duy Anh on 1/20/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var backgroundController: BackgroundController!
    var platformController: PlatformController!
    var enemyManager : EnemyControllerManager!
    var playerController: PlayerController!
    var backgroundSoundController: BackgroundSoundController!
    var labelsController: LabelsController!
    
    override func didMove(to view: SKView) {
        configPhysics()
        configBackground()
        configPlatform()
        configSound()
        
        enemyManager = EnemyControllerManager(enemyGenerator: EnemyControllerGenerator(jsonFile: "stage1"))
        EnemyControllerManager.shared = enemyManager
        
        configPlayer()
        configGesture()
        
        let (groundPosition, midAirPosition, highAirPosition) = platformController.startingPositions
        enemyManager.configStartingPositions(groundPosition: groundPosition, midAirPosition: midAirPosition, highAirPosition: highAirPosition)
        
        configLabels()
    }
    
    func configLabels() {
        self.labelsController = LabelsController(scene: self)
        LabelsController.shared = labelsController
        labelsController.addLabels()
    }
    
    func configGesture() {
        let gesture: UIGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(fireLaser))
        view?.addGestureRecognizer(gesture)
        
        let gesture2 = UISwipeGestureRecognizer(target: playerController, action: #selector(PlayerController.sonicAttack))
        gesture2.direction = .right
        view?.addGestureRecognizer(gesture2)
        
        let gesture3 = UISwipeGestureRecognizer(target: playerController, action: #selector(PlayerController.createGravityField))
        gesture3.direction = .left
        gesture3.numberOfTouchesRequired = 2
        view?.addGestureRecognizer(gesture3)
        
        let gesture4 = UISwipeGestureRecognizer(target: playerController, action: #selector(PlayerController.pushEnemies))
        gesture4.direction = .right
        gesture4.numberOfTouchesRequired = 2
        view?.addGestureRecognizer(gesture4)
    }
    
    func fireLaser(gesture: UIGestureRecognizer) {
        var destination = gesture.location(in: view!).multiply(factor: self.frame.width / view!.width)
        destination.y = self.frame.height - destination.y
        let position = playerController.view.position.add(other: playerController.player.position.multiply(factor: 3))
        let vector = destination.add(other: position.multiply(factor: -1))
        if vector.x > 0 {
            let angle = atan(vector.y / vector.x)
            if angle >= CGFloat.pi / 18 {
                playerController.fireUpwardLaser()
            } else {
                playerController.fireStraightLaser()
            }
        }
    }
    
    func configPlayer() {
        self.playerController = PlayerController.instance
        playerController.config(position: CGPoint(x: 175, y: platformController.platform1.height + playerController.board.height * 1.5), parent: self)
    }
    
    func configPlatform() {
        self.platformController = PlatformController()
        self.platformController.config(position: .zero, parent: self)
    }
    
    func configBackground() -> Void {
        self.backgroundController = BackgroundController()
        self.backgroundController.config(position: .zero, parent: self)
    }
    
    func configSound() {
        self.backgroundSoundController = BackgroundSoundController()
        self.backgroundSoundController.config(position: .zero, parent: self)
    }
    
    override func update(_ currentTime: TimeInterval) {
        backgroundController.run(parent: self, time: currentTime)
        platformController.run(parent: self)
        enemyManager.run(parent: self, time: currentTime)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        guard let viewA = contact.bodyA.node as? View, let viewB = contact.bodyB.node as? View else {
            return
        }
        
        if viewA.parent == nil || viewB.parent == nil {
            return
        }
        
        if viewA.contacted || viewB.contacted || viewA.avoidContact || viewB.avoidContact {
            return
        }
        
        viewA.contacted = true
        viewB.contacted = true
        
        viewA.physicsWorld = self.physicsWorld
        viewB.physicsWorld = self.physicsWorld
        
        if let handleContactA = viewA.handleContact {
            handleContactA(viewB)
        }
        
        if let handleContactB = viewB.handleContact {
            handleContactB(viewA)
        }
    }
    
    func configPhysics() -> Void {
        self.physicsWorld.gravity = .zero
        self.physicsWorld.contactDelegate = self
    }
}
