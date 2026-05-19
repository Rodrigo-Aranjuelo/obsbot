import Foundation

enum PTZDirection {
    case up, down, left, right
    case upLeft, upRight, downLeft, downRight
    case stop
}

enum ZoomCommand {
    case zoomIn
    case zoomOut
    case stop
}
