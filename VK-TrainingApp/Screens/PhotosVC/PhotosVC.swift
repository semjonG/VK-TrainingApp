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
    
}

extension PhotosVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    
}
