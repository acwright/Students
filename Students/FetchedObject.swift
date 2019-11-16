//
//  FetchedObject.swift
//  Students
//
//  Created by Aaron Wright on 11/16/19.
//  Copyright © 2019 Infinite Token. All rights reserved.
//

import SwiftUI
import CoreData

struct FetchedObject<T, Content>: View where T : NSManagedObject, Content : View {
    
    // MARK: - Properties
    
    let empty: () -> Content
    let content: (T) -> Content
    
    var request: FetchRequest<T>
    var results: FetchedResults<T>{ request.wrappedValue }

    // MARK: - Lifecycle
    
    init(
        predicate: NSPredicate = NSPredicate(value: true),
        sortDescriptors: [NSSortDescriptor] = [],
        @ViewBuilder empty: @escaping () -> Content,
        @ViewBuilder content: @escaping (T) -> Content
    ) {
        self.empty = empty
        self.content = content
        self.request = FetchRequest(
            entity: T.entity(),
            sortDescriptors: sortDescriptors,
            predicate: predicate
        )
    }
    
    // MARK: - Body
    
    var body: some View {
        if let result = results.first {
            return self.content(result)
        } else {
            return self.empty()
        }
    }
    
}
