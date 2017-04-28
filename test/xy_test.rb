lib = File.expand_path('.././lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'xy'

CHART_TYPES = [:bar, :spark, :block]

N = 10

class XyTest < Minitest::Test
  def test_empty_array
    puts "\n\n"
    puts XY.chart :bar, []
    puts XY.chart :spark, []
    puts XY.chart :block, []
  end

  def test_bar_chart
    N.times do
      puts "\n\n"
      size = 4 + rand(32)
      arr = size.times.map { rand(16)**2 }
      puts XY.chart :bar, arr
    end
  end

  def test_spark_chart
    N.times do
      puts "\n\n"
      size = 4 + rand(32)
      arr = size.times.map { rand(16)**2 }
      puts XY.chart :spark, arr
    end
  end

  def test_block_chart
    N.times do
      puts "\n\n"
      size = 4 + rand(32)
      arr = size.times.map { rand(16)**2 }
      puts XY.chart :block, arr
    end
  end

  def test_nan_values
    puts "\n\n"
    puts XY.chart :bar, [0, 0]
    puts XY.chart :spark, [0, -32, -512]
    puts XY.chart :block, [-32, -32]
  end

  def test_negative_values
    N.times do
      puts "\n\n"
      size = 4 + rand(32)
      arr = size.times.map { 0 - rand(16)**2 }
      puts XY.chart CHART_TYPES.sample, arr
    end
  end
end
