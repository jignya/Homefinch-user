//
//  PDFViewController.swift
//  HomeFinch-CustomerApp
//
//  Created by Mac on 7/5/21.
//

import UIKit
import PDFKit


class PDFViewController: UIViewController {
    var pdfView = PDFView()
    var pdfURL: URL!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(pdfView)
        if let document = PDFDocument(url: pdfURL) {
            pdfView.document = document
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    override func viewDidLayoutSubviews() {
        pdfView.frame = view.frame
    }
}
