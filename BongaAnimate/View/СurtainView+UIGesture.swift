//
//  СurtainView+UIGesture.swift
//  BongaAnimate
//
//  Created by Hudihka on 03/04/2020.
//  Copyright © 2020 Tatyana. All rights reserved.
//

import Foundation
import UIKit


extension СurtainView: UIGestureRecognizerDelegate {

    func addTabGestures(){
        let tap = UILongPressGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        tap.delegate = self
        tap.minimumPressDuration = 0
        buttonView.addGestureRecognizer(tap)
    }

    @objc func handleTap(_ sender: UILongPressGestureRecognizer) {

        let rect = buttonView.frame
        let point = sender.location(in: self)

        flagTouchInSide = rect.contains(point)


        switch sender.state {
        case .began:
            getGesturesColor()
        case .changed:
            getGesturesColor()
        case .ended:
            action()//вызываем метод если флаг тру
        default:
            break
        }

    }


    func getGesturesColor(){
        self.buttonView.backgroundColor = flagTouchInSide ? blueColorPress : blueColor
		self.labelLogin.textColor = flagTouchInSide ? UIColor.white.withAlphaComponent(0.8) : UIColor.white
    }

    func action(){
        if flagTouchInSide{
            self.delegate?.tapedButton()
            flagTouchInSide = false
            getGesturesColor()
        }
    }

}



extension UIView {
    @objc func loadViewFromNib(_ name: String) -> UIView { //добавление вью созданной в ксиб файле
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: name, bundle: bundle)
        if let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView {
            return view
        } else {
            return UIView()
        }
    }

    func addShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 4
    }
	
    func addShadowCustom() {
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.layer.shadowOpacity = 0.75
        self.layer.shadowRadius = 4
    }
	
	func addRadius(number: CGFloat) {
        self.layer.cornerRadius = number
        self.layer.masksToBounds = true
    }

    func cirkleView() {
        let radius = self.frame.height / 2
        self.addRadius(number: radius)
    }

}


extension UILabel{
	
	func twoStuleLabel(myString: String,
					   oneLenght: Int,
					   tupleSizeFront: (oneSizeFront: CGFloat, twoSizeFront: CGFloat),
					   tupleColor: (oneColor: UIColor, twoColor: UIColor)) {
		let oneSizeFront = tupleSizeFront.oneSizeFront
		let twoSizeFront = tupleSizeFront.twoSizeFront
		
		let oneColor = tupleColor.oneColor
		let twoColor = tupleColor.twoColor
		
		guard let defaultFront = UIFont(name: ".SFUIText", size: twoSizeFront) else {
			return
		}
		
		var myMutableString = NSMutableAttributedString()
		
		let font = UIFont(name: ".SFUIText", size: oneSizeFront) ?? defaultFront
		
		myMutableString = NSMutableAttributedString(string: myString,
													attributes: [NSAttributedString.Key.font: font])
		
		myMutableString.addAttribute(NSAttributedString.Key.font,
									 value: UIFont(name: ".SFUIText", size: oneSizeFront) ?? defaultFront,
									 range: NSRange(location: 0, length: oneLenght))
		
		let twoLenght = myString.count - oneLenght
		
		myMutableString.addAttribute(NSAttributedString.Key.font,
									 value: UIFont(name: ".SFUIText", size: twoSizeFront) ?? defaultFront,
									 range: NSRange(location: oneLenght, length: twoLenght))
		
		myMutableString.addAttribute(NSAttributedString.Key.foregroundColor,
									 value: twoColor,
									 range: NSRange(location: oneLenght, length: twoLenght))
		
		self.textColor = oneColor
		self.attributedText = myMutableString
	}
	
	
	var lenghtText: CGFloat?{
        
        if let text = self.text as NSString?, let font = self.font  {
            
            return (text as NSString).size(withAttributes: [NSAttributedString.Key.font : font]).width
        }
        return nil
    }
}
