//
//  BackgroundSoundController.swift
//  Wave Runner
//
//  Created by Apple on 1/21/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import SpriteKit

class BackgroundSoundController: Controller {
    override init() {
        super.init()
    }
    
    override func config(position: CGPoint, parent: SKNode) {
        let sound = SKAction.playSoundFileNamed("background.mp3", waitForCompletion: false)
        parent.run(sound)
    }
}
