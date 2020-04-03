//
//  СurtainView.swift
//  BongaTalk
//
//  Created by Username on 24.07.2019.
//  Copyright © 2019 AITI MEGASTAR. All rights reserved.
//

import UIKit

protocol СurtainViewDelegate: AnyObject {
    func tapedButton()
    func tapedButtonNewAcc()
}

class СurtainView: UIView {

    let duration: TimeInterval = 0.4

    var flagTouchInSide: Bool = false

    weak var delegate: СurtainViewDelegate?
	
	var buttonView = UIView()
	private let finalYPosition: CGFloat = isIPhone5 ? 50 : 75
	
	var labelLogin = UILabel()
	
	var labelNewAcc = UILabel()
	var buttonNewAcc = UIButton()
	

    override init (frame: CGRect) {
        super.init(frame: frame)
        settingsView()
    }
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	

    private func settingsView() {
        self.backgroundColor = UIColor.clear
    }
	
	func addView() {
		addImageView()
		desingButtonView()
		desingLabelLogin()
		desingLabelAcc()
	}
	
	private func addImageView(){
		let imageView = UIImageView(frame: CGRect(origin: .zero, size: self.frame.size))
		imageView.image = UIImage(named: "curtain")
		
		self.addSubview(imageView)
	}
	
	private func desingButtonView(){
		
		self.buttonView.frame = CGRect(x: xPoint(width: 48),
									   y: self.frame.size.height,
									   width: 48,
									   height: 48)
		
		self.buttonView.cirkleView()
		buttonView.backgroundColor = blueColor
		
		self.addSubview(buttonView)
		
		
	}
	
	private func desingLabelLogin(){
		
		self.labelLogin.frame = CGRect(x: 0, y: 0, width: self.finalWidth, height: 48)
		
		self.labelLogin.text = "LOGIN"
		self.labelLogin.textColor = UIColor.white
		self.labelLogin.backgroundColor = UIColor.clear
		self.labelLogin.font = UIFont.systemFont(ofSize: 14, weight: .bold)
		self.labelLogin.textAlignment = .center
		
		self.labelLogin.alpha = 0
		
		self.buttonView.addSubview(labelLogin)
		
		self.labelLogin.isUserInteractionEnabled = false
	}
	
	private func desingLabelAcc(){
		
		
//		labelOne.text = localized("login").uppercased()
		
//      labelTwo.text = localized("signupButtonTitle")
//
        let oneLeng = "Нет аккаунта ЗАРЕГЕСТРИРУЙТЕСЬ".count - "ЗАРЕГЕСТРИРУЙТЕСЬ".count
		
		let testLabel = UILabel()
		testLabel.text = "Нет аккаунта ЗАРЕГЕСТРИРУЙТЕСЬ"
		testLabel.font = UIFont(name: ".SFUIText", size: 16)
		
		let testLabelButton = UILabel()
		testLabelButton.text = "ЗАРЕГЕСТРИРУЙТЕСЬ"
		testLabelButton.font = UIFont(name: ".SFUIText", size: 16)
		
		let lenghtLabel = testLabel.lenghtText ?? wDdevice
		let lenghtButton = testLabelButton.lenghtText ?? wDdevice
		
		//MARK: - labelNewAcc
		
		let yPoint: CGFloat = self.frame.height - statusBarHeight - 40
		
		labelNewAcc = UILabel(frame: CGRect(x: xPoint(width: lenghtLabel),
											y: yPoint,
											width: lenghtLabel,
											height: 40))
		
		labelNewAcc.text = "Нет аккаунта ЗАРЕГЕСТРИРУЙТЕСЬ"
		
		labelNewAcc.backgroundColor = UIColor.clear
		labelNewAcc.textAlignment = .center
		
		labelNewAcc.twoStuleLabel(myString: "Нет аккаунта ЗАРЕГЕСТРИРУЙТЕСЬ",
								  oneLenght: oneLeng,
								 tupleSizeFront: (oneSizeFront: 16, twoSizeFront: 16),
								 tupleColor: (oneColor: UIColor.black, twoColor: blueColor))
		
		
		labelNewAcc.alpha = 0
		
		self.addSubview(labelNewAcc)
		
		//MARK: - buttonNewAcc
		
		let xPointButton = xPoint(width: lenghtLabel) + (lenghtLabel - lenghtButton)
		
		buttonNewAcc = UIButton(frame: CGRect(x: xPointButton,
											  y: yPoint,
											  width: lenghtButton,
											  height: 40))
		buttonNewAcc.isEnabled = false
		
		buttonNewAcc.backgroundColor = UIColor.clear
		buttonNewAcc.addTarget(self, action: #selector(actionDownButton), for: .touchUpInside)
		buttonNewAcc.isEnabled = false
		
        self.addSubview(buttonNewAcc)

	}
	
	
	private func xPoint(width: CGFloat) -> CGFloat{
		return (wDdevice - width) / 2
	}
	
	private var finalWidth: CGFloat{
		return wDdevice - 86
	}
	

    func animation(){
		
		UIView.animateKeyframes(withDuration: duration * 2,
								delay: 0,
								options: [],
								animations: {
									
			UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1/2) {
			 
				self.buttonView.frame = CGRect(x: self.xPoint(width: 48),
											   y: self.finalYPosition,
											   width: 48,
											   height: 48)
				
			}
			
									
			UIView.addKeyframe(withRelativeStartTime: 1/2, relativeDuration: 1/2) {
				let width = self.finalWidth
				
				self.buttonView.frame = CGRect(x: self.xPoint(width: width),
											 y: self.finalYPosition,
											 width: width,
											 height: 48)
			}
									
									
		},
		  completion: {[weak self] compl in
			
			if compl, let selF = self {
				selF.animateViewsLabel()
			}
		})


    }
	
	
	private func animateViewsLabel(){
	
		
		UIView.animate(withDuration: duration, animations: {
			self.buttonView.addShadowCustom()
			self.labelLogin.alpha = 1
			self.labelNewAcc.alpha = 1
			
		}, completion: {[weak self] (compl) in
			if compl, let selF = self {
				selF.addTabGestures()
				selF.buttonNewAcc.isEnabled = true
			}
		})
		
	}

		@objc func actionDownButton(sender: UIButton!) {
			print("--новый аккаунт")
		  self.delegate?.tapedButtonNewAcc()
		}

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}


