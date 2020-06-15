//
//  GameStoreController.swift
//  CompostionalDiffableApp
//
//  Created by yongzhan on 2020/6/15.
//  Copyright © 2020 yongzhan. All rights reserved.
//

import SwiftUI

class MainViewController: UIViewController {
    
    var games: [Game] = []
    lazy var gameStore = GameStore.shared
    
    var collectionView : UICollectionView! = nil
    
    var sections:[SectionLayoutKind] = []
    
    var selectedGenres: Set<GenerType> = []
    var selectedPlatfrom: Set<PlatformType> = []
    var selectedSort: SortType = .popularity
    
    var dataSource: UICollectionViewDiffableDataSource<SectionLayoutKind, Item>! = nil
    
    override func viewDidLoad() {
        
        configureCollectionView()
        configureDataSource()
        self.loadGames()
        
        
        
    }
    
    private func loadGames() {
        gameStore.fetchGame(with: .games) { (result) in
            switch result{
            case .success(let games):
                DispatchQueue.main.async { [weak self] in
                    self?.games = games
                    self?.updateUI()
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func updateUI(){
        let snapshots = createSnapShots()
        dataSource.apply(snapshots, animatingDifferences: true)
    }
    
    // MARK: - DataSource
    private func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<SectionLayoutKind, Item>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            switch item.itemType {
            case .genre(let type as CustomStringConvertible, let isSelected),
                 .platfrom(let type as CustomStringConvertible, let isSelected),
                 .sort(let type as CustomStringConvertible, let isSelected):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BageItemCollectionViewCell.reusedId, for: indexPath) as! BageItemCollectionViewCell
                cell.configure(text: type.description, isSelected: isSelected)
                return cell
                
            case .game(let game):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameItemCollectionViewCell.reusedId, for: indexPath) as! GameItemCollectionViewCell
                cell.configure(game: game)
                return cell
            }
        })
        
        let snapShots = createSnapShots()
        dataSource.apply(snapShots, animatingDifferences: false)
        
    }
    
    
    private func createSnapShots() -> NSDiffableDataSourceSnapshot<SectionLayoutKind, Item> {
        var snapShots = NSDiffableDataSourceSnapshot<SectionLayoutKind, Item>()
        var sections = [SectionLayoutKind]()
        
        // genre
        let genreSectionKind = createGenreSectionKind()
        snapShots.appendSections([genreSectionKind])
        snapShots.appendItems(genreSectionKind.kind.items)
        sections.append(genreSectionKind)
        
        // platform
        let platfromSectionKind = createPlatformSectionKind()
        snapShots.appendSections([platfromSectionKind])
        snapShots.appendItems(platfromSectionKind.kind.items)
        sections.append(platfromSectionKind)
        
        
        // games
        let sortSectionKind = createSortSectionKind()
        snapShots.appendSections([sortSectionKind])
        snapShots.appendItems(sortSectionKind.kind.items)
        sections.append(sortSectionKind)
        
        let gameSectionKind = createGameSection()
        snapShots.appendSections([gameSectionKind])
        snapShots.appendItems(gameSectionKind.kind.items)
        sections.append(gameSectionKind)
        
        self.sections = sections
        return snapShots
    }
    
    private func createGameSection() -> SectionLayoutKind {
        var games: [Game]
        games = self.games
        return SectionLayoutKind(kind: GameSection(items: games.map{ Item(itemType: .game($0) )}))
    }
    
    // SortSection
    private func createSortSectionKind() -> SectionLayoutKind {
        let items = SortType.allCases.map{ s -> Item in
            let isSelected = self.selectedSort == s
            return Item(itemType: .sort(type: s, isSelected: isSelected))
        }
        return SectionLayoutKind(kind: SortSection(items: items))
    }
    
    
    // PlatformSection
    private func createPlatformSectionKind() -> SectionLayoutKind {
        let items = PlatformType.allCases.map{ p ->Item in
            let isSelected: Bool
            switch p {
            case .all:
                isSelected = self.selectedPlatfrom.isEmpty ? true : false
            default:
                isSelected = self.selectedPlatfrom.contains(p)
            }
            return Item(itemType: .platfrom(type: p, isSelected: isSelected))
        }
        
        return SectionLayoutKind(kind: PlatfromSection(items: items))
    }
    
    // GenreSection
    private func createGenreSectionKind() -> SectionLayoutKind {
        let items = GenerType.allCases.map{ g ->Item in
            let isSelected: Bool
            switch g {
            case .all:
                isSelected = self.selectedGenres.isEmpty ? true : false
            default:
                isSelected = self.selectedGenres.contains(g)
            }
            return Item(itemType: .genre(type: g, isSelected: isSelected))
        }
        
        return SectionLayoutKind(kind: GenerSection(items: items))
    }
    
    // MARK: - CollectionView
    private func configureCollectionView() {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        
        view.addSubview(collectionView)
        
        collectionView.register(BageItemCollectionViewCell.self, forCellWithReuseIdentifier: BageItemCollectionViewCell.reusedId)
        collectionView.register(GameItemCollectionViewCell.self, forCellWithReuseIdentifier: GameItemCollectionViewCell.reusedId)
        
        collectionView.backgroundColor = .systemBackground
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.collectionView = collectionView
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (selctionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            guard !self.sections.isEmpty else {
                return nil
            }
            switch self.sections[selctionIndex].kind {
                
            case is GenerSection, is PlatfromSection, is SortSection:
                
                let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(150), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(150), heightDimension: .absolute(40))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 8
                section.contentInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)
                section.orthogonalScrollingBehavior = .continuous
                
                return section
                
            case is GameSection:
                
                let imageWidth:CGFloat = 150
                let imageMutipler = 200.0 / imageWidth
                
                let containerWidth = layoutEnvironment.container.effectiveContentSize.width
                let itemCount = containerWidth / imageWidth
                let itemWidth = imageWidth * (itemCount / ceil(itemCount))
                let itemHeight = itemWidth * imageMutipler
                
                
                let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(itemWidth), heightDimension: .absolute(itemHeight))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(itemHeight))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                
                return section
                
            default:
                return nil
                
            }
            
        }
        return layout
    }
    
    
}






struct GameStoreController: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) ->  UIViewController {
        let controller = UINavigationController(rootViewController:  MainViewController())
        return controller
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}

struct GameStoreController_Previews: PreviewProvider {
    static var previews: some View {
        GameStoreController()
    }
}
