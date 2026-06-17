//
//  LogWorkoutViewController.swift
//  Workout APP
//
//  Created by Mansi Kale on 17/06/26.
//

import UIKit
import CoreData

class LogWorkoutViewController: UIViewController {

    let viewModel = LogWorkoutViewModel()
    
    @IBOutlet weak var saveBtn: UIButton!
    
    @IBOutlet weak var noteField: UITextField!
    @IBOutlet weak var saveWorkoutBTn: UIButton!
    @IBOutlet weak var timerBtn: UIButton!
    
    @IBOutlet weak var distanceTextField: UITextField!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var workoutTypeBtn: UIButton!
    
    var timer: Timer?
    var elapsedSeconds = 0
    var isTimerRunning = false
    
    var workoutType = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Log Workout"
        
        durationLabel.text = "00.00"
        timerBtn.setTitle("▶ Start Timer", for: .normal)
        durationLabel.text = "00.00"
        

      
        
        workoutData()


      
    }

  
    
    
    @IBAction func cancelBtnTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func saveBtnTapped(_ sender: UIButton) {
      
        guard validationWorkout() else { return }
        viewModel.saveWorkoutData(
            workoutType: workoutType,
            notes: noteField.text,
            duration: Int32(elapsedSeconds),
            distance: Int32(distanceTextField.text ?? "") ?? 0
        )

        dismiss(animated: true)
        
    }
    
    @IBAction func saveWorkoutBtnTapped(_ sender: UIButton) {
   
        print("Save Workout")
        guard validationWorkout() else { return }
        viewModel.saveWorkoutData(
            workoutType: workoutType,
            notes: noteField.text,
            duration: Int32(elapsedSeconds),
            distance: Int32(distanceTextField.text ?? "") ?? 0
        )

        dismiss(animated: true)
        
        

    }
    
    func validationWorkout() -> Bool{
        
        guard !workoutType.isEmpty else{
            showAlert(message: "please Select Workout Type")
            return false
        }
        
        guard elapsedSeconds > 0 else{
            showAlert(message: "please Start and Stop the timer")
            return false
        }
        
        print("distance\(distanceTextField.text ?? "")")
        
        guard let distance = distanceTextField.text, !distance.isEmpty else {
            showAlert(message: "Please Enter Distance")
            return false
        }
        
        return true
        
    }
    
    
    @IBAction func timerBtnTapped(_ sender: UIButton) {
        if isTimerRunning {

            
               timer?.invalidate()
               timer = nil

               timerBtn.setTitle("▶ Start Timer", for: .normal)

           } else {

           
               timer = Timer.scheduledTimer(
                   timeInterval: 1.0,
                   target: self,
                   selector: #selector(updateTimer),
                   userInfo: nil,
                   repeats: true
               )

               timerBtn.setTitle("■ Stop", for: .normal)
           }

           isTimerRunning.toggle()
    }
    
    @objc func updateTimer() {

        elapsedSeconds += 1

        let minutes = elapsedSeconds / 60
        let seconds = elapsedSeconds % 60

        durationLabel.text = String(
            format: "%02d:%02d",
            minutes,
            seconds
        )
    }
    
    func workoutData(){
        let running = UIAction(title: "Running") { _ in
            self.workoutType = "Running"
              self.workoutTypeBtn.setTitle("Today's Running Goal", for: .normal)
          }

          let cycling = UIAction(title: "Cycling") { _ in
              self.workoutType = "Cycling"
              self.workoutTypeBtn.setTitle("Today's Cycling Challenge", for: .normal)
          }

          let yoga = UIAction(title: "Yoga") { _ in
              self.workoutType = "Yoga"
              self.workoutTypeBtn.setTitle("Today's Yoga Session", for: .normal)
          }

          let swimming = UIAction(title: "Swimming") { _ in
              self.workoutType = "Swimming"
              self.workoutTypeBtn.setTitle("Today's Swimming Workout", for: .normal)
          }
        let gym = UIAction(title: "Gym") { _ in
            self.workoutType = "GYM"
            self.workoutTypeBtn.setTitle("Today's Workout", for: .normal)
        }

        workoutTypeBtn.menu = UIMenu(children: [
              running,
              cycling,
              yoga,
              swimming,
              gym
          ])

        workoutTypeBtn.showsMenuAsPrimaryAction = true
    }
    
    
    func showAlert(message: String){
        let alert = UIAlertController(title: "Validation", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    

    
}
