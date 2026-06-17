//
//  LogWorkoutViewModel.swift
//  Workout APP
//
//  Created by Mansi Kale on 17/06/26.
//

import Foundation
import CoreData
import UIKit

class LogWorkoutViewModel {
    
    
    func saveWorkoutData(workoutType: String, notes: String?, duration: Int32, distance: Int32){

        
        let context = (UIApplication.shared.delegate as! AppDelegate)
            .persistentContainer.viewContext


        let workout = Workout(context: context)
 
        workout.workoutType = workoutType
        workout.notes = notes
        workout.duration = duration
        workout.distance = distance
        workout.createdAt = Date()
        
        do {
            try context.save()
        }catch{
            print(error.localizedDescription)
        }
       
    }
    
}
