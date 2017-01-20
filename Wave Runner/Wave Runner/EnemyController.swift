//
//  EnemyController.swift
//  Wave Runner
//
//  Created by Apple on 1/21/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import SpriteKit

class EnemyController : Controller {
    var view: View!
    
    override init() {
        view = View(image: #imageLiteral(resourceName: "rock"))
    }
    
    override func config(position: CGPoint, parent: SKNode) {
        self.view.zPosition = 10
        view.position = position
        //view.run(.moveTo(x: 0, duration: 5))
        view.physicsBody = SKPhysicsBody(rectangleOf: view.size)
        view.physicsBody?.collisionBitMask = 0
        view.physicsBody?.velocity = CGVector(dx: -Speed.ENEMY_VELOCITY, dy: 0)
        view.physicsBody?.linearDamping = 0
//        view.physicsBody?.affectedByGravity = false
        parent.addChild(view)
    }
    
    override func run(parent: SKNode, time: TimeInterval) {
        
    }
    
    static func create(type: Int) -> EnemyController {
        return EnemyController()
    }
}
