//
//  Constant.swift
//  BongaAnimate
//
//  Created by Hudihka on 03/04/2020.
//  Copyright © 2020 Tatyana. All rights reserved.
//

import Foundation
import UIKit

let hDdevice = UIScreen.main.bounds.size.height
let wDdevice = UIScreen.main.bounds.size.width

let blueColor = UIColor(red: 6/255,
						green: 134/255,
						blue: 242/255,
						alpha: 1)

let blueColorPress = UIColor(red: 3.0/255,
							 green: 110.0/255,
							 blue: 203.0/255,
							 alpha: 1)


var isIPhoneXorXmax: Bool {
    return hDdevice >= 812
}

var isIPhone5: Bool {
    return hDdevice == 568
}

var statusBarHeight: CGFloat{
    return isIPhoneXorXmax ? 44 : 20
}
