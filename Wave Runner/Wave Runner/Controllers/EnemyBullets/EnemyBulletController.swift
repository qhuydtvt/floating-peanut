//
//  EnemyBulletController.swift
//  Wave Runner
//
//  Created by Apple on 1/21/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import SpriteKit

class EnemyBulletController: SingleControler {
    init() {
        super.init(view: View(image: #imageLiteral(resourceName: "missle_small")))
    }
    
    override func config(position: CGPoint, parent: SKNode) {
        super.config(position: position, parent: parent)
    }
    
    override func run(parent: SKNode, time: TimeInterval) {
        super.run(parent: parent, time: time)
        let _ = self.moveTowards(destination: PlayerController.instance.position, speed: 3)
    }
}
