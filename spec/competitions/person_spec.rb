module Competitions
  ::RSpec.describe Person do
    it "understands equality" do
      expect(Person[intelligence: 33, willpower: 20]).to eq(Person[intelligence: 33, willpower: 20])
      expect(Person[intelligence: 33, willpower: 20]).not_to eq(Person[intelligence: 75, willpower: 20])
      expect(Person[intelligence: 33, willpower: 20]).not_to eq(Person[intelligence: 33, willpower: 99])

      expect(Person[intelligence: 33, willpower: 20]).not_to eq(nil)
      expect(Person[intelligence: 33, willpower: 20]).not_to eq(Object)
      expect(Person[intelligence: 33, willpower: 20]).not_to eq(Object.new)
    end

    describe "#in_competition" do
      let(:competition) { instance_double(Competition) }

      it "creates Person::InCompetition" do
        expect(Person[intelligence: 39, willpower: 21].in_competition(competition))
          .to eq(Person::InCompetition[intelligence: 39, willpower: 21, competition: competition])
      end
    end
  end

  class Person
    ::RSpec.describe InCompetition do
      let(:competition) { instance_double(Competition) }
      let(:other_competition) { instance_double(Competition) }

      it "understands equality" do
        expect(InCompetition[intelligence: 33, willpower: 20, competition: competition])
          .to eq(InCompetition[intelligence: 33, willpower: 20, competition: competition])

        expect(InCompetition[intelligence: 33, willpower: 20, competition: competition])
          .not_to eq(InCompetition[intelligence: 33, willpower: 20, competition: other_competition])
      end

      describe "#predicted_rating" do
        let(:person_a) { Person[intelligence: 33, willpower: 20] }
        let(:person_b) { Person[intelligence: 47, willpower: 17] }
        let(:person_c) { Person[intelligence: 39, willpower: 25] }

        let(:competition) do
          Competition.new << person_a << person_b << person_c
        end

        subject { person.in_competition(competition).predicted_rating }

        context "for person_a" do
          let(:person) { person_a }
          it { is_expected.to eq(45.009699999999995) }
        end

        context "for person_b" do
          let(:person) { person_b }
          it { is_expected.to eq(54.99765) }
        end

        context "for person_c" do
          let(:person) { person_c }
          it { is_expected.to eq(52.295) }
        end
      end
    end
  end
end
