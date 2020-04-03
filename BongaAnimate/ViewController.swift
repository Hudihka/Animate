//
//  ViewController.swift
//  BongaAnimate
//
//  Created by Hudihka on 03/04/2020.
//  Copyright © 2020 Tatyana. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
    let durationTimeCurrent: TimeInterval = 0.3 //время на подняие шорки
	var curtain = СurtainView()

	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.view.backgroundColor = UIColor.red
		
		addCurtainnView()
		
	}
	
	//ШТОРКА
	
	
	private func addCurtainnView() {
		
		let h = hDdevice * 0.35
		
		curtain.frame = CGRect(x: 0,
							   y: hDdevice,
							   width: wDdevice,
							   height: h)
		
		self.view.addSubview(curtain)
		
		curtain.addView()
		curtain.delegate = self
		
		let k: CGFloat = isIPhoneXorXmax ? 44 : 0
		
		UIView.animate(withDuration: self.durationTimeCurrent,
					   delay: 1.5,
					   options: [], animations: {
						self.curtain.frame = CGRect(x: 0,
													y: hDdevice - h,
													width: wDdevice,
													height: h + k)
		}, completion: {[weak self] (compl) in
			if compl, let selF = self{
				selF.curtain.animation()
			}
		})
	}
	
	
	


}




extension ViewController: СurtainViewDelegate {
	func tapedButton() {
		///
	}
	
	func tapedButtonNewAcc() {
		////
	}
}
