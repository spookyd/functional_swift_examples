//: [Previous](@previous)

import XCPlayground
import Foundation
import UIKit
import CoreImage

let blurRadius: Double = 5
let overlayColor = UIColor.redColor().colorWithAlphaComponent(0.2)
let img = CIImage(image: [#Image(imageLiteral: "0808091202b.jpg")#])
let blurImg = blur(blurRadius)(img!)
let color = CIColor(color: overlayColor)
let colorImage = colorGenerator(color)(blurImg)
let overlay = compositeSourceOver(colorImage)(img!)

/**
 ## Custom Operator
 We have defined a custom filter operator for combining two filters
 */
let filter1 =  colorGenerator(color) >>> blur(blurRadius)
let filteredImage = filter1(img!)



//: [Next](@next)
