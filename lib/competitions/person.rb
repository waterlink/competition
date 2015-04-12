require "competitions/competition"

module Competitions
  class Person
    include Contracts

    class InCompetition < self; end

    class << self; alias_method :[], :new end

    Contract({ intelligence: Num, willpower: Num } => self)
    def initialize(intelligence:, willpower:)
      @intelligence, @willpower = intelligence, willpower
      self
    end

    Contract Person => Bool
    def ==(other)
      [self.intelligence, self.willpower] ==
        [other.intelligence, other.willpower]
    end

    Contract Any => false
    def ==(_)
      false
    end

    Contract Competition => InCompetition
    def in_competition(competition)
      InCompetition[intelligence: intelligence,
                    willpower: willpower,
                    competition: competition]
    end

    protected

    Contract None => Num
    attr_reader :intelligence

    Contract None => Num
    attr_reader :willpower

    private

    class InCompetition < self
      Contract({ intelligence: Num, willpower: Num, competition: Competition } => self)
      def initialize(intelligence:, willpower:, competition:)
        @competition = competition
        super(intelligence: intelligence, willpower: willpower)
      end

      Contract InCompetition => Bool
      def ==(other)
        super && self.competition == other.competition
      end

      Contract Any => false
      def ==(_)
        false
      end

      Contract None => Num
      def predicted_rating
        affected_intelligence + 0.5 * affected_willpower
      end

      protected

      Contract None => Competition
      attr_reader :competition

      private

      Contract None => Num
      def affected_intelligence
        intelligence * (1.03 ** more_intelligent_opponent_count)
      end

      Contract None => Num
      def affected_willpower
        willpower * (0.97 ** less_intelligent_opponent_count)
      end

      Contract None => Integer
      def more_intelligent_opponent_count
        competition.select(&method(:more_intelligent?)).count
      end

      Contract Person => Bool
      def more_intelligent?(other)
        self.intelligence < other.intelligence
      end

      Contract None => Integer
      def less_intelligent_opponent_count
        competition.select(&method(:less_intelligent?)).count
      end

      Contract Person => Bool
      def less_intelligent?(other)
        self.intelligence > other.intelligence
      end
    end
  end
end
