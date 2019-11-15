//
//  ListView.swift
//  Students
//
//  Created by Aaron Wright on 11/14/19.
//  Copyright © 2019 Infinite Token. All rights reserved.
//

import SwiftUI

struct ListView: View {
    
    var query: String?
    var studentsRequest: FetchRequest<Student>
    var students: FetchedResults<Student>{ studentsRequest.wrappedValue }

    init(query: String? = nil) {
        self.query = query
        self.studentsRequest = FetchRequest(
            entity: Student.entity(),
            sortDescriptors: [
                NSSortDescriptor(keyPath: \Student.name, ascending: true)
            ],
            predicate: query != nil ? NSPredicate(format: "%K contains[cd] %@", #keyPath(Student.name), query!) : NSPredicate(value: true)
        )
    }
    
    var body: some View {
        List {
            ForEach(self.students, id: \.id) { student in
                Text(student.name ?? "Unknown")
            }
        }
    }
    
}

struct ListView_Previews: PreviewProvider {
    
    static var previews: some View {
        ListView(query: "White")
    }
    
}
