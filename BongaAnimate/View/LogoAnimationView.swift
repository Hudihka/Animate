//
//  LogoAnimationView.swift
//  BongaAnimate
//
//  Created by Hudihka on 03/04/2020.
//  Copyright © 2020 Tatyana. All rights reserved.
//

import Foundation
import UIKit

class LogoAnimationView: UIView {

    var labelText = UILabel()
    var imageLogo = UIImageView()

    let weight = 222 * wDdevice / 375


    override init (frame: CGRect) {
        super.init(frame: frame)
        settingsView()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        settingsView()
    }

    private func settingsView() {
        self.backgroundColor = UIColor.clear
        self.isMultipleTouchEnabled = true
        self.isUserInteractionEnabled = false
        addImageLogoAndAnimation()
        addLabeAndAnimation()
        imageFinishAnimation()
    }

    //MARK: - IMAGE LOGO

    private func addImageLogoAndAnimation(){
        createImageLogo()
        imageLogoAnimation()
        
    }

    private func createImageLogo(){
        imageLogo = UIImageView(image: UIImage(named: "animationLogo"))
		
        imageLogo.frame.size = CGSize(width: 1, height: 1)
        imageLogo.center = self.center
        self.addSubview(imageLogo)
    }

    private func imageLogoAnimation(){
        UIView.animate(withDuration: 0.5,
                       delay: 0.8,
                       options: .allowUserInteraction,
                       animations: {
            self.imageLogo.transform = CGAffineTransform(scaleX: self.weight, y: self.weight)

        }, completion: nil)

        self.imageLogo.rotate()
    }

    //MARK: - Label

    private func addLabeAndAnimation(){
        createLabel()
        labelAnimation()
    }

    private func createLabel(){

        let constant = 0.25 * weight

        let pointX = (wDdevice - 180) / 2
        let pointY = (hDdevice / 2) + constant

        labelText = UILabel(frame: CGRect(x: pointX,
                                          y: pointY,
                                          width: 180,
                                          height: 34))

        labelText.numberOfLines = 2
        labelText.backgroundColor = UIColor.clear
        labelText.textColor = UIColor.white
		labelText.alpha = 0
        labelText.text = "enjoyChatting jjhjhhhhh"//localized("enjoyChatting")
        labelText.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        labelText.textAlignment = NSTextAlignment.center;

        self.addSubview(labelText)
    }

    private func labelAnimation(){
		
		UIView.animate(withDuration: 0.15,
					   delay: 1.3,
					   options: [],
					   animations: {
			self.labelText.alpha = 1
		}, completion: nil)
    }

    private func imageFinishAnimation(){ //движение лейбла и лого в верх
		
		let imageFR = self.imageLogo.frame
		
		let newPositionLabel = CGPoint(x: labelText.frame.origin.x,
									   y: (hDdevice * 0.15) + imageFR.height * 0.65)
		
		let newPositionLogo = CGPoint(x: imageFR.origin.x, y: hDdevice * 0.15)
		
		
		UIView.animate(withDuration: 0.3,
					   delay: 1.5,
					   options: [],
					   animations: {
						
						self.imageLogo.frame.origin = newPositionLogo

						self.imageLogo.transform = CGAffineTransform(scaleX: 0.85 * imageFR.width,
															 y: 0.90 * imageFR.height)

						self.labelText.frame.origin = newPositionLabel

		},
					   completion: nil)
		
		
	
    }
	



    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}


extension UIImageView{
    func rotate() {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: -Double.pi/4)
        rotation.beginTime = CACurrentMediaTime() + 1
        rotation.duration = 0.4
        rotation.fillMode = CAMediaTimingFillMode.forwards//kCAFillModeForwards
        rotation.isRemovedOnCompletion = false
        rotation.repeatCount = 1
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
}

//extension UIView{
//
//	func newYPositionFrame(koef: CGFloat) -> CGPoint{
//
//		let frame = self.frame
//
//		return CGPoint(x: frame.origin.x,
//					  y: hDdevice * koef)
//
//	}
//
//}
