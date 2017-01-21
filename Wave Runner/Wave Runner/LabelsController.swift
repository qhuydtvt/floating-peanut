//
//  LabelsController.swift
//  Wave Runner
//
//  Created by Duy Anh on 1/21/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import Foundation
import SpriteKit

class LabelsController {
    let gameScene: SKScene
    
    let fontName = "Times New Roman"
    let fontSize: CGFloat = 68
    let zPosition: CGFloat = 5
    let distanceBetweenLabels: CGFloat = 8
    
    init(scene: SKScene) {
        self.gameScene = scene
    }
    
    func addLabels() {
        let pullLabel = SKLabelNode(fontNamed: fontName)
        pullLabel.fontSize = fontSize
        pullLabel.horizontalAlignmentMode = .left
        pullLabel.verticalAlignmentMode = .bottom
        pullLabel.text = "Pull"
        pullLabel.zPosition = zPosition
        pullLabel.position = CGPoint(x: 8, y: 8)
        gameScene.addChild(pullLabel)
        
        let pushLabel = SKLabelNode(fontNamed: fontName)
        pushLabel.fontSize = fontSize
        pushLabel.horizontalAlignmentMode = .left
        pushLabel.verticalAlignmentMode = .bottom
        pushLabel.text = "Push"
        pushLabel.zPosition = zPosition
        pushLabel.position = pullLabel.position.add(dx: 0, dy: pullLabel.frame.height + distanceBetweenLabels)
        gameScene.addChild(pushLabel)
        
        let laserLabel = SKLabelNode(fontNamed: fontName)
        laserLabel.fontSize = fontSize
        laserLabel.horizontalAlignmentMode = .left
        laserLabel.text = "Laser"
        laserLabel.zPosition = zPosition
        laserLabel.position = pushLabel.position.add(dx: 0, dy: pushLabel.frame.height + distanceBetweenLabels)
        gameScene.addChild(laserLabel)
        
        let sonicLabel = SKLabelNode(fontNamed: fontName)
        sonicLabel.fontSize = fontSize
        sonicLabel.horizontalAlignmentMode = .left
        sonicLabel.text = "Sonic"
        sonicLabel.zPosition = zPosition
        sonicLabel.position = laserLabel.position.add(dx: 0, dy: laserLabel.frame.height + distanceBetweenLabels)
        gameScene.addChild(sonicLabel)
    }
}
