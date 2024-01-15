# Ruby on Rails Back End Assessment
# Please get it back to us within 72 hours if possible. If you have any questions please let us know.
# Overview
# This project should take approximately 2 + hours to complete and help PrizePicks assess your Ruby on
# Rails knowledge and development style.
# If you find the project takes longer than you’d like please submit a functional version of what you
# have. We're interested in assessing a functioning project even if all of the business requirements are
# not implemented.
# The Problem
# It's 1993 and you're the lead software developer for the new Jurassic Park! Park operations
# needs a system to keep track of the different cages around the park and the different dinosaurs
# in each one. You'll need to develop a JSON formatted RESTful API to allow the builders to create
# new cages. It will also allow doctors and scientists the ability to edit/retrieve the statuses of
# dinosaurs and cages.
# Business Requirements
# Please attempt to implement the following business requirements:
# • All requests should respond with the correct HTTP status codes and a response, if necessary,
# representing either the success or error conditions.
# • Data should be persisted using some flavor of SQL.
# • Each dinosaur must have a name.
# • Each dinosaur is considered an herbivore or a carnivore, depending on its species.
# • Carnivores can only be in a cage with other dinosaurs of the same species.
# • Each dinosaur must have a species (See enumerated list below, feel free to add others).
# • Herbivores cannot be in the same cage as carnivores.
# • Use Carnivore dinosaurs like Tyrannosaurus, Velociraptor, Spinosaurus and Megalosaurus.
# • Use Herbivores like Brachiosaurus, Stegosaurus, Ankylosaurus and Triceratops.
# Technical Requirements
# The following technical requirements must be met:
# • This project should be done in Ruby on Rails 6 or newer.
# • This should be done using version control, preferably git.
# • The project should include a README that addresses anything you may not have completed. It
# should also address what additional changes you might need to make if the application were
# intended to run in a concurrent environment. Any other comments or thoughts about the
# project are also welcome.
# Bonus Points
# • Cages have a maximum capacity for how many dinosaurs it can hold.
# • Cages know how many dinosaurs are contained.
# • Cages have a power status of ACTIVE or DOWN.
# • Cages cannot be powered off if they contain dinosaurs.
# • Dinosaurs cannot be moved into a cage that is powered down.
# • Must be able to query a listing of dinosaurs in a specific cage.
# • When querying dinosaurs or cages they should be filterable on their attributes (Cages on their
# power status and dinosaurs on species).
# • Automated tests that ensure the business logic implemented is correct.
# Submission Requirements
# Submit a link to a hosted git repository or tarball of the git repository of the finished project to the
# submission link. In addition, Please email the link to the recruiter.

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :cages do
    resources :dinosaurs
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
