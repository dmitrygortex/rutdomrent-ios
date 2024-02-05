import Foundation
import UIKit

extension UIView {
    
    open func disintegrate(direction: DisintegrationDirection = DisintegrationDirection.random(),
                           estimatedTrianglesCount: Int = 66,
                           completion: (() -> ())? = nil) {
        self.layer.disintegrate(direction: direction,
                                estimatedTrianglesCount: estimatedTrianglesCount,
                                completion: completion)
    }

}
