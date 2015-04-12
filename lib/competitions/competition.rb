require "set"
require "competitions/person"

module Competitions
  class Person; end

  class SetOf < Contracts::CallableClass
    include Contracts

    def initialize(type)
      @type = type
    end

    Contract Set => Bool
    def valid?(arg)
      arg.all? { |elem| elem.is_a?(@type) }
    end
  end

  class Competition
    include Contracts
    include Enumerable

    class << self; alias_method :[], :new end

    Contract Maybe[ArrayOf[Person]] => self
    def initialize(people=nil)
      Array(people).each do |person|
        self << person
      end
      self
    end

    Contract Person => self
    def <<(person)
      people << person
      self
    end

    Contract Competition => Bool
    def ==(other)
      self.people == other.people
    end

    Contract Any => false
    def ==(_)
      false
    end

    def each(&blk)
      people.each(&blk)
    end

    protected

    Contract None => SetOf[Person]
    def people
      @_people ||= Set.new
    end
  end
end
