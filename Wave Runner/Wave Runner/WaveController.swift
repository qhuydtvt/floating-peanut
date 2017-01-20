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
    
    init() {
        super.init(view: View(image: #imageLiteral(resourceName: "wave")))
    }
    
    override func config(position: CGPoint, parent: SKNode) {
        super.config(position: position, parent: parent)
        self.view.physicsBody = SKPhysicsBody(rectangleOf: self.view.size)
        self.view.physicsBody?.collisionBitMask = 0
        self.view.physicsBody?.affectedByGravity = false
        self.view.physicsBody?.velocity = CGVector(dx: -(Speed.PLATFORM_SPEED*2), dy: 0)
        
        self.view.color = .red
        self.view.colorBlendFactor = 0.5
        self.view.xScale = -0.1
        self.view.yScale = 0.1
        self.view.run(.sequence([.scaleX(to: -1, y: 1, duration: 2), .removeFromParent()]))
//        self.view.run(.sequence([.scale(to: 2.0, duration: 1), .removeFromParent()]))
    }
    
    override func run(parent: SKNode, time: TimeInterval) {
        if lastTimeUpdate == -1 {
            lastTimeUpdate = time
        }
    }
}
