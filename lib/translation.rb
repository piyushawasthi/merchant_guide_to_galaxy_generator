class Translation
	attr_accessor :pattern
	# This Data Structure stores all assignments of galactic words to their Roman Symbol
	#e.f glob => I, prok => V
	@@galactic_words_roman_symbol_assignments = {}
	def self.galactic_words_roman_symbol_assignments
		@@galactic_words_roman_symbol_assignments
	end

	#Constraints of Substrations
	#"I" can be subtracted from "V" and "X" only. 
	#"X" can be subtracted from "L" and "C" only.
	#"C" can be subtracted from "D" and "M" only.
	#"V", "L", and "D" can never be subtracted.
	#Only one small-value symbol may be subtracted from any large-value symbol.
	@@valid_substractions_in_order = [ #Constructing patterns High to Low
		["M",1000],
		["CM",900],
		["D",500],
		["CD",400],
		["C",100],
		["XC",90],
		["L",50],
		["XL",40],
		["X",10],
		["IX",9],
		["V",5],
		["IV",4],
		["I",1]
	]

	def initialize(pattern)
		@pattern = pattern
	end

	def to_s
		@pattern
	end

	# In main part of the question get all galactic words e.g from glob prok Silver ? it would return glob prok
	def self.translate_question(question)
		galactic_words = []
		question.split.each do |literal|
			@@galactic_words_roman_symbol_assignments.keys.include?(literal) ? (galactic_words << literal ) : (break if galactic_words.size > 0)
		end
		if galactic_words.size > 0
			str = Translation.new(galactic_words.join(' '))
			return (str.is_valid? ? str : nil)
		end
		return nil
	end

	#Given Roman String it can convert to Numeral
	def roman_symbols_to_numeral(roman_string)
		sum = 0
		for key, value in @@valid_substractions_in_order
			while roman_string.index(key)==0
				sum += value
				roman_string.slice!(key)
			end
		end
		sum
	end
	#Given Galactic Words it can convert to Roman
	def galactic_words_to_roman # returns roman representaion 
		@pattern.split.map{ |e|  @@galactic_words_roman_symbol_assignments[e] }.join
	end
	#Given a Galactic words it can convert to Numeral
	#Algo is to convert galactic words to roman first and then from roman symbols to numeral finally
	def galactic_words_to_numeral
		roman_symbols_to_numeral(galactic_words_to_roman)
	end

	def valid_pattern?
		!(galactic_words_to_roman.match(/^M*(CM|CD|D?C{0,3})(XC|XL|L?X{0,3})(IX|IV|V?I{0,3})$/).nil?)
	end

	def is_valid?
		invalid_literals = @pattern.split.detect { |e|  !@@galactic_words_roman_symbol_assignments.keys.include? e }
		!invalid_literals && valid_pattern?
	end
end