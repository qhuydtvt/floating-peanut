//
//  EnemyControllerManager.swift
//  Wave Runner
//
//  Created by Apple on 1/21/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import SpriteKit

class EnemyControllerManager: Controller {
    
    let enemyGenerator: EnemyControllerGenerator
    var enemies : [EnemyController]
    
    init(enemyGenerator: EnemyControllerGenerator) {
        self.enemyGenerator = enemyGenerator
        enemies = []
    }
    
    override func config(position: CGPoint, parent: SKNode) {
        
    }
    
    override func run(parent: SKNode, time: TimeInterval) {
        if let enemyController = enemyGenerator.generate(time: time) {
            let enemyPosition = CGPoint(x: parent.frame.size.width, y: parent.frame.size.height / 2 + 20)
            enemyController.config(position: enemyPosition, parent: parent)
            enemies.append(enemyController)
        }
        
        for enemyController in self.enemies {
            enemyController.run(parent: parent, time: time)
        }
    }
}
