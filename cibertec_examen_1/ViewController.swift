//
//  ViewController.swift
//  cibertec_examen_1
//
//  Created by Global66 on 2/10/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = users[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = user.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let userSelected = users[indexPath.row]
        
        let alert = UIAlertController(title: "Aviso",
                                      message: "Se ha creado el usuario con nombre '\(userSelected.name!)'",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        
        present(alert, animated: true)
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var users = [User]()
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Administrador de Usuarios"
        
        view.addSubview(tableView)
        getAllUsers()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(didTapAdd))
    }
    
    @objc private func didTapAdd() {
        let alert = UIAlertController(title: "Nuevo Usuario",
                                      message: "Ingresa al nuevo usuario",
                                      preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: nil)

        alert.addAction(UIAlertAction(title: "Crear usuario", style: .cancel, handler: { [weak self]_ in
            guard let nameField = alert.textFields?.first, let name = nameField.text, !name.isEmpty else {
                return
            }

            self?.createUser(name: name)
        }))
        
        present(alert, animated: true)
    }
    
    func getAllUsers() {
        do {
            users = try context.fetch(User.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            // catch error
        }
    }
    
    func createUser(name: String) {
        let newUser = User(context: context)
        
        // Poblando el usuario
        newUser.name = name
        newUser.email = "\(name)@cibertec.edu.pe"
        newUser.age = 20
        
        do {
            try context.save()
            getAllUsers()
        } catch {
            // error
        }
    }
    
    func deleteUser(user: User) {
        context.delete(user)
        
        do {
            try context.save()
        } catch {
            // error
        }
    }
}

