//
//  CanvasViewController.swift
//  Canvas
//
//  Created by YangSzu Kai on 2017/3/23.
//  Copyright © 2017年 ArcCotagent. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController, UIGestureRecognizerDelegate {

    var trayOriginalCenter: CGPoint!
    
    @IBOutlet weak var trayView: UIView!
    
    
    var trayDownOffset: CGFloat!
    var trayUP: CGPoint!
    var trayDown: CGPoint!
    var newlyCreatedFace: UIImageView!
    var newlyCreatedFaceOriginalCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        trayDownOffset = 188
        trayUP = trayView.center
        trayDown = CGPoint(x: trayView.center.x, y: trayView.center.y + trayDownOffset)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPanFace(_ sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: view)
        
        if(sender.state == .began){
            let imageView = sender.view as! UIImageView
            newlyCreatedFace = UIImageView(image: imageView.image)
            view.addSubview(newlyCreatedFace)
            newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.y += trayView.frame.origin.y
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            
            //Make it bag when clicked
            UIView.animate(withDuration: 0.2, animations: { 
                self.newlyCreatedFace.transform = CGAffineTransform(scaleX: 1.8, y: 1.8)
            })
            
            //Add gestrue to the face
            let gesture = UIPanGestureRecognizer(target: self, action: #selector(didPanCavas(sender:)))
            let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(didPinchCanvas(sender:)))
            pinchGestureRecognizer.delegate = self;
            
            newlyCreatedFace.addGestureRecognizer(gesture)
            newlyCreatedFace.addGestureRecognizer(pinchGestureRecognizer)
            newlyCreatedFace.isUserInteractionEnabled = true
            
        }
        
        if(sender.state == .changed){
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
        }
        
        if(sender.state == .ended){
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: [], animations: { 
                self.newlyCreatedFace.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            }, completion: nil)
        }
    }
    
    
    @IBAction func didPanTray(_ sender: UIPanGestureRecognizer) {
        
       // let translation = sender.translation(in: view)
        
        if sender.state == .began{
            trayOriginalCenter = trayView.center
        }
        if sender.state == .changed{
            
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y )
            
        }
        if sender.state == .ended{
            let velocity = sender.velocity(in: view)
            
           //Moving down
            if (velocity.y > 0){
                
                UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: [], animations: { 
                    self.trayView.center = self.trayDown
                }, completion: nil)
                
                
            }/*Moving up*/else{
                UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: [], animations: { 
                    self.trayView.center = self.trayUP
                }, completion: nil)
                
            }
        }
    }

    func didPanCavas(sender: UIPanGestureRecognizer){
        
        let translation = sender.translation(in: view)
        
        if sender.state == .began{
        newlyCreatedFace = sender.view as! UIImageView
        newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            UIView.animate(withDuration: 0.2, animations: {
                self.newlyCreatedFace.transform = CGAffineTransform(scaleX: 2, y: 2)
            })
        }
        if sender.state == .changed{
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
            
        }
        if sender.state == .ended{
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: [], animations: {
                self.newlyCreatedFace.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            }, completion: nil)
        }
    }
    
    //Make the face big with two fingers
    func didPinchCanvas(sender: UIPinchGestureRecognizer){
        
        let scale = sender.scale
        newlyCreatedFace.transform = CGAffineTransform(scaleX: scale, y: scale)
        
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        return true
    }
    
    
       /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
