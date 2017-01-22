//
//  EnemyControllerManager.swift
//  Wave Runner
//
//  Created by Apple on 1/21/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import SpriteKit

typealias NoEnemyLeftType = () -> ()

class EnemyControllerManager: Controller {
    static var shared: EnemyControllerManager!
    
    let enemyGenerator: EnemyControllerGenerator
    var enemies : [EnemyController]
    var missiles: [EnemyMissleController] = []
    
    var groundPosition: CGPoint!
    var midAirPosition: CGPoint!
    var highAirPosition: CGPoint!
    var noEnemyLeft: NoEnemyLeftType?
    
    
    init(enemyGenerator: EnemyControllerGenerator) {
        self.enemyGenerator = enemyGenerator
        enemies = []
    }
    
    override func config(position: CGPoint, parent: SKNode) {
        
    }
    
    func configStartingPositions(groundPosition: CGPoint, midAirPosition: CGPoint, highAirPosition: CGPoint) -> Void {
        self.groundPosition = groundPosition
        self.midAirPosition = midAirPosition
        self.highAirPosition = highAirPosition
    }
    
    override func run(parent: SKNode, time: TimeInterval) {
        let (enemyControllerOpt, type, outOfEnemy) = enemyGenerator.generate(time: time)
        
        
        if let enemyController = enemyControllerOpt {
            if (type == 1) {
                enemyController.config(position: self.midAirPosition, parent: parent)
            } else if(type == 3) {
                enemyController.config(position: self.highAirPosition.add(dx: 0, dy: -enemyController.size.height), parent: parent)
            } else if (type == 2 || type == 4) {
                enemyController.config(position: self.groundPosition.add(dx: 0, dy: enemyController.size.height / 2), parent: parent)
            }
            
            enemies.append(enemyController)
        }
        
        enemies = enemies.filter{
            enemy in
            return !enemy.viewDetached
        }
        
        if outOfEnemy && enemies.count <= 0 {
            self.noEnemyLeft?()
        }
        
        for enemyController in self.enemies {
            enemyController.run(parent: parent, time: time)
        }
    }
}
