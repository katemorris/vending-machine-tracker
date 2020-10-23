require 'rails_helper'

RSpec.describe 'When a user visits a vending machine show page', type: :feature do
  scenario 'they can see the average snack cost' do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")
    doritos = Snack.create(name: 'Doritos', price: 2.50)
    cookies = Snack.create(name: "Grandma's Cookies", price: 2.00)
    MachineSnack.create(snack: doritos, machine: dons)
    MachineSnack.create(snack: cookies, machine: dons)

    visit machine_path(dons)

    expect(page).to have_content("Average Snack Price: $2.25")
  end
end
