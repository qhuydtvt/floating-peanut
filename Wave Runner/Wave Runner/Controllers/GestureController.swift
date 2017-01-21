//
//  GestureController.swift
//  Wave Runner
//
//  Created by Duy Anh on 1/21/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import Foundation
import UIKit

class GestureController {
    static let shared = GestureController()
    lazy var templates: [SwiftUnistrokeTemplate] = {
        var array: [SwiftUnistrokeTemplate] = []
        
        let path = Bundle.main.path(forResource: "Gestures", ofType: "json")
        let jsonData = FileManager.default.contents(atPath: path!)
        let templateDict = try! JSONSerialization.jsonObject(with: jsonData!, options: JSONSerialization.ReadingOptions.allowFragments) as! [[String: Any]]
        
        for dict in templateDict {
            let name = dict["name"]! as! String
            let rawPoints: [AnyObject] = dict["points"]! as! [AnyObject]
            
            var points: [StrokePoint] = []
            for rawPoint in rawPoints {
                let x = (rawPoint as! [AnyObject]).first! as! Double
                let y = (rawPoint as! [AnyObject]).last! as! Double
                points.append(StrokePoint(x: x, y: y))
            }
            array.append(SwiftUnistrokeTemplate(name: name, points: points))
        }
        return array
    }()
    var inputPoints: [StrokePoint] = []
    
    func touchesBegan(at point: CGPoint) {
        inputPoints.removeAll()
        inputPoints.append(StrokePoint(point: point))
    }
    
    func touchesMoved(at point: CGPoint) {
        inputPoints.append(StrokePoint(point: point))
    }
    
    func touchesEnded(at point: CGPoint) {
        inputPoints.append(StrokePoint(point: point))
        let recognizer = SwiftUnistroke(points: inputPoints)
        do {
            let (template,distance) = try recognizer.recognizeIn(templates: self.templates, useProtractor:  false)
            if template != nil {
                print("[FOUND] Template found is \(template!.name) with distance: \(distance!)")
            } else {
                //                print("[FAILED] Template not found")
            }
        } catch (let error as NSError) {
            //            print("[FAILED] Error: \(error.localizedDescription)")
        }
    }
}
