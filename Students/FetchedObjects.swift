//
//  FetchedObjects.swift
//  Students
//
//  Created by Aaron Wright on 11/14/19.
//  Copyright © 2019 Infinite Token. All rights reserved.
//

import SwiftUI
import CoreData

struct FetchedObjects<T, Content>: View where T : NSManagedObject, Content : View {
    
    // MARK: - Properties
    
    let content: ([T]) -> Content
    
    var request: FetchRequest<T>
    var results: FetchedResults<T>{ request.wrappedValue }

    // MARK: - Lifecycle
    
    init(
        predicate: NSPredicate = NSPredicate(value: true),
        sortDescriptors: [NSSortDescriptor] = [],
        @ViewBuilder content: @escaping ([T]) -> Content
    ) {
        self.content = content
        self.request = FetchRequest(
            entity: T.entity(),
            sortDescriptors: sortDescriptors,
            predicate: predicate
        )
    }
    
    // MARK: - Body
    
    var body: some View {
        self.content(results.map { $0 })
    }
    
}
