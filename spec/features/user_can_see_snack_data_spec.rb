require 'rails_helper'

RSpec.describe 'When a user visits a snack show page', type: :feature do
  scenario 'they can see the snack info' do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")
    doritos = Snack.create(name: 'Doritos', price: 2.50)
    cookies = Snack.create(name: "Grandma's Cookies", price: 2.00)
    MachineSnack.create(snack: doritos, machine: dons)
    MachineSnack.create(snack: cookies, machine: dons)

    kate = Owner.create(name: "Kate Tester")
    tiny  = kate.machines.create(location: "Tiny Snacks")
    jerky = Snack.create(name: "Slim Jim", price: 4.00)
    MachineSnack.create(snack: doritos, machine: tiny)
    MachineSnack.create(snack: cookies, machine: tiny)
    MachineSnack.create(snack: jerky, machine: tiny)

    visit snack_path(cookies)

    within('.snack-info') do
      expect(page).to have_content(cookies.name)
      expect(page).to have_content(cookies.price)
    end

    within('.locations') do
      expect(page).to have_content(dons.location)
      expect(page).to have_content(tiny.location)
      expect(page).to have_content(tiny.average_snack_price)
      expect(page).to have_content(dons.snacks.count)
    end
  end
end
