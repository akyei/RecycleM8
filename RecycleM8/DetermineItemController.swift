//
//  DetermineItem.swift
//  RecycleM8
//
//  Created by Alexander Kyei on 4/9/16.
//  Copyright © 2016 Alexander Kyei. All rights reserved.
//

import Foundation
import UIKit



class DetermineItemController: UIViewController, NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDataDelegate, UITableViewDelegate, UITableViewDataSource {
    var image:UIImage!
    var responseData = NSMutableData()
    var predictions = []
    
    @IBOutlet weak var sentImage: UIImageView!
    @IBOutlet weak var Spinner: UIActivityIndicatorView!
    @IBOutlet var predictionTable: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "vvCustomTableViewCell", bundle: nil)
        
        predictionTable.registerNib(nib, forCellReuseIdentifier: "cell")
        
        
        
        //self.predictionTable.registerClass(CustomTableViewCell.self, forCellReuseIdentifier: "customCell")
       
    }
    override func viewWillAppear(true: Bool){
        
        let boundary = generateBoundaryString()
        let request = NSMutableURLRequest(URL: NSURL(string: "https://api.projectoxford.ai/vision/v1.0/tag")!)
        //var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        let imgdata: NSData = UIImagePNGRepresentation(image.imageWithSize(CGSizeMake(700, 700)))!
        let selectedImageSize: Int = imgdata.length
        print("Image Size: %f KB", Double(selectedImageSize) / 1024.0)
        
        //let imageData:NSData = UIImagePNGRepresentation(image)
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.setValue("b9e5285d58d743539cc5e88685502010", forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        request.HTTPBody = createBodyWithParameters(imgdata, boundary: boundary)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200 ){
                
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? NSDictionary
                    print(json)
                    
                    if let tags = json!["tags"] as? NSArray {
                        self.predictions = tags
                        print(tags)
                        if !(tags.count <= 0) {
                            self.image = UIImage(named: "sadOutline")
                        }
                    
                    }
                } catch {
                    print("Error with Json: \(error)")
                }
            }
            
            // You can print out response object
            print("******* response = \(response)")
            
            // Print out reponse body
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("****** response data = \(responseString!)")
            
            
            
            dispatch_async(dispatch_get_main_queue(),{
                self.predictionTable.reloadData()
                //self.Spinner.hidesWhenStopped = true
                self.Spinner.stopAnimating()
                //self.sentImage.image = self.image;
            });
            
            
            
        }
        task.resume()
    }
    
    override func viewDidAppear(true: Bool) {
        Spinner.startAnimating();
    }
    
    func createBodyWithParameters(imageDataKey: NSData, boundary: String) -> NSData {
        let body = NSMutableData();
        let mimetype = "image/jpeg"
        
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"test\"\r\n")
        body.appendString("Content-Type: \(mimetype)\r\n\r\n")
        body.appendData(imageDataKey)
        body.appendString("\r\n")
        body.appendString("--\(boundary)--\r\n")
        return body
    }
    
    func generateBoundaryString() -> String{
        return "Boundary-\(NSUUID().UUIDString)"
    }
    
   
    
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?){
        if error != nil {
            print("Session \(session) occured error \(error?.localizedDescription)")
        } else {
            print("session \(session) upload completed, response: \(NSString(data: responseData, encoding: NSUTF8StringEncoding ))")
        }
    }
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64){
        let uploadProgress: Double = Double(totalBytesSent) / Double(totalBytesExpectedToSend)
        print("session \(session) uploaded \(uploadProgress * 100)%.")
        
    }
    
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveResponse response: NSURLResponse, completionHandler: (NSURLSessionResponseDisposition) -> Void){
        print("session \(session), received response \(response)")
        completionHandler(NSURLSessionResponseDisposition.Allow)
    }
    
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveData data: NSData){
        responseData.appendData(data)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numberOfRowsInSection")
        print(self.predictions.count)
        return self.predictions.count //?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:CustomTableViewCell = self.predictionTable.dequeueReusableCellWithIdentifier("cell") as! CustomTableViewCell
        let rowData: NSDictionary = (self.predictions[indexPath.row] as? NSDictionary)!
        let title = rowData["name"] as?String
        cell.labelGuess.text = title
        
        return cell
        
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //performSegueWithIdentifier("getMap", sender: indexPath)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70;
    }
}

extension NSMutableData {
    func appendString(string: String) {
        let data = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        appendData(data!)
    }
}

extension UIImage {
func imageWithSize(size:CGSize) -> UIImage
{
    var scaledImageRect = CGRect.zero;
    
    let aspectWidth:CGFloat = size.width / self.size.width;
    let aspectHeight:CGFloat = size.height / self.size.height;
    let aspectRatio:CGFloat = min(aspectWidth, aspectHeight);
    
    scaledImageRect.size.width = self.size.width * aspectRatio;
    scaledImageRect.size.height = self.size.height * aspectRatio;
    scaledImageRect.origin.x = (size.width - scaledImageRect.size.width) / 2.0;
    scaledImageRect.origin.y = (size.height - scaledImageRect.size.height) / 2.0;
    
    UIGraphicsBeginImageContextWithOptions(size, false, 0);
    
    self.drawInRect(scaledImageRect);
    
    let scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}
}

