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
    }
    
    override func run(parent: SKNode, time: TimeInterval) {
        super.run(parent: parent, time: time)
        if !self.moveTowards(destination: PlayerController.instance.center, speed: 20) {
            self.destroy()
        }
    }
}
