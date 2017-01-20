//
//  GameScene.swift
//  Wave Runner
//
//  Created by Duy Anh on 1/20/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var backgroundController: BackgroundController!
    var platformController: PlatformController!
    
    override func didMove(to view: SKView) {
        self.backgroundController = BackgroundController()
        self.backgroundController.config(parent: self)
        
        self.platformController = PlatformController()
        self.platformController.config(parent: self)
    }
    
    override func update(_ currentTime: TimeInterval) {
        backgroundController.run(parent: self)
        platformController.run(parent: self)
    }
}
