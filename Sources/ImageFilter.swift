import Foundation
import CoreImage

public typealias Filter = CIImage -> CIImage

infix operator >>> { associativity left }

public func >>> (filter1: Filter, filter2: Filter) -> Filter {
    return { image in
        filter2(filter1(image))
    }
}

public func blur(radius: Double) -> Filter {
    return { image in
        let parameters = [
            kCIInputImageKey: image,
            kCIInputRadiusKey: radius
        ]
        guard let filter = CIFilter(name: "CIGaussianBlur", withInputParameters: parameters) else { fatalError() }
        guard let outputImage = filter.outputImage else { fatalError() }
        return outputImage
    }
}

public func colorGenerator(color: CIColor) -> Filter {
    return { image in
        let parameters = [kCIInputColorKey: color]
        guard let filter = CIFilter(name: "CIConstantColorGenerator", withInputParameters: parameters) else {
            fatalError()
        }
        guard let outputImage = filter.outputImage?.imageByCroppingToRect(image.extent) else { fatalError() }
        return outputImage
    }
}

public func compositeSourceOver(overlay: CIImage) -> Filter {
    return { image in
        let parameters = [
            kCIInputBackgroundImageKey: image,
            kCIInputImageKey: overlay
        ]
        guard let filter = CIFilter(name: "CISourceOverCompositing", withInputParameters: parameters) else { fatalError() }
        guard let outputImage = filter.outputImage else { fatalError() }
        let cropRect = image.extent
        return outputImage.imageByCroppingToRect(cropRect)
    }
}
    