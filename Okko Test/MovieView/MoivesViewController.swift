//
//  MoviesViewController.swift
//  Okko Test
//
//  Created by Данила Бондаренко on 02.11.2021.
//

import UIKit
import SnapKit


protocol MoviesViewProtocol {
    var controller: MoviesControllerProtocol? { get set }

    func moviesForGenreAdd(mov: [Movie], id: Int)
    func createSect(id: Int)
    func createDataSource()
    func setupHeaders()
    func tapCell(id: Int)

}

final class MoviesViewController: UIViewController, MoviesViewProtocol {

    var controller: MoviesControllerProtocol?

    var sc: [Int] = [Int]()

    var dataSource: UICollectionViewDiffableDataSource<Int, Movie>?

    var snapshot = NSDiffableDataSourceSnapshot<Int, Movie>()

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())

        collectionView.register(HorizontalCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(ListCell.self, forCellWithReuseIdentifier: "listCell")
        collectionView.register(GridCell.self, forCellWithReuseIdentifier: "gridCell")

        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")

        collectionView.backgroundColor = .purple
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        controller?.getGenres()
        view.backgroundColor = .purple
        setupCollection()
    }

}

extension MoviesViewController {
    func setupCollection() {
        view.addSubview(collectionView)
    }
}

extension MoviesViewController {
    func setupLAyout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 8, bottom: 0, trailing: 8)
        
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7),
                                                     heightDimension: .absolute(view.bounds.height/5))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .continuous
        layoutSection.contentInsets = NSDirectionalEdgeInsets.init(top: 5, leading: 5, bottom: 15, trailing: 5)

        let header = createSectionHeader()
        layoutSection.boundarySupplementaryItems = [header]

        return layoutSection
    }

    func setupListLayout() -> NSCollectionLayoutSection {
          let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
          let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1.0),
          heightDimension: .fractionalWidth(1/3))
        item.contentInsets = .init(top: 5, leading: 2, bottom: 0, trailing: 2)
        let group = NSCollectionLayoutGroup.horizontal(
          layoutSize: groupSize,
          subitem: item,
          count: 1)
          let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 5, leading: 5, bottom: 15, trailing: 5)

        let header = createSectionHeader()
        section.boundarySupplementaryItems = [header]

          return section
    }

    func setupGridLayout() -> NSCollectionLayoutSection {
        let spacing: CGFloat = 1
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 5, leading: 5, bottom: 15, trailing: 5)

        let header = createSectionHeader()
        section.boundarySupplementaryItems = [header]

        return section
    }
}

extension MoviesViewController {

    func createSect(id: Int) {
        sc.append(id)
        snapshot.appendSections([id])
        dataSource?.apply(snapshot)
    }

    func moviesForGenreAdd(mov: [Movie], id: Int) {
        snapshot.appendItems(mov, toSection: id)
        dataSource?.apply(snapshot)
    }

}

extension MoviesViewController {
    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let section = self.sc[sectionIndex]
            
            switch section {
            case 28, 878, 27:
                return self.setupGridLayout()
            case 80, 35, 16:
                return self.setupListLayout()
            default:
                return self.setupLAyout()
            }
        }
        return layout
    }

    func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Int, Movie>(collectionView: collectionView, cellProvider: { (collectionView: UICollectionView, indexPath: IndexPath, movie: Movie) -> UICollectionViewCell? in

            switch movie.genre {
            
            case 28, 878, 27:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gridCell", for: indexPath) as! GridCell
                cell.delegate = self
                cell.configure(with: movie.original_title, image: movie.poster_path, id: movie.id)
                return cell

            case 80, 35, 16:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "listCell", for: indexPath) as! ListCell
                cell.delegate = self
                cell.configure(with: movie.original_title, image: movie.poster_path, id: movie.id)
                return cell
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HorizontalCell
                cell.delegate = self
                cell.configure(with: movie.original_title, image: movie.poster_path, id: movie.id)
                return cell
            }
        })
    }


    func setupHeaders() {
        dataSource?.supplementaryViewProvider = {
                    collectionView, kind, indexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as? SectionHeader else { return nil }
            let numberOfSection = self.controller?.getNameOfGenres(id: self.sc[indexPath.section])
            
            
            sectionHeader.title.text = numberOfSection
            return sectionHeader
        }
    }

    func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionHEaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHEaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return layoutSectionHeader
    }

}

extension MoviesViewController {
    func tapCell(id: Int) {
        controller?.goToInfo(idMovie: id)
    }
}


