//
//  TimerUtilities.swift
//  Each
//
//  Created by Luca D'Alberti on 10/24/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import Foundation

// MARK: - Weak Timer implementation
// MARK: - ClosureWrapper declaration
private class ClosureWrapper<T> {
    
    let closure : T
    
    init (_ closure: T) {
        self.closure = closure
    }
}

// MARK: - Weak timer methods
extension Timer {
    
    /// Creates a weak `Timer` instance ready to use
    ///
    /// - parameter ti:      Time interval
    /// - parameter repeats: Repeats or not
    /// - parameter closure: Closure to execute
    ///
    /// - returns: Returns a `Timer` instance weak referenced
    static func weak_scheduledTimerWithTimeInterval(ti: TimeInterval, repeats: Bool, closure: ()->()) -> Timer {
        return self.scheduledTimer(
            timeInterval: ti,
            target: self,
            selector: #selector(Timer._weak_blockInvoke(timer:)),
            userInfo: ClosureWrapper(closure),
            repeats: repeats
        )
    }
    
    @objc private static func _weak_blockInvoke(timer: Timer) {
        if let wrapper = timer.userInfo as? ClosureWrapper<()->()> {
            wrapper.closure()
        }
    }
}
