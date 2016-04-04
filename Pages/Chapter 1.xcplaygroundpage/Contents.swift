////: Playground - noun: a place where people can play
//
import UIKit

typealias Distance = Double

struct Position {
    var x: Double
    var y: Double
}

extension Position {
    var length: Distance {
        get {
            return sqrt(x * x + y + y)
        }
    }
    func minus(p: Position) -> Position {
        return Position.init(x: x - p.x, y: y - p.y)
    }
    func add(p: Position) -> Position {
        return Position(x: x + p.x, y: y + p.y)
    }
}

typealias Region = Position -> Bool

//struct Region {
//    
//    let lookup: Position -> Bool
//    
//}

func circle(radius: Distance) -> Region {
    return { point in point.length <= radius }
}

func circle2(radius: Distance, center: Position) -> Region {
    return { point in point.minus(center).length <= radius }
}

func shift(region: Region, offset: Position) -> Region {
    return { point in region(point.minus(offset)) }
}

func invert(region: Region) -> Region {
    return { point in !region(point) }
}

func intersection(region: Region, _ region2: Region) -> Region {
    return { point in region(point) && region2(point) }
}

func union(region: Region, _ region2: Region) -> Region {
    return { point in region(point) && region2(point) }
}

func difference(region: Region, minus: Region) -> Region {
    return intersection(region, invert(minus))
}

struct Ship {
    var position: Position
    var firingRange: Distance
    var unsafeRange: Distance
}

extension Ship {
    
    func canEngage(target: Ship, friendlyShip: Ship) -> Bool {
        let rangeRegion = difference(circle(firingRange), minus: circle(unsafeRange))
        let firingRegion = shift(rangeRegion, offset: position)
        let friendlyRegion = shift(circle(unsafeRange), offset: friendlyShip.position)
        let resultRegion = difference(firingRegion, minus: friendlyRegion)
        return resultRegion(target.position)
    }
    
}

let me = Ship(position: Position(x: 0, y:0), firingRange: 250, unsafeRange: 50)
let friendly = Ship(position: Position(x: 230, y:1), firingRange: 250, unsafeRange: 50)
let target = Ship(position: Position(x: 250, y: 0), firingRange: 150, unsafeRange: 500)
me.canEngage(target, friendlyShip: friendly)


//: [Next](@next)
