//
//  WorkoutViewController.swift
//  Workout APP
//
//  Created by Mansi Kale on 17/06/26.
//

import UIKit
import CoreData

class WorkoutViewController: UIViewController {
    let viewModel = WorkoutViewModel()
    
    @IBOutlet weak var workoutTableView: UITableView!
    var workouts: [Workout] = []
    
    var workoutList: [WorkModel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Workouts"
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor(red: 208, green: 188, blue: 155, alpha: 1),
            .font: UIFont.systemFont(ofSize: 24, weight: .bold)
        ]

        loadNibFile()    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let result = viewModel.fetchData()

        self.workouts = result.0
        self.workoutList = result.1

        workoutTableView.reloadData()
    }
    
    func loadNibFile(){
        var nib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        workoutTableView.register(nib, forCellReuseIdentifier: "CustomTableViewCell")
    }

}


extension WorkoutViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workoutList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        


        
        let data = workoutList[indexPath.row]
        
        cell.workoutName.text = data.title
        cell.workoutTime.text = data.subTitle
        cell.workoutimage.image = data.imageName
        
        if data.title == "Running" ||
           data.title == "Cycling" ||
           data.title == "Swimming" {

            cell.workoutInfo.text = "\(data.distance) km"
            cell.workoutDuration.text = "DISTANCE"

        } else {

            let minutes = Int(data.duration) ?? 0

            cell.workoutInfo.text = "\(minutes) min"
            cell.workoutDuration.text = "DURATION"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
    -> UISwipeActionsConfiguration? {

        let deleteAction = UIContextualAction(
            style: .destructive,
            title: "Delete"
        ) { [weak self] _, _, completionHandler in

            guard let self = self else { return }

            let workout = self.workouts[indexPath.row]

            self.viewModel.deleteWorkout(workout)

            self.workouts.remove(at: indexPath.row)
            self.workoutList.remove(at: indexPath.row)

            tableView.deleteRows(at: [indexPath], with: .automatic)

            completionHandler(true)
        }

        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
