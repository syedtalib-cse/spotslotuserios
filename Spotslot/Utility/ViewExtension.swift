//
//  ViewExtension.swift
//  Spotslot
//
//  Created by mac on 18/08/20.
//  Copyright © 2020 Infograins. All rights reserved.
//

import Foundation
import UIKit
extension UIView{
    
    func setViewShadow(opacity : Double,cRadius:Double) {
          layer.shadowColor = UIColor.lightGray.cgColor
          layer.shadowOffset = CGSize(width: -0.5, height: 0.5)
          layer.shadowOpacity = Float(opacity)
          layer.cornerRadius = CGFloat(cRadius)
      }

    func addShadow(shadowColor: UIColor, offSet: CGSize, opacity: Float, shadowRadius: CGFloat, cornerRadius: CGFloat, corners: UIRectCorner, fillColor: UIColor = .white) {
          let shadowLayer = CAShapeLayer()
          let size = CGSize(width: cornerRadius, height: cornerRadius)
          let cgPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: size).cgPath //1
          shadowLayer.path = cgPath //2
          shadowLayer.fillColor = fillColor.cgColor //3
          shadowLayer.shadowColor = shadowColor.cgColor //4
          shadowLayer.shadowPath = cgPath
          shadowLayer.shadowOffset = offSet //5
          shadowLayer.shadowOpacity = opacity
          shadowLayer.shadowRadius = shadowRadius
           self.layer.insertSublayer(shadowLayer, at: 0)
          //self.layer.addSublayer(shadowLayer)
      }

    func roundedThreeCorner(width:CGFloat,height:CGFloat){
        let maskPath1 = UIBezierPath(roundedRect: bounds,
                                     byRoundingCorners: [.topRight , .bottomRight , .bottomLeft],
                                     cornerRadii: CGSize(width: width, height: height))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }
    func roundedTopLetBottomLeftRightTop(width:CGFloat,height:CGFloat){
           let maskPath1 = UIBezierPath(roundedRect: bounds,
                                        byRoundingCorners: [.bottomLeft , .topRight,.topLeft],
                                        cornerRadii: CGSize(width: width, height: height))
           let maskLayer1 = CAShapeLayer()
           maskLayer1.frame = bounds
           maskLayer1.path = maskPath1.cgPath
           layer.mask = maskLayer1
       }
     
    func createGradientLayer() {
       let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [UIColor.red.cgColor, UIColor.yellow.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        self.layer.addSublayer(gradientLayer)
    }
    
    func setGradientBackgrounds(colorTop: UIColor, colorBottom: UIColor,radius:CGFloat) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = bounds
        layer.cornerRadius = radius
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setRadiusBorderWithColor(borderWidth : CGFloat,cRadius:CGFloat,Color:UIColor) {
        layer.borderColor = Color.cgColor
        layer.borderWidth = borderWidth
        layer.cornerRadius = cRadius
    }
    
    func addTopBottomShadow(offset: CGSize = CGSize(width: 0, height: 10), color: UIColor = .black, opacity: Float = 0.5, shadowRadius: CGFloat = 5.0, cornerRadius: CGFloat = 16) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = shadowRadius
    }
    
}
extension UIView {
    @IBInspectable var hazardSourceType: CGFloat {
        get {
            return self.hazardSourceType
        }
        set {
            self.hazardSourceType = newValue
        }
    }

    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}
extension UIView
{
func roundedTopLeft(){
    let maskPath1 = UIBezierPath(roundedRect: bounds,
                                 byRoundingCorners: [.topLeft],
                                 cornerRadii: CGSize(width: 15, height: 15))
    let maskLayer1 = CAShapeLayer()
    maskLayer1.frame = bounds
    maskLayer1.path = maskPath1.cgPath
    layer.mask = maskLayer1
}

func roundedTopRight(){
    let maskPath1 = UIBezierPath(roundedRect: bounds,
                                 byRoundingCorners: [.topRight],
                                 cornerRadii: CGSize(width: 15, height: 15))
    let maskLayer1 = CAShapeLayer()
    maskLayer1.frame = bounds
    maskLayer1.path = maskPath1.cgPath
    layer.mask = maskLayer1
}
func roundedBottomLeft(){
    let maskPath1 = UIBezierPath(roundedRect: bounds,
                                 byRoundingCorners: [.bottomLeft],
                                 cornerRadii: CGSize(width: 15, height: 15))
    let maskLayer1 = CAShapeLayer()
    maskLayer1.frame = bounds
    maskLayer1.path = maskPath1.cgPath
    layer.mask = maskLayer1
}
func roundedBottomRight(){
    let maskPath1 = UIBezierPath(roundedRect: bounds,
                                 byRoundingCorners: [.bottomRight],
                                 cornerRadii: CGSize(width: 15, height: 15))
    let maskLayer1 = CAShapeLayer()
    maskLayer1.frame = bounds
    maskLayer1.path = maskPath1.cgPath
    layer.mask = maskLayer1
}
    
