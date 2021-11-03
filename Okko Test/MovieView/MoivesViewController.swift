//
//  MoviesViewController.swift
//  Okko Test
//
//  Created by Данила Бондаренко on 02.11.2021.
//

import UIKit
import SnapKit

//Actions
enum MoviesViewAction {
    case moviesForGenreAdd(mov: [Movie], id: Int)
    case createSect(id: Int)
    case createDataSource
    case setupHeaders
    case updateTitleHeader(newTitle: String)
    case tapCell(id: Int)
}

protocol MoviesViewProtocol {
    var controller: MoviesControllerProtocol? { get set }

    func action(with: MoviesViewAction)
}

final class MoviesViewController: UIViewController, MoviesViewProtocol {

    var controller: MoviesControllerProtocol?

    var sc: [Int] = [Int]()

    var headetTitle: String?


    var dataSource: UICollectionViewDiffableDataSource<Int, Movie>?

    var snapshot = NSDiffableDataSourceSnapshot<Int, Movie>()


    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())

        collectionView.register(HorizontalCell.self, forCellWithReuseIdentifier: NSStringFromClass(HorizontalCell.self))
        collectionView.register(ListCell.self, forCellWithReuseIdentifier: NSStringFromClass(ListCell.self))
        collectionView.register(GridCell.self, forCellWithReuseIdentifier: NSStringFromClass(GridCell.self))

        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")

        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "MOVIES"
        controller?.getGenres()
        view.backgroundColor = .purple
        setupCollection()
    }

    func action(with: MoviesViewAction) {
        switch with {
        case .moviesForGenreAdd(let mov, let id):
            moviesForGenreAdd(mov: mov, id: id)
        case .createSect(let id):
            createSect(id: id)
        case .createDataSource:
            createDataSource()
        case .setupHeaders:
            setupHeaders()
        case .tapCell(let id):
            tapCell(id: id)
        case .updateTitleHeader(let newTitle):
            updateTitleHeader(newTitle: newTitle)
        }
    }

}

//MARK: Setup CollectionView
extension MoviesViewController {
    func setupCollection() {
        view.addSubview(collectionView)
        collectionView.backgroundColor = .purple
    }
}

//MARK: - Layout types
extension MoviesViewController {
    func setupLAyout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 8, bottom: 0, trailing: 8)
        
        
        let layoutGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.7),
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
        item.contentInsets = .init(top: 5, leading: 2, bottom: 0, trailing: 2)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(1/3))
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
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 5, leading: 2, bottom: 0, trailing: 2)

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

//MARK: - Append sections and Movies
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

//MARK: - Create layouts and Datasource
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
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(GridCell.self), for: indexPath) as! GridCell
                cell.delegate = self
                cell.configure(with: movie.original_title, image: movie.poster_path, id: movie.id)
                return cell

            case 80, 35, 16:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(ListCell.self), for: indexPath) as! ListCell
                cell.delegate = self
                cell.configure(with: movie.original_title, image: movie.poster_path, id: movie.id)
                return cell
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(HorizontalCell.self), for: indexPath) as! HorizontalCell
                cell.delegate = self
                cell.configure(with: movie.original_title, image: movie.poster_path, id: movie.id)
                return cell
            }
        })
    }

}

//MARK: - Headers Settings
extension MoviesViewController {

    func updateTitleHeader(newTitle: String) {
        self.headetTitle = newTitle
    }

    func setupHeaders() {
        dataSource?.supplementaryViewProvider = {
                    collectionView, kind, indexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as? SectionHeader else { return nil }

            self.controller?.action(with: .getNameOfGenres(id: self.sc[indexPath.section]))
            let num = self.headetTitle

            sectionHeader.title.text = num
            return sectionHeader
        }
    }

    func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionHEaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHEaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return layoutSectionHeader
    }
}
//MARK: - Jump to info of movie
extension MoviesViewController {
    func tapCell(id: Int) {
        controller?.goToInfo(idMovie: id)
    }
}


