//
//  EnemyController.swift
//  Wave Runner
//
//  Created by Apple on 1/21/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import SpriteKit

class EnemyController : SingleControler {
    var lastTimeUpdate : Double = -1
    
    init() {
        super.init(view: View(image: #imageLiteral(resourceName: "rock")))
    }
    
    override func config(position: CGPoint, parent: SKNode) {
        super.config(position: position, parent: parent)
        
        self.view.zPosition = 10
        //view.run(.moveTo(x: 0, duration: 5))
        view.physicsBody = SKPhysicsBody(rectangleOf: view.size)
        view.physicsBody?.collisionBitMask = 0
        view.physicsBody?.velocity = CGVector(dx: -Speed.ENEMY_VELOCITY, dy: 0)
        view.physicsBody?.linearDamping = 0
//        view.physicsBody?.affectedByGravity = false
    }
    
    override func run(parent: SKNode, time: TimeInterval) {
        super.run(parent: parent, time: time)
        
        if self.view.position.x < 0 {
            self.view.removeFromParent()
        }
        
        if lastTimeUpdate == -1 {
            lastTimeUpdate = time
        }
        
        let delta = time - lastTimeUpdate
        if (delta > 3) {
            self.attack()
            lastTimeUpdate = time
            print("Attack")
        }
    }
    
    func attack() -> Void {
        let waveController = WaveController()
        waveController.config(position: self.position, parent: self.parent)
    }
    
    static func create(type: Int) -> EnemyController {
        return EnemyController()
    }
}