    func roundedBottom(width:CGFloat,height:CGFloat){
    let maskPath1 = UIBezierPath(roundedRect: bounds,
                                 byRoundingCorners: [.bottomRight , .bottomLeft],
                                 cornerRadii: CGSize(width: width, height: height))
    let maskLayer1 = CAShapeLayer()
    maskLayer1.frame = bounds
    maskLayer1.path = maskPath1.cgPath
    layer.mask = maskLayer1
}
    
func roundedTop(width:CGFloat,height:CGFloat){
    let maskPath1 = UIBezierPath(roundedRect: bounds,
                                 byRoundingCorners: [.topRight , .topLeft],
                                 cornerRadii: CGSize(width: width, height: height))
    let maskLayer1 = CAShapeLayer()
    maskLayer1.frame = bounds
    maskLayer1.path = maskPath1.cgPath
    layer.mask = maskLayer1
}
func roundedLeft(){
    let maskPath1 = UIBezierPath(roundedRect: bounds,
                                 byRoundingCorners: [.topLeft , .bottomLeft],
                                 cornerRadii: CGSize(width: 15, height: 15))
    let maskLayer1 = CAShapeLayer()
    maskLayer1.frame = bounds
    maskLayer1.path = maskPath1.cgPath
    layer.mask = maskLayer1
}
func roundedRight(){
    let maskPath1 = UIBezierPath(roundedRect: bounds,
                                 byRoundingCorners: [.topRight , .bottomRight],
                                 cornerRadii: CGSize(width: 15, height: 15))
    let maskLayer1 = CAShapeLayer()
    maskLayer1.frame = bounds
    maskLayer1.path = maskPath1.cgPath
    layer.mask = maskLayer1
}
func roundedAllCorner(){
    let maskPath1 = UIBezierPath(roundedRect: bounds,
                                 byRoundingCorners: [.topRight , .bottomRight , .topLeft , .bottomLeft],
                                 cornerRadii: CGSize(width: 15, height: 15))
    let maskLayer1 = CAShapeLayer()
    maskLayer1.frame = bounds
    maskLayer1.path = maskPath1.cgPath
    layer.mask = maskLayer1
}
    
    func roundedTopLeftTopRight(width:CGFloat,height:CGFloat){
        let maskPath1 = UIBezierPath(roundedRect: bounds,
                                     byRoundingCorners: [.topLeft , .topRight],
                                     cornerRadii: CGSize(width: width, height: height))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: -0.5, height: 0.5)
        layer.shadowOpacity = 0.6
        //        layer.borderColor = #colorLiteral(red: 0.3622615337, green: 0.8218501806, blue: 0.8313922286, alpha: 1)
        //        layer.borderWidth = 1
        layer.masksToBounds = true
    }
    
    func roundTopLeftBottomLeft(width:CGFloat,height:CGFloat){
        let maskPath1 = UIBezierPath(roundedRect: bounds,
                                     byRoundingCorners: [.topLeft , .bottomLeft],
                                     cornerRadii: CGSize(width: width, height: height))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: -0.5, height: 0.5)
        layer.shadowOpacity = 0.6
         layer.masksToBounds = true
    }
    
    func roundToprightBottomRight(width:CGFloat,height:CGFloat){
           let maskPath1 = UIBezierPath(roundedRect: bounds,
                                        byRoundingCorners: [.topRight , .bottomRight],
                                        cornerRadii: CGSize(width: width, height: height))
           let maskLayer1 = CAShapeLayer()
           maskLayer1.frame = bounds
           maskLayer1.path = maskPath1.cgPath
           layer.mask = maskLayer1
           layer.shadowColor = UIColor.lightGray.cgColor
           layer.shadowOffset = CGSize(width: -0.5, height: 0.5)
           layer.shadowOpacity = 0.6
            layer.masksToBounds = true
       }
    
    func roundedThreSide(){
        let maskPath1 = UIBezierPath(roundedRect: bounds,
                                     byRoundingCorners: [.bottomRight , .topLeft , .bottomLeft],
                                     cornerRadii: CGSize(width: 15, height: 15))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }
    
    func addDashedBorder() {
    let shapeLayer:CAShapeLayer = CAShapeLayer()
    let frameSize = self.frame.size
    let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
    shapeLayer.bounds = shapeRect
    shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
    shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.gray as! CGColor
    shapeLayer.lineWidth = 1
    shapeLayer.lineJoin = CAShapeLayerLineJoin.round
    shapeLayer.lineDashPattern = [6,3]
    shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 20).cgPath

    self.layer.addSublayer(shapeLayer)
    }
    
}

extension UIView{
    func addGradientBG()  {
        let layer = CAGradientLayer()
        layer.frame = self.bounds
        layer.colors = [#colorLiteral(red: 0.07843137255, green: 0.5529411765, blue: 0.5725490196, alpha: 1),#colorLiteral(red: 0.09411764706, green: 0.7254901961, blue: 0.7803921569, alpha: 1)]
        layer.startPoint = CGPoint(x: 0, y: 0)
        layer.startPoint = CGPoint(x:1,y:1)
        self.layer.addSublayer(layer)
    }
}
