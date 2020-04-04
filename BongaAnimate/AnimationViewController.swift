//
//  ViewController.swift
//  BongaAnimate
//
//  Created by Hudihka on 03/04/2020.
//  Copyright © 2020 Tatyana. All rights reserved.
//

import UIKit

class AnimationViewController: UIViewController {
	
	private let durationCircle: TimeInterval = 1  //время на врфщения кружков
    private let durationTimeCurrent: TimeInterval = 0.3 //время на подняие шорки
	private var curtain = СurtainView()

	override func viewDidLoad() {
		super.viewDidLoad()
		
		addBacgroundImage()
		addCilklesViews()
		addImageLogo()
		
		addCurtainnView()
		
		
	}
	
	private func addBacgroundImage(){
		
		let image = UIImageView(frame: CGRect(origin: .zero, size: view.frame.size))
		image.image = UIImage(named: "Bacground")
		self.view.addSubview(image)
		
	}
	
// MARK: LOGO
	
    private func addImageLogo(){
        let logoAnimationView = LogoAnimationView(frame: self.view.frame)
        self.view.addSubview(logoAnimationView)
    }
	
//	MARK: CIRKLE
	
	private func addCilklesViews(){
		
		for obj in EnumCircleImage.allCases {
			
			let imageView = obj.imageView
			self.view.addSubview(imageView)
			
			circleAnimation(view: imageView, size: obj)
			
		}
	}
	
	private func circleAnimation(view: UIImageView, size: EnumCircleImage){
		
		let sizeEnum = size.valueEnumSize

        UIView.animate(withDuration: durationCircle) {
			
			view.frame.size = sizeEnum.finishSize
            view.alpha = 1
        }


		let circlePath = sizeEnum.circlePath

        let animation = CAKeyframeAnimation(keyPath: #keyPath(CALayer.position))
        animation.duration = durationCircle
        animation.fillMode = CAMediaTimingFillMode.forwards//kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        animation.path = circlePath.cgPath

        view.layer.add(animation, forKey: nil)

        // circleLayer is only used to locate the circle animation path
        let circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.strokeColor = UIColor.clear.cgColor
        circleLayer.fillColor = UIColor.clear.cgColor
        self.view.layer.addSublayer(circleLayer)
    }
	
	
	//MARK: ШТОРКА
	
	
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
		performSegue(withIdentifier: "PlayNVC", sender: nil)
	}
	
	func tapedButtonNewAcc() {
		let VC = SignUpViewController.route(delegate: self, withinNavigationController: true)
		present(VC, animated: true, completion: nil)
	}
}


extension AnimationViewController: UIViewControllerTransitioningDelegate{
	
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondVC = segue.destination as! LoginViewController
        secondVC.transitioningDelegate = self
        secondVC.modalPresentationStyle = .custom
    }


    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present

        transition.startingPoint = CGPoint(x: wDdevice / 2,
                                           y: hDdevice - 130)
		
        transition.circleColor = UIColor(red: 241.0/255.0,
										 green: 243.0/255.0,
										 blue: 244.0/255.0, alpha: 1)

        return transition
    }
}



extension AnimationViewController: SignUpViewControllerDelegate{
	
	
	
}
