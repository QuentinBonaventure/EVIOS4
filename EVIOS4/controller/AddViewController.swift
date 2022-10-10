//
//  AddViewController.swift
//  EVIOS4
//
//  Created by Quentin Bona on 10/10/2022.
//

import UIKit
import CoreData

protocol AddViewDelegate: AnyObject{
    func didAddView()
    
}

class AddViewController: UIViewController {
    var delegate : AddViewDelegate?
    
    @IBOutlet var nameTextField: UITextField!
    
    
    @IBOutlet var valueTextField: UITextField!
    
    static let identifier = "AddViewController"
    private let context = AppDelegate.shared.persistentContainer.viewContext
    
  

    
    @IBAction func saveData(_ sender: Any) {
        
            let newExpense = Entity(context: context)
            newExpense.name = nameTextField.text
            newExpense.value = Float(valueTextField.text!)!
        
        commitData()
        
        
        
        
    }
    
    
    func commitData(){
        do {
            try context.save()
            delegate?.didAddView()
            dismiss(animated: true)
        } catch {
            print("Can't save to Core Data!")
            context.rollback()
        }

    }
    @IBAction func toFirstViewController(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
