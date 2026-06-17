//
//  HomeViewController.swift
//  Workout APP
//
//  Created by Mansi Kale on 17/06/26.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {

    let viewModel = HomeViewModel()

    @IBOutlet weak var activeMinutesLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var scrollViewHeightConstraints: NSLayoutConstraint!
    
    var latestWorkout: Workout?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeViewHeight = UIScreen.main.bounds.height
        
        if homeViewHeight > scrollViewHeightConstraints.constant{
            scrollViewHeightConstraints.constant = homeViewHeight
        }
        
        loadNibFile()
    
 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchData()
        
        latestWorkout = viewModel.latestWorkout

        let stats = viewModel.calculateStats()

        activeMinutesLabel.text = "\(stats.minutes)"
        caloriesLabel.text = "\(stats.calories)"

        homeTableView.reloadData()
    }
    
    func loadNibFile(){
        var nib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        homeTableView.register(nib, forCellReuseIdentifier: "CustomTableViewCell")
    }

    @IBAction func viewAllBtnTapped(_ sender: UIButton) {
        print("ok")
        let vc = storyboard?.instantiateViewController(withIdentifier: "WorkoutViewController") as! WorkoutViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
  
    @IBAction func addBtnTapped(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "LogWorkoutViewController") as! LogWorkoutViewController
        
        if let sheet = vc.sheetPresentationController {sheet.detents = [.medium(), .large()]
            
            sheet.selectedDetentIdentifier = .large
            sheet.prefersGrabberVisible = true
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
        }
        present(vc, animated: true)
    }
    
    
}




extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return latestWorkout == nil ? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        guard let workout = latestWorkout else {
            return cell
        }

        cell.workoutName.text = workout.workoutType

            let formatter = DateFormatter()
            formatter.dateFormat = "MMM d, h:mm a"
            cell.workoutTime.text = formatter.string(from: workout.createdAt ?? Date())

            switch workout.workoutType {

            case "Running":
                cell.workoutimage.image = UIImage(named: "running")

            case "Cycling":
                cell.workoutimage.image = UIImage(named: "cycling")

            case "Yoga":
                cell.workoutimage.image = UIImage(named: "yoga")

            case "Swimming":
                cell.workoutimage.image = UIImage(named: "swimming")

            case "GYM":
                cell.workoutimage.image = UIImage(named: "dumbell")

            default:
                cell.workoutimage.image = UIImage(named: "running")
            }

            if workout.workoutType == "Running" ||
               workout.workoutType == "Cycling" ||
               workout.workoutType == "Swimming" {

                cell.workoutInfo.text = "\(workout.distance) km"
                cell.workoutDuration.text = "DISTANCE"

            } else {

                let minutes = Int(workout.duration) 

                cell.workoutInfo.text = "\(minutes) min"
                cell.workoutDuration.text = "DURATION"
            }

            return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
