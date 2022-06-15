//
//  FriendPhotosVC.swift
//  VK-TrainingApp
//
//  Created by mac on 14.06.2022.
//

import UIKit

class PhotosVC: UIViewController {
    
    var photosAPI = PhotosAPI()
    
    var photosArray: Array<Photo> = []
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView()
        
        collectionView.delegate = self // кладем во внутренн переменную контроллер (для тобо чтобы можно было вызвать у контроллера методы CollectionView)
        collectionView.dataSource = self
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        fetchPhotos()
        
    }
    
    private func fetchPhotos(offset: Int = 0) {
        
        photosAPI.fetchPhotos(offset: 0) { result in
            switch result {
            case .success(let photos):
                self.photosArray.append(contentsOf: photos)
            case .failure(_):
                print("cant append pics to array")
            }
        }
    }
}

extension PhotosVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        print("нажатие", indexPath.row)
    }
}

extension PhotosVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionCell.identifier, for: indexPath) as! PhotoCollectionCell
        
        let photo = photosArray[indexPath.row]
        cell.configure(photo)
        return cell
    }
}
