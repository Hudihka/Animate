//
//  EnumCircleImage.swift
//  BongaAnimate
//
//  Created by Hudihka on 03/04/2020.
//  Copyright © 2020 Tatyana. All rights reserved.
//

import Foundation
import UIKit

enum EnumCircleImage: CaseIterable {
	
	case almostBiggest
	case small
	case almostTheSmallest
	case bigCircle
	
	enum EnumCircleImageSize: CGFloat, CaseIterable {
		case almostBiggest = 20
		case small = 1
		case almostTheSmallest = 10
		case bigCircle = 25
		
		
		var rect: CGRect{
			
			let origin: CGPoint = CGPoint(x: 0.5 * (wDdevice - self.rawValue),
										  y: 0.5 * (hDdevice - self.rawValue))
			
			let size = CGSize(width: self.rawValue,
							  height: self.rawValue)
			
			return CGRect(origin: origin, size: size)
		}
		
		//значения для анимации по кругу
		
		var circlePath: UIBezierPath {
			return UIBezierPath(arcCenter: self.finishPoint,
								radius: self.radius,
								startAngle: self.startAngel,
								endAngle: self.endAngel,
								clockwise: false)
		}
		
		
		
		var finishSize: CGSize {
			
			var k: CGFloat = 1
			let k2 = hDdevice / 667
			
			switch self {
			case .almostBiggest:
				k = 136 * k2
			case .small:
			    k = 18 * k2
			case .almostTheSmallest:
			    k = 69 * k2
			default:
				k = 260 * k2
			}
			
			return CGSize(width: k, height: k)
		}

		
		private var radius: CGFloat {
			
			switch self {
			case .almostBiggest:
				return wDdevice * 0.3
			case .small:
				return hDdevice * 0.15
			case .almostTheSmallest:
			    return hDdevice * 0.197
			default:
				return hDdevice * 0.28
			}
			
		}
		
		private var finishPoint: CGPoint {
			
			switch self {
			case .almostBiggest:
				return CGPoint(x: wDdevice * 0.72, y: hDdevice * 0.5)
			case .small:
				return CGPoint(x: wDdevice * 0.5, y: hDdevice * 0.35)
			case .almostTheSmallest:
			    return CGPoint(x: wDdevice * 0.5, y: hDdevice * 0.303)
			default:
				return CGPoint(x: wDdevice * 0.35, y: hDdevice * 0.22)
			}
			
		}
		
		
		private var startAngel: CGFloat {
			
			if self == .almostBiggest{
				return -3 * .pi / 5
			} else {
				return .pi / 2
			}
			
		}
		
		private var endAngel: CGFloat {
			
			switch self {
			case .almostBiggest:
				return 0
			case .small:
				return -2 * .pi / 3
			case .almostTheSmallest:
			    return -9 * .pi / 20
			default:
				return -3 * .pi / 4
			}
			
		}
		
		
	}
	
	
	private enum NameImage: String, CaseIterable{
		case almostBiggest = "almostBiggest"
		case small = "small"
		case almostTheSmallest = "almostTheSmallest"
		case bigCircle = "bigCircle"
		
		var image: UIImage?{
			return UIImage(named: "bigCircle")
		}
	}
	
	private var activeIndex: Int{
		return EnumCircleImage.allCases.firstIndex(of: self)!
	}
	
	var valueEnumSize: EnumCircleImageSize {
		return EnumCircleImageSize.allCases[activeIndex]
	}
	
	
	var imageView: UIImageView{
		
		let rect = valueEnumSize.rect
		let image = NameImage.allCases[activeIndex].image
		
		let imgView = UIImageView(frame: rect)
		imgView.image = image
		
		return imgView
	
	}
	
	
}

