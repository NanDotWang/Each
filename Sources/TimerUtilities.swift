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
    
    static func weak_scheduledTimerWithTimeInterval(ti: TimeInterval, repeats: Bool, closure: ()->()) -> Timer {
        return self.scheduledTimer(
            timeInterval: ti,
            target: self,
            selector: #selector(Timer.weak_blockInvoke(timer:)),
            userInfo: ClosureWrapper(closure),
            repeats: repeats
        )
    }
    
    @objc static func weak_blockInvoke(timer: Timer) {
        if let wrapper = timer.userInfo as? ClosureWrapper<()->()> {
            wrapper.closure()
        }
    }
}
