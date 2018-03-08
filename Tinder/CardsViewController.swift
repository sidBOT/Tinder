//
//  CardsViewController.swift
//  Tinder
//
//  Created by siddhant on 3/8/18.
//  Copyright © 2018 siddhant. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {

    @IBOutlet weak var photoView: UIImageView!
    var cardInitialCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.photoView.layer.cornerRadius = 10
        self.photoView.clipsToBounds = true
    
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(cardDraggable(_:)))
    
        photoView.isUserInteractionEnabled = true
        photoView.addGestureRecognizer(panGestureRecognizer)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func cardDraggable(_ sender: UIPanGestureRecognizer) {
        
        let location = sender.location(in: view)
        //let velocity = sender.velocity(in: view)
        let translation = sender.translation(in: view)
        
        if sender.state == .began {
            cardInitialCenter = photoView.center
            print("Gesture began")
        } else if sender.state == .changed {
            if (location.y < photoView.frame.height/2)
            { photoView.center = CGPoint(x: cardInitialCenter.x + translation.x, y: cardInitialCenter.y)
                photoView.transform = CGAffineTransform(rotationAngle: CGFloat(Double(translation.x) * M_PI / 560))
            }
            else {
                photoView.center = CGPoint(x: cardInitialCenter.x + translation.x, y: cardInitialCenter.y)
                photoView.transform = CGAffineTransform(rotationAngle: CGFloat(-1.0 * Double(translation.x) * M_PI / 560))
            }
            
            if(translation.x > 175 || translation.x < -175) {
                UIView.animate(withDuration: 0.4, animations: {
                    self.photoView.alpha = 0
                })
            }
            print("Gesture is changing")
        } else if sender.state == .ended {
            photoView.center = CGPoint(x: cardInitialCenter.x, y: cardInitialCenter.y)
            photoView.transform = CGAffineTransform(rotationAngle: CGFloat(0.0))
            print("Gesture ended")
        }
        
    }
    
    
    @IBAction func tappedPicture(_ sender: Any) {
        self.performSegue(withIdentifier: "profile", sender: sender)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
    
    
    
}
