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
    
    override func didMove(to view: SKView) {
        configPhysics()
        configBackground()
        configPlatform()
        
        enemyManager = EnemyControllerManager(enemyGenerator: EnemyControllerGenerator(jsonFile: "stage1"))
        
        configPlayer()
    }
    
    func configPlayer() {
        self.playerController = PlayerController()
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        playerController.attack()
        GestureController.shared.touchesBegan(at: touches.first!.location(in: self.view!))
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        GestureController.shared.touchesMoved(at: touches.first!.location(in: self.view!))
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let skill = GestureController.shared.touchesEnded(at: touches.first!.location(in: self.view!)){
            if skill == "sound" {
                playerController.attack()
            }
            if skill == "push" {
                playerController.view.run(.move(by: CGVector(dx:0,dy:100), duration: 0.5))
            }
            if skill == "pull" {
                playerController.view.run(.move(by: CGVector(dx:0,dy:-100), duration: 0.5))
            }
        }
    }
}
