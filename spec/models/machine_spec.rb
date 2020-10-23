require 'rails_helper'

RSpec.describe Machine, type: :model do
  describe 'validations' do
    it { should validate_presence_of :location }
  end

  describe 'relationships' do
    it { should belong_to :owner }
    it { should have_many :machine_snacks }
    it { should have_many(:snacks).through(:machine_snacks) }
  end

  describe 'instance variables' do
    it ".average_snack_price" do
      owner = Owner.create(name: "Sam's Snacks")
      dons  = owner.machines.create(location: "Don's Mixed Drinks")
      doritos = Snack.create(name: 'Doritos', price: 2.50)
      cookies = Snack.create(name: "Grandma's Cookies", price: 2.00)
      MachineSnack.create(snack: doritos, machine: dons)
      MachineSnack.create(snack: cookies, machine: dons)

      expect(dons.average_snack_price).to eq(2.25)
    end
  end
end
