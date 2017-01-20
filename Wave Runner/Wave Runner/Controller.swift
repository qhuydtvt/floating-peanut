//
//  Controller.swift
//  Wave Runner
//
//  Created by Apple on 1/21/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import SpriteKit

protocol Controller {
    func config(parent: SKNode) -> Void;
    func run(parent: SKNode, time: TimeInterval) -> Void;
}
