//
//  ViewController.swift
//  coreDataTutorial
//
//  Created by Robertson Brito on 11/16/15.
//  Copyright (c) 2015 Ihaba. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController {
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var newName: UITextField!
    
    @IBAction func save(sender: AnyObject) {
        println("*----------------------------*")
        var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context: NSManagedObjectContext = appDel.managedObjectContext!
        var newUser = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: context) as! NSManagedObject
        newUser.setValue(name.text, forKey: "name")
        context.save(nil)
        println("Saved New: \(name.text)")
        
        println("*----------------------------*")
        
    }
    @IBAction func load(sender: AnyObject) {
        
        
        println("*------------List------------*")
        var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context: NSManagedObjectContext = appDel.managedObjectContext!
        var request = NSFetchRequest(entityName: "User")
        request.returnsObjectsAsFaults = false
        var results: NSArray = context.executeFetchRequest(request,error: nil)!
        if results.count > 0 {
            for res in results{
                println(res.valueForKey("name") as! String)
                
            }
        }else{
            
            println("empty!")
            
        }
        println("*----------------------------*")
        
    }
    @IBAction func Delete(sender: AnyObject) {
        var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context: NSManagedObjectContext = appDel.managedObjectContext!
        var locationArray: NSArray = []
        let fetchRequest = NSFetchRequest(entityName:"User")
        let predicate = NSPredicate(format: "name == %@", name.text)
        fetchRequest.predicate = predicate
        
        var error: NSError? = nil
        locationArray = context.executeFetchRequest(fetchRequest,error: &error)!
        for (var i = 0; i < locationArray.count; ++i){
            
            context.deleteObject(locationArray[i] as! NSManagedObject)
            
        }
        if (!context.save(&error)){
            abort()
        }
        context.save(nil)
        
    }
    
    @IBAction func Update(sender: AnyObject) {
        var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        
        var context: NSManagedObjectContext = appDel.managedObjectContext!
        var request = NSFetchRequest(entityName: "User")
        request.returnsObjectsAsFaults = false
        var results: NSArray = context.executeFetchRequest(request,error: nil)!
        for (var i = 0; i < results.count; ++i){
            
            if results[i].valueForKey("name") as! String == name.text {
                
                results[i].setValue(newName.text, forKey: "name")
            }
        }
        context.save(nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

