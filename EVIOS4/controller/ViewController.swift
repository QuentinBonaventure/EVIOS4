//
//  ViewController.swift
//  EVIOS4
//
//  Created by Quentin Bona on 10/10/2022.
//

import UIKit
import CoreData


class ViewController: UIViewController {
 
    private let context = AppDelegate.shared.persistentContainer.viewContext
    
    @IBOutlet var expenseTabView: UITableView!{
        didSet{
            expenseTabView.dataSource = self
            expenseTabView.delegate = self
            expenseTabView.register(UINib(nibName: "ExpenseTableViewCell", bundle: .main), forCellReuseIdentifier: ExpenseTableViewCell.identifier)
        }
    }
    
    @IBOutlet var addExpenseBtn: UIButton!
   
    private var listExpense: [Entity] = [Entity](){
        didSet{
            expenseTabView.reloadData()
        }
    }
    
    
    

    @IBAction func toAddExpense(_ sender: Any) {
        let addNewExpenseController = storyboard?.instantiateViewController(withIdentifier: AddViewController.identifier) as? AddViewController
        addNewExpenseController?.delegate = self
        addNewExpenseController?.modalPresentationStyle = .automatic
        present(addNewExpenseController!, animated: true, completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadFromCoreData()
        
       // listExpense.append(Expense(name: "Spagettis", date: Date.now, value: 10.50))
        //listExpense.append(Expense(name: "Hamburger", date: Date.now, value: 5.00))
       
       
        
     //   listExpense.append(Expense(name: "Courses", date: 27/05/1990, value: 10.04))
        // Do any additional setup after loading the view.
    }
    
    func commitData(){
        do {
            try context.save()
            //delegate?.didAddView()
            dismiss(animated: true)
        } catch {
            print("Can't save to Core Data!")
            context.rollback()
        }

    }
    
    
    func loadFromCoreData(){
        let request = Entity.fetchRequest()
        let orderByDate = NSSortDescriptor(key: "date", ascending: true)
        request.sortDescriptors = [orderByDate]
        
        do{
            listExpense = try context.fetch(request)
            
        }catch {
            print("Can't fetch from core data")
        }
    }
    
    
    


}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listExpense.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ExpenseTableViewCell.identifier, for: indexPath) as? ExpenseTableViewCell
        else {
           fatalError("unable to dequeue ExpenseTableViewCell")
        }
        cell.setupCell(expense: listExpense[indexPath.row])
        return cell
    }
    
    
}

extension ViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        context.delete(listExpense[indexPath.row])
        loadFromCoreData()
        commitData()
        

        
    }
    
}

extension ViewController: AddViewDelegate{
    func didAddView() {
        loadFromCoreData()
    }
    
    
}

    
    


