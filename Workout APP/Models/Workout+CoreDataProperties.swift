//
//  Workout+CoreDataProperties.swift
//  Workout APP
//
//  Created by Mansi Kale on 17/06/26.
//
//

 import Foundation
 import CoreData



extension Workout {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Workout> {
        return NSFetchRequest<Workout>(entityName: "Workout")
    }
    @NSManaged public var imageName: String?
    @NSManaged public var workoutType: String?
    @NSManaged public var duration: Int32
    @NSManaged public var distance: Int32
    @NSManaged public var notes: String?
    @NSManaged public var createdAt: Date?

}

extension Workout : Identifiable {

}
