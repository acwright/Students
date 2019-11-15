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
    @State var query: String? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                ListView(query: self.query)
                
                Button(action: {
                    self.query = self.query != nil ? nil : "White"
                }) {
                    Text("Filter")
                }
                .frame(maxWidth: .infinity, maxHeight: 60)
                .background(Color.purple)
                .foregroundColor(Color.white)
                
                Button(action: {
                    let firstNames = ["Sally", "Aaron", "Kim", "Joe", "Amy", "Bob"]
                    let lastNames = ["Smith", "Jones", "White", "Jackson", "Hall"]
                    
                    let name = "\(firstNames.randomElement()!) \(lastNames.randomElement()!)"
                    
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
