//
//  EnemyBulletController.swift
//  Wave Runner
//
//  Created by Apple on 1/21/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import SpriteKit

class EnemyMissleController: SingleControler {
    init() {
        super.init(view: View(texture: Textures.missle_small))
    }
    
    override func config(position: CGPoint, parent: SKNode) {
        super.config(position: position, parent: parent)
        if let trailNode = SKEmitterNode(fileNamed: "missle_trail.sks") {
            trailNode.position = CGPoint(x: 0, y: -(self.size.height / 2))
            self.view.addChild(trailNode)
        }
        
        self.configPhysics()
    }
    
    func configPhysics() -> Void {
        self.view.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.view.physicsBody?.affectedByGravity = false
        self.view.physicsBody?.collisionBitMask = Masks.ENEMY_MISSLE
        self.view.physicsBody?.categoryBitMask = Masks.ENEMY_MISSLE
        self.view.physicsBody?.linearDamping = 0
        self.view.physicsBody?.fieldBitMask = 1
    }
    
    override func destroy() {
        super.destroy()
        let explosionController = ExplosionController(fileName: "missle_explosion.sks")
        explosionController.config(position: self.position, parent: self.parent)
    }
    
    override func run(parent: SKNode, time: TimeInterval) {
        super.run(parent: parent, time: time)
        if !self.moveTowards(destination: PlayerController.instance.center, speed: 20) {
            self.destroy()
        }
        view.zPosition = 5
    }
}
