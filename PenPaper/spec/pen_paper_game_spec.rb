require 'spec_helper'
require_relative '../pen_paper_game'

describe PenAndPaperGame do
  describe "#initialize" do
    context "without input argument" do
      it "initiazizes with size 5" do
        pen_paper = PenAndPaperGame.new
        expect(pen_paper.grid_size).to eq 5
        expect(pen_paper.all_paths).to be_a(Set)
      end
    end
    
    context "with input argument" do
      it "initiazizes with size 6" do
        pen_paper = PenAndPaperGame.new({size: 6})
        expect(pen_paper.grid_size).to eq 6
      end
    end
  end
  let(:pen_paper){ PenAndPaperGame.new }
  describe "#valid_position?" do
    context "with 4,4 arguments" do
      it "is valid position" do
        result = pen_paper.send :valid_position?, 4, 4
        expect(result).to be true
      end
    end
    
    context "with 5,4 arguments" do
      it "is invalid position" do
        result = pen_paper.send :valid_position?, 5, 4
        expect(result).not_to be true
      end
    end
  end
  
  describe "#jump" do
    context "with initial position at(2,2)" do
      it "can jump to 4 new positions" do
        expect{|b| pen_paper.send :jump, 2, 2, &b }.to yield_control.exactly(4).times
        expect{|b| pen_paper.send :jump, 2, 2, &b }.to yield_successive_args( [4, 4], [4, 0], [0, 4], [0, 0])
      end
    end
    
    context "with initial position at(0,4)" do
      it "can jump to 4 new positions" do
        expect{|b| pen_paper.send :jump, 0, 4, &b }.to yield_control.exactly(3).times
        expect{|b| pen_paper.send :jump, 0, 4, &b }.to yield_successive_args( [3,4],[0, 1], [2,2])
      end
    end
    
  end
  
  describe "#solve_it" do
    context "with start point at (3,3)" do
      it "can fill the whole board" do
        pen_paper.send :set_start_point, 3,3
        result = pen_paper.send :solve_it, [[[3,3]]]
        expect(result.size).to eq 25
      end
    end
  end
  
end