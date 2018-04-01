//
//  AttachmentDetailViewController.swift
//  fyp
//
//  Created by Rameez Hasan on 12/24/17.
//  Copyright © 2017 AnyCart. All rights reserved.
//

import UIKit
import UXMPDFKit

class AttachmentDetailViewController: UIViewController {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var attachmentImageView: UIImageView!
    
    @IBOutlet var pdfCollectionView:PDFSinglePageViewer!
    
    public var teacherName = String()
    public var descriptionText = String()
    public var pdfName = String()
    
    var toLoadPdfPage = Int()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setNavigationBarUI()
        toLoadPdfPage = 1
        self.descriptionLabel.text = descriptionText
        if pdfName.contains(".pdf")
        {
//            self.attachmentImageView.isHidden = true
            self.pdfCollectionView.isHidden = false
        }
        loadThePDF()

    }
    
    // MARK: - Navigation bar Ui
    
    func setNavigationBarUI()
    {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.setHidesBackButton(false, animated:true)
        
        let navigationBarLabel =  UILabel()
        navigationBarLabel.frame = CGRect(x: 0, y: 0, width: 200, height: 30)
        navigationBarLabel.textColor = UIColor(red: 201/255, green: 222/255, blue: 224/255, alpha: 1)
        navigationBarLabel.backgroundColor = UIColor.clear
        navigationBarLabel.textAlignment = .center
        navigationBarLabel.text = self.teacherName
        self.navigationItem.titleView = navigationBarLabel
    }
    
    func loadThePDF()
    {
//        let fileManager = FileManager.default
//        let directoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
//        let destURL = directoryURL.appendingPathComponent(pdfName)
//        if pdfName.contains(".pdf")
//        {
        let path = Bundle.main.path(forResource: "ep18pros", ofType: "pdf")!
            let document = try! PDFDocument(filePath: path, password: "")
            self.pdfCollectionView.document = document
            self.pdfCollectionView.singlePageDelegate = self
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension AttachmentDetailViewController: PDFSinglePageViewerDelegate
{
    func singlePageViewer(_ collectionView: PDFSinglePageViewer, selected annotation: PDFAnnotationView){
        
    }
    
    // MARK: - UXMPDF Delegates
    
    func singlePageViewer(_ collectionView: PDFSinglePageViewer, didDisplayPage page: Int)
    {
        toLoadPdfPage = page
    }
    
    func singlePageViewer(_ collectionView: PDFSinglePageViewer, loadedContent content: PDFPageContentView)
    {
    }
    
    func singlePageViewer(_ collectionView: PDFSinglePageViewer, selected action: PDFAction)
    {
    }
    
    func singlePageViewer(_ collectionView: PDFSinglePageViewer, tapped recognizer: UITapGestureRecognizer)
    {
        
    }
    func singlePageViewerDidBeginDragging()
    {
        
    }
    func singlePageViewerDidEndDragging()
    {
        
    }
}
