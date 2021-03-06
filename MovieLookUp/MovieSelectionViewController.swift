//
//  MovieSelectionViewController.swift
//  MovieLookUp
//
//  Created by Dan Isacson on 16/07/14.
//  Copyright (c) 2014 dna. All rights reserved.
//

import UIKit
import CoreData

class MovieSelectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    //Variables
    var movies : [Movie] = []
    
    @IBOutlet var movieCollectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(false)
        setUpMovies()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "SelectionToMovie"){
            var movieViewController: MovieViewController = segue.destinationViewController as! MovieViewController
            let movieIndex = movieCollectionView!.indexPathForCell(sender as! UICollectionViewCell)!.row
            var selectedMovie = self.movies[movieIndex]
            movieViewController.movie = selectedMovie
        }else if(segue.identifier == "SenseiScramble"){
            if(movies.count > 0){
                var randomizedViewController: RandomizedViewController = segue.destinationViewController as! RandomizedViewController
                let rndNum = Int(arc4random_uniform(UInt32(movies.count)))
                let rndMovie: Movie = movies[rndNum]
                randomizedViewController.movie = rndMovie
            }
        }
        
    }
    
    func setUpMovies(){
        movies = []
        let appDel : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context : NSManagedObjectContext = appDel.managedObjectContext!
        
        let request = NSFetchRequest(entityName: "MovieSelection")
        request.returnsObjectsAsFaults = false
        
        var results : NSArray = context.executeFetchRequest(request, error: nil)!
        if( results.count > 0){
            for res in results{
                let movie : Movie = Movie()
                movie.imgURL = (res as! MovieSelection).posterurl
                movie.bgURL = movie.imgURL
                movie.title = (res as! MovieSelection).name
                movie.id = (res as! MovieSelection).id.toInt()
                movies.append(movie)
            }
        }
        movieCollectionView!.reloadData()
    }

    
    //CollectionView
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return movies.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("MovieSelectionCell", forIndexPath: indexPath) as! UICollectionViewCell
        let movie: Movie = movies[indexPath.row]
        let poster: UIImageView = cell.viewWithTag(300) as! UIImageView
        if let url = movie.imgURL {
            poster.sd_setImageWithURL(NSURL(string: url), placeholderImage: UIImage(named: "default.jpeg"), completed: { (image, error, cacheType, url) -> Void in
                if(cacheType == SDImageCacheType.None){
                    let anim: CATransition = CATransition()
                    anim.duration = 1.2
                    anim.type = kCATransitionFade
                    anim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
                    anim.removedOnCompletion = false
                    poster.layer.addAnimation(anim, forKey: "Transition")}
            })
        }else {
            poster.image = UIImage(named: "default.jpeg")
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let w = collectionView.frame.width / 3 - 14
        let h = w * 1.5
        return CGSize(width: w, height: h)
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
