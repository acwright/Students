//
//  ListView.swift
//  Students
//
//  Created by Aaron Wright on 11/14/19.
//  Copyright © 2019 Infinite Token. All rights reserved.
//

import SwiftUI
import CoreData

struct ListView<T, Content>: View where T : Identifiable, T : NSManagedObject, Content : View {
    
    let content: (T) -> Content
    
    var request: FetchRequest<T>
    var results: FetchedResults<T>{ request.wrappedValue }

    init(
        predicate: NSPredicate = NSPredicate(value: true),
        sortDescriptors: [NSSortDescriptor] = [],
        @ViewBuilder content: @escaping (T) -> Content
    ) {
        self.content = content
        self.request = FetchRequest(
            entity: T.entity(),
            sortDescriptors: sortDescriptors,
            predicate: predicate
        )
    }
    
    var body: some View {
        List {
            ForEach(results) { result in
                self.content(result)
            }
        }
    }
    
}

struct ListView_Previews: PreviewProvider {
    
    static var previews: some View {
        ListView() { (student: Student) in
            Text(student.name ?? "Unknown")
        }
    }
    
}
