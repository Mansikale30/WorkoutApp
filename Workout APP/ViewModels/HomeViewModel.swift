//
//  HomeViewModel.swift
//  Workout APP
//
//  Created by Mansi Kale on 17/06/26.
//

import Foundation
import CoreData
import UIKit

class HomeViewModel {
    
    var latestWorkout: Workout?
    
    func fetchData() {

        let context = (UIApplication.shared.delegate as! AppDelegate)
            .persistentContainer.viewContext

        let request: NSFetchRequest<Workout> = Workout.fetchRequest()

        do {

            let workouts = try context.fetch(request)

            latestWorkout = workouts.last

        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    func calculateStats() -> (minutes: Int, calories: Int) {

        let context = (UIApplication.shared.delegate as! AppDelegate)
            .persistentContainer.viewContext

        let request: NSFetchRequest<Workout> = Workout.fetchRequest()
        
        var totalMinutes = 0
        var totalCalories = 0

        do {

            let workouts = try context.fetch(request)

            for workout in workouts {
                

                let minutes = Int(workout.duration)
                print("Minutes:", minutes)

                totalMinutes += minutes

                switch workout.workoutType {

                case "Running":
                    totalCalories += minutes * 10

                case "Cycling":
                    totalCalories += minutes * 8

                case "Yoga":
                    totalCalories += minutes * 4

                case "Swimming":
                    totalCalories += minutes * 11

                case "GYM":
                    totalCalories += minutes * 7

                default:
                    break
                }
            }

 

        } catch {
            print(error.localizedDescription)
        }
        return (totalMinutes, totalCalories)
    }
    
}
