import Foundation

public enum DisintegrationDirection: Int {

    case up
    case down
    case left
    case right
    case upperLeft
    case upperRight
    case lowerLeft
    case lowerRight
    
    public static func random() -> DisintegrationDirection {
        return DisintegrationDirection(rawValue: Int.random(in: 0 ..< 8)) ?? .upperLeft
    }

}
