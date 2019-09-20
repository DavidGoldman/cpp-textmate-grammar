# frozen_string_literal: true

require 'minitest/autorun'
require 'textmate_grammar'

class PatternTest < MiniTest::Test
    def test_initializer
        assert_equal "abc", Pattern.new("abc").evaluate
        assert_equal "^abc$", Pattern.new(/^abc$/).evaluate
        assert_equal "\\^abc\\$", Pattern.new("^abc$").evaluate
        assert_equal "abc", Pattern.new(Pattern.new("abc")).evaluate
    end

    def test_needs_to_capture
        assert_equal false, Pattern.new("abc").needs_to_capture?
        assert_equal true, Pattern.new(match: "abc", tag_as: "abc").needs_to_capture?
        assert_equal true, Pattern.new(match: "abc", reference: "abc").needs_to_capture?
        assert_equal true, Pattern.new(match: "abc", includes: [:abc]).needs_to_capture?
    end

    def test_evaluate
        r = Pattern.new(
            match: "abc",
        ).to_r

        assert_match r, "abc"
    end

    def test_chaining
        r = Pattern.new(
            match: "abc",
        ).then(/def/).to_r

        assert_match r, "abcdef"
    end
end