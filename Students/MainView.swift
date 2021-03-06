//
//  MainView.swift
//  Students
//
//  Created by Aaron Wright on 11/14/19.
//  Copyright © 2019 Infinite Token. All rights reserved.
//

import SwiftUI
import CoreData

struct MainView: View {
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    @State var predicate: NSPredicate = NSPredicate(value: true)
    @State var query: String? = nil
    
    let firstNames = ["Sally", "Aaron", "Kim", "Joe", "Amy", "Bob"]
    let lastNames = ["Smith", "Jones", "White", "Jackson", "Hall"]
    
    var sortDescriptors: [NSSortDescriptor] {
        [NSSortDescriptor(keyPath: \Student.name, ascending: true)]
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                FetchedObjects(
                    predicate: self.predicate,
                    sortDescriptors: self.sortDescriptors)
                { (students: [Student]) in
                    List {
                        ForEach(students) { student in
                            Text(student.name ?? "NA")
                        }
                    }
                }
                
                Text("Filter: \(self.query ?? "All")")
                    .frame(maxWidth: .infinity, maxHeight: 60)
                    .background(Color.green)
                    .foregroundColor(Color.white)
                
                FetchedObject(
                    predicate: self.predicate,
                    sortDescriptors: self.sortDescriptors,
                    empty: {
                        Text("Found: No Student")
                            .frame(maxWidth: .infinity, maxHeight: 60)
                            .background(Color.pink)
                            .foregroundColor(Color.white)
                    }
                ) { (student: Student) in
                    Text("Found: \(student.name ?? "")")
                        .frame(maxWidth: .infinity, maxHeight: 60)
                        .background(Color.pink)
                        .foregroundColor(Color.white)
                }
                
                Divider()
                    .padding([.top, .bottom])
                
                HStack(spacing: 0) {
                    Button(action: {
                        self.query = self.lastNames.randomElement()
                        self.predicate = NSPredicate(format: "%K contains[cd] %@", #keyPath(Student.name), self.query!)
                    }) {
                        Text("Filter")
                    }
                    .frame(maxWidth: .infinity, maxHeight: 60)
                    .background(Color.purple)
                    .foregroundColor(Color.white)
                    
                    Button(action: {
                        self.query = nil
                        self.predicate = NSPredicate(value: true)
                    }) {
                        Text("All")
                    }
                    .frame(maxWidth: 60, maxHeight: 60)
                    .background(Color.red)
                    .foregroundColor(Color.white)
                }
                
                Button(action: {
                    let name = "\(self.firstNames.randomElement()!) \(self.lastNames.randomElement()!)"
                    
                    let student = Student(context: self.managedObjectContext)
                    student.id = UUID()
                    student.name = name
                    
                    try? self.managedObjectContext.save()
                }) {
                    Text("Add")
                }
                .frame(maxWidth: .infinity, maxHeight: 60)
                .background(Color.blue)
                .foregroundColor(Color.white)
            }
            .navigationBarTitle(Text("Students"))
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        MainView()
    }
    
}
