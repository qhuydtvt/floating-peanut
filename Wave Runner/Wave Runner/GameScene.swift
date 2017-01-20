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
    
    override func didMove(to view: SKView) {
        configPhysics()
        configBackground()
        configPlatform()
    }
    
    func configPlatform() {
        self.platformController = PlatformController()
        self.platformController.config(parent: self)
    }
    
    func configBackground() -> Void {
        self.backgroundController = BackgroundController()
        self.backgroundController.config(parent: self)
    }
    
    override func update(_ currentTime: TimeInterval) {
        backgroundController.run(parent: self, time: currentTime)
        platformController.run(parent: self)
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
        self.physicsWorld.contactDelegate = self
    }
}
