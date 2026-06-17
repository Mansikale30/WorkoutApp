//
//  WorkoutViewModel.swift
//  Workout APP
//
//  Created by Mansi Kale on 17/06/26.
//

import Foundation
import UIKit
import CoreData

class WorkoutViewModel {
    
    func fetchData()-> ([Workout], [WorkModel]) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request : NSFetchRequest<Workout> = Workout.fetchRequest()
        var workoutList: [WorkModel] = []
        
        do {
            
            request.sortDescriptors = [
                NSSortDescriptor(key: "createdAt", ascending: false)
            ]
            
            let workouts = try context.fetch(request)
       
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM d, h:mm a"
            
            
            for workout in workouts{
                
                var image = UIImage(named: "running")

                 switch workout.workoutType {

                 case "Running":
                     image = UIImage(named: "running")

                 case "Cycling":
                     image = UIImage(named: "cycling")

                 case "Yoga":
                     image = UIImage(named: "yoga")

                 case "Swimming":
                     image = UIImage(named: "swimming")

                 case "GYM":
                     image = UIImage(named: "dumbell")

                 default:
                     break
                 }
             
                let model = WorkModel(imageName: image, title: workout.workoutType ?? "", subTitle: formatter.string(from: workout.createdAt ?? Date()), distance: "\(workout.distance)", duration: "\(workout.duration)")
                workoutList.append(model)
            }

            return (workouts, workoutList)
         
        }catch{
            return ([], [])
        }
    }
    
    
    func deleteWorkout(_ workout: Workout) {

        let context = (UIApplication.shared.delegate as! AppDelegate)
            .persistentContainer.viewContext

        context.delete(workout)

        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
