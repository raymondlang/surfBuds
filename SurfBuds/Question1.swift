//
//  Question1.swift
//  SurfBuds
//
//  Created by Raymond Lang on 1/28/23.
//

import SwiftUI

class QuizViewController: UIViewController {

    // MARK: - Properties
    let questionLabel = UILabel()
    let answer1Button = UIButton(type: .system)
    let answer2Button = UIButton(type: .system)
    let answer3Button = UIButton(type: .system)
    let answer4Button = UIButton(type: .system)

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    
// MARK: - Setup View
    func setupView() {
        // Setup question label
        questionLabel.text = "How long have you been surfing?"
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(questionLabel)

        // Setup answer buttons
        answer1Button.setTitle("Less than a year!", for: .normal)
        answer1Button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(answer1Button)

        answer2Button.setTitle("1-5 years", for: .normal)
        answer2Button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(answer2Button)

        answer3Button.setTitle("5-10 years", for: .normal)
        answer3Button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(answer3Button)

        answer4Button.setTitle("More than 10 years", for: .normal)
        answer4Button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(answer4Button)

        // Add constraints
        NSLayoutConstraint.activate([
            questionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            questionLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),

            answer1Button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            answer1Button.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 20),

            answer2Button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            answer2Button.topAnchor.constraint(equalTo: answer1Button.bottomAnchor, constant: 20),

            answer3Button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            answer3Button.topAnchor.constraint(equalTo: answer2Button.bottomAnchor, constant: 20),

            answer4Button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            answer4Button.topAnchor.constraint(equalTo: answer3Button.bottomAnchor, constant: 20)
        ])
    }
}

import SwiftUI

struct QuizView: View {
    var body: some View {
        QuizViewControllerRepresentable()
    }
}

struct QuizViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> QuizViewController {
        QuizViewController()
    }

    func updateUIViewController(_ uiViewController: QuizViewController, context: Context) {
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView()
    }
}


class PreviewViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let quizViewController = QuizViewController()
        addChild(quizViewController)
        view.addSubview(quizViewController.view)
        quizViewController.didMove(toParent: self)
    }
}

//let previewViewController = PreviewViewController()
//present(previewViewController, animated: true, completion: nil)

