//
//  ViewController.swift
//  Project3
//
//  Created by Vlad Maevsky on 16.09.21.
//

import UIKit

class ViewController: UIViewController {
    
    let urlString = "https://loremflickr.com/200/200/"
    let spacingBetweenItems: CGFloat = 2
    let itemsPerRow: CGFloat = 7
    let itemsPerColumn: CGFloat = 10
    
    @IBOutlet var collectionView: UICollectionView!

    var widthPerItem: CGFloat = 0
    var photos = [UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func downloadImageFrom(url: String) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let data = data, let image = UIImage(data: data) {
                    self.photos.append(image)
                    let index = self.photos.firstIndex(of: image)!
                    self.collectionView.insertItems(at: [IndexPath(item: index, section: 0)])
                }
            }
        }.resume()
    }
    
    @IBAction private func addNewImage(_ sender: UIBarButtonItem) {
        downloadImageFrom(url: urlString)
    }
    
    @IBAction private func reloadAll(_ sender: UIBarButtonItem) {

        photos = [UIImage]()
        collectionView.reloadData()
        
        for _ in 0..<140 {
            downloadImageFrom(url: urlString)
        }
    }

}

//MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! ImageCollectionViewCell
        
        cell.activityIndicator.startAnimating()
        cell.imageView.image = self.photos[indexPath.item]
        cell.activityIndicator.stopAnimating()
        
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingWidth = spacingBetweenItems * (itemsPerRow - 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let paddingHeight = spacingBetweenItems * (itemsPerColumn - 1)
        let availableHeight = collectionView.frame.height - paddingHeight
        let bottomInset = availableHeight - (widthPerItem * itemsPerColumn)
        
        return UIEdgeInsets(top: 0, left: 0, bottom: bottomInset, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacingBetweenItems
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spacingBetweenItems
    }
}

