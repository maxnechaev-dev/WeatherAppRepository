//
//  ViewController.swift
//  WeatherApp
//
//  Created by Max Nechaev on 09.09.2021.
//

import UIKit

protocol MainViewOutput {
    func fetchArrayOfCities(array: [String])
    var cellID: String { get set }
    var cities: [Weather]? { get set }
    func cellForItemAt(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    func userSelect(element: Weather, navigationController: UINavigationController)
    func searchBarClicked(_ searchBar: UISearchBar)
    func sizeForItemAt(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize 
}

class MainViewController: UIViewController {
    
    let data = DataForApp()
    var defaultCities: [String] = []
    var output: MainViewOutput

    
    //MARK: - Create views

    lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.register(MainCustomCell.self, forCellWithReuseIdentifier: output.cellID)
        collectionview.backgroundColor = .mainBackgroundColor()
        
        return collectionview
    }()
    
    let cartoonImageView = UIImageView(image: UIImage(named: "cartoon"), contentMode: .scaleAspectFit)
    let greetingsLabel = UILabel(text: "", font: .systemFont(ofSize: 25, weight: .light), textColor: .mainTextColor())
    
    lazy var searchBar: UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 200, height: 20))


    //MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainBackgroundColor()
        setupData()
        setupConstraints()
        setupNavigationController()
        collectionView.isHidden = true
        setupSearchBar()
        
        output.fetchArrayOfCities(array: defaultCities)
    }
    
    //MARK: - init
    
    init(output: MainViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    //MARK: - Functions

    private func setupNavigationController() {
        navigationController?.navigationBar.barTintColor = .mainBackgroundColor()
    }
    
    private func setupData() {
        defaultCities = data.defaultCities
        greetingsLabel.text = data.greetingsLabelText
    }
    
    private func setupSearchBar() {
        searchBar.placeholder = "Your placeholder"
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "Enter city name"
        self.navigationItem.titleView = searchBar
        
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = .mainTextColor()
    }
    
    func setupAlertController() {
        let alert = UIAlertController(title: "Incorrect city name", message: "Please make sure, that name of the city is right. It should be in english. ", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - UICollectionViewDelegate

extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cities = output.cities else { return }
        let cityWeather = cities[indexPath.row]
        
        if let navigationController = navigationController {
            output.userSelect(element: cityWeather, navigationController: navigationController)
        }
    }
}

//MARK: - UICollectionViewDataSource

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        output.cities?.count ?? 0
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        output.cellForItemAt(collectionView, cellForItemAt: indexPath)
    }
}

//MARK: - Setup Constraints

extension MainViewController {
    func setupConstraints() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(cartoonImageView)
        cartoonImageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(greetingsLabel)
        greetingsLabel.translatesAutoresizingMaskIntoConstraints = false
        greetingsLabel.numberOfLines = 0
        greetingsLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            cartoonImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            cartoonImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cartoonImageView.widthAnchor.constraint(equalToConstant: 300),
            cartoonImageView.heightAnchor.constraint(equalToConstant: 300),
        ])
        
        NSLayoutConstraint.activate([
            greetingsLabel.topAnchor.constraint(equalTo: cartoonImageView.bottomAnchor, constant: 30),
            greetingsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            greetingsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            greetingsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
        ])
    }
}

//MARK: - Setup flowlayout

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        output.sizeForItemAt(collectionView, layout: collectionViewLayout, sizeForItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 10, left: 20, bottom: 20, right: 20)
    }
}


//MARK: - UISearchBarDelegate

extension MainViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        output.searchBarClicked(searchBar)
    }
}
