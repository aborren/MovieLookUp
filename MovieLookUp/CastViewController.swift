//
//  CastViewController.swift
//  MovieLookUp
//
//  Created by Dan Isacson on 16/07/14.
//  Copyright (c) 2014 dna. All rights reserved.
//

import UIKit

class CastViewController: UIViewController {
    
    var cast: Cast?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = cast?.name
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
