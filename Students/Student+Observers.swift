//
//  Student+Observers.swift
//  Students
//
//  Created by Aaron Wright on 11/16/19.
//  Copyright © 2019 Infinite Token. All rights reserved.
//

import Foundation
import CoreData

extension Student {
    
    override public func willChangeValue(forKey key: String) {
        super.willChangeValue(forKey: key)
        self.objectWillChange.send()
    }
    
}
