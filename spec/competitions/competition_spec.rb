module Competitions
  ::RSpec.describe Competition do
    let(:person_a) { instance_double(Person) }
    let(:person_b) { instance_double(Person) }
    let(:person_c) { instance_double(Person) }

    it "understands equality" do
      expect(Competition[[person_a, person_b, person_c]])
        .to eq(Competition[[person_a, person_b, person_c]])

      expect(Competition[[person_a, person_b, person_c]])
        .to eq(Competition[[person_a, person_c, person_b, person_c]])

      expect(Competition[[person_a, person_b, person_c]])
        .not_to eq(Competition[[person_a, person_c]])

      expect(Competition[[person_a, person_b, person_c]]).not_to eq(nil)
      expect(Competition[[person_a, person_b, person_c]]).not_to eq(Object)
      expect(Competition[[person_a, person_b, person_c]]).not_to eq(Object.new)
    end

    it "is enumerable" do
      expect(Competition).to be < Enumerable

      expect(Competition[[person_a, person_b, person_c]].select { |p| p != person_c })
        .to eq([person_a, person_b])
    end
  end
end
