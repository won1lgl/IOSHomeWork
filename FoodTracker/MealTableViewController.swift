//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by Mac on 2019/10/25.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
import os.log

class MealTableViewController: UITableViewController {
    //MARK:Properties
    var meals = [Meal]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //use the edit item provided by the tableview controller
        navigationItem.leftBarButtonItem = editButtonItem
        //Load the sample data
        loadSampleMeals()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "MealTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MealTableViewCell else {
            fatalError("the dequene cell is not an instance of MealTableCell")
        }
        let meal = meals[indexPath.row]
        cell.nameLabel.text = meal.name
        cell.photoImageView.image = meal.photo
        cell.ratingControl.rating = meal.rating

        // Configure the cell...

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            meals.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch segue.identifier ?? "" {
        case "AddItem":
            os_log("add a new meal", log:OSLog.default, type:.debug)
        case "ShowDetail":
            guard let mealDetailViewController = segue.destination as? MealViewController else {
                fatalError("unexpected destination")
            }
            guard let selectedMealCell = sender as? MealTableViewCell else {
                fatalError("unexpected sender")
            }
            guard let indexPath = tableView.indexPath(for: selectedMealCell) else {
                fatalError("the selected cell not being display in the table")
            }
            
            let selectedMeal = meals[indexPath.row]
            mealDetailViewController.meal = selectedMeal
            
        default:
            fatalError("unexpect sender")
        }
    }
    
    
    //MARK: Action
    @IBAction func unwindtoMeallist(sender: UIStoryboardSegue){
        
        if let sourceViewController = sender.source as?
            MealViewController, let meal = sourceViewController.meal{
            //uodate a meal
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                meals[selectedIndexPath.row] = meal
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                //Add a Meal
                let indexPath = IndexPath(row: meals.count, section: 0)
                
                meals.append(meal)
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        }
    }
    
    //MARK: Private function
    private func loadSampleMeals() {
        let photo1 = UIImage(named: "meal1.jpg")
        let photo2 = UIImage(named: "meal2.jpg")
        let photo3 = UIImage(named: "meal3.jpg")
        
        guard let meal1 = Meal(name: "meal1", photo: photo1, rating: 4) else {
            fatalError("failed to instantiate meal1")
        }
        guard  let meal2 = Meal(name: "meal2", photo: photo2, rating: 5) else {
            fatalError("failed to instantiate meal2")
        }
        guard let meal3 = Meal(name: "meal3", photo: photo3, rating: 2) else {
            fatalError("failed to instantiate meal3")
        }
        
        meals += [meal1, meal2, meal3]
    }

}
