//
//  WaveController.swift
//  Wave Runner
//
//  Created by Duy Anh on 1/21/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import Foundation
import SpriteKit

class WaveController: SingleControler {
    
    var lastTimeUpdate : Double = -1
    
    var speed : CGFloat!
    
    var lifeTime: TimeInterval!
    
    var angle : CGFloat = 0
    
//    init() {
//        super.init(view: View(image: #imageLiteral(resourceName: "arc_left")))
//    }
    
    init(view aView: View, speed: CGFloat, lifeTime: TimeInterval, angle: CGFloat) {
        super.init(view: aView)
        self.speed = speed
        self.lifeTime = lifeTime
        self.angle = angle
    }
    //-(Speed.ENEMY_VELOCITY * 1.5)
    
    override func config(position: CGPoint, parent: SKNode) {
        self.view.physicsBody = SKPhysicsBody(rectangleOf: self.view.size)
        self.view.physicsBody?.collisionBitMask = 0
        self.view.physicsBody?.affectedByGravity = false
        self.view.physicsBody?.linearDamping = 0
        
        self.view.zRotation = CGFloat(angle)
        self.view.physicsBody?.velocity = CGVector(dx: speed * cos(angle), dy: speed * sin(angle))
        
        view.anchorPoint = CGPoint(x: 1, y: 0.5)
        
        self.view.zPosition = 100
        self.view.color = .red
        self.view.colorBlendFactor = 0.5
        self.view.xScale = 0.1
        self.view.yScale = 0.1
        super.config(position: position, parent: parent)
        
        self.view.run(.sequence([.scaleX(to: CGFloat(lifeTime / Double(4)), y: CGFloat(lifeTime / Double(4)), duration: lifeTime), .removeFromParent()]))
    }
    
    override func run(parent: SKNode, time: TimeInterval) {
        if lastTimeUpdate == -1 {
            lastTimeUpdate = time
        }
    }
    
//    static func createWaveLeft() -> WaveController {
//        return WaveController(view: View(image: #imageLiteral(resourceName: "arc_left")), speed: -(Speed.ENEMY_VELOCITY * 1.5), lifeTime: 3)
//    }
    
    static func create(angle: CGFloat) -> WaveController {
        return WaveController(view: View(image: #imageLiteral(resourceName: "arc_right")), speed: (Speed.ENEMY_VELOCITY * 2), lifeTime: 1.5, angle: angle)
    }
}
